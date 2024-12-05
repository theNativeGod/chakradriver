import 'dart:async';

import 'package:chakracabsrider/models/driver_model.dart';
import 'package:chakracabsrider/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:new_pinput/new_pinput.dart';

import '../../../view_models/profile_provider.dart';
import '../../widgets/export.dart';

class PhoneVerifyScreen extends StatefulWidget {
  const PhoneVerifyScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  final String verificationId;
  final String phoneNumber;

  @override
  State<PhoneVerifyScreen> createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  late String _verificationId;
  bool _isResendAllowed = false;
  Timer? _timer;
  int _resendCountdown = 60;

  @override
  void initState() {
    super.initState();
    _verificationId = widget.verificationId;
    startResendCountdown();
  }

  void startResendCountdown() {
    setState(() {
      _isResendAllowed = false;
      _resendCountdown = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _isResendAllowed = true;
          timer.cancel();
        }
      });
    });
  }

  Future<void> verifyOtp() async {
    final otp = _otpController.text.trim();

    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the OTP")),
      );
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);

      // Fetch driver details from Firestore
      final driverSnapshot = await FirebaseFirestore.instance
          .collection('drivers')
          .where('fullPhoneNumber', isEqualTo: widget.phoneNumber)
          .limit(1)
          .get();

      if (driverSnapshot.docs.isNotEmpty) {
        final driverData = driverSnapshot.docs.first.data();
        final driver = Driver.fromMap(driverSnapshot.docs.first.id, driverData);

        // Update ProfileProvider
        Provider.of<ProfileProvider>(context, listen: false).driver = driver;

        // Navigate to the MainScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Driver details not found.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP. Please try again.")),
      );
    }
  }

  Future<void> resendCode() async {
    if (_isResendAllowed) {
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: widget.phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to resend code: ${e.message}")),
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            setState(() {
              _verificationId = verificationId;
            });
            startResendCountdown();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("OTP code resent successfully.")),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Failed to resend code. Please try again.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size size = mediaQueryData.size;
    double height = size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeadingText(text: 'Phone Verification'),
                      SizedBox(height: height * .06),
                      const AuthPurposeText(text: 'Enter Your OTP code'),
                      const SizedBox(height: 24),
                      OtpInput(controller: _otpController),
                      SizedBox(height: height * .07),
                      AuthButton(
                        onTap: verifyOtp,
                      ),
                      SizedBox(height: height * .08),
                      Text(
                        'Didn\'t receive code?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: _isResendAllowed ? resendCode : null,
                        child: Row(
                          children: [
                            Text(
                              'Resend code'.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: _isResendAllowed
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                            ),
                            const SizedBox(width: 8),
                            if (!_isResendAllowed)
                              Text(
                                '($_resendCountdown s)',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.grey),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * .3,
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset('assets/images/Plants.png'),
                      Image.asset('assets/images/Character.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;

  const OtpInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return Pinput(
      controller: controller,
      defaultPinTheme: defaultPinTheme,
      length: 6,
      keyboardType: TextInputType.number,
    );
  }
}
