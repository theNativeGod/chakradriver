import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  final String documentTitle;
  final String driverId; // Driver's unique ID for Firestore

  const UploadScreen(
      {Key? key, required this.documentTitle, required this.driverId})
      : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? _filePath;
  bool _isUploading = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_filePath == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      // Upload file to Firebase Storage
      final fileName = _filePath!.split('/').last;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('driver_documents/${widget.driverId}/$fileName');

      await storageRef.putFile(File(_filePath!));
      final fileUrl = await storageRef.getDownloadURL();

      // Save file URL to Firestore under the driver's ID
      final firestoreRef = FirebaseFirestore.instance
          .collection('drivers')
          .doc(widget.driverId)
          .collection('documents')
          .doc(widget.documentTitle);

      await firestoreRef.set({
        'title': widget.documentTitle,
        'url': fileUrl,
        'uploaded_at': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('${widget.documentTitle} uploaded successfully!')),
      );

      setState(() {
        _filePath = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documentTitle),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload ${widget.documentTitle}',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16),
            _filePath != null
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.insert_drive_file, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _filePath!.split('/').last,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.clear, color: Colors.red),
                          onPressed: () => setState(() => _filePath = null),
                        ),
                      ],
                    ),
                  )
                : Text(
                    'No file selected',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Choose File'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed:
                  _filePath != null && !_isUploading ? _uploadFile : null,
              child: _isUploading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Upload'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
