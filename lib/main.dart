import 'package:chakracabsrider/view_models/bottom_sheet_model.dart';
import 'package:chakracabsrider/view_models/location_view_model.dart';
import 'package:chakracabsrider/view_models/ride_requests_provider.dart';
import 'package:chakracabsrider/view_models/signup_provider.dart';
import 'package:chakracabsrider/views/auth_screens/login_screen/login_screen.dart';
import 'package:chakracabsrider/views/driver_car/driver_car.dart';
import 'package:chakracabsrider/views/driver_details/driver_details_screen.dart';
import 'package:chakracabsrider/views/driver_earn_screen/driver_earn_screen.dart';
import 'package:chakracabsrider/views/home_screen/home_screen.dart';
import 'package:chakracabsrider/views/ride_requests_screen/ride_requests_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SignupProvider()),
        ChangeNotifierProvider(create: (ctx) => LocationViewModel()),
        ChangeNotifierProvider(create: (ctx) => BottomSheetModel()),
        ChangeNotifierProvider(create: (ctx) => RideProvider()),
      ],
      child: MaterialApp(
        title: 'ChakraCabs Driver',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff94341a)),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
