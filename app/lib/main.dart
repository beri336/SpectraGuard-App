// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Logic to import files
  Future<void> _importFiles(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Imported: ${file.path}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Import canceled')),
      );
    }
  }

  // Logic to export files
  Future<void> _exportFiles(BuildContext context) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/example.txt';
    final file = File(path);
    await file.writeAsString('Example export content');
    Share.shareFiles([path], text: 'Exporting file example.txt');
  }

  // Logic to open the saved snapshots
  void _openSnapshots(BuildContext context) async {
    // TO BE IMPLEMENTED
    if (kDebugMode) {
      print('Feature not implemented: Open snapshots');
    }
  }
  
  // Logic to open the settings
  Future<void> _openSettings(BuildContext context) async {
    // TO BE IMPLEMENTED
    if (kDebugMode) {
      print('Feature not implemented: Open settings');
    }
  }

  // Logic to open the camera
  void _openCamera(BuildContext context) async {
    // TO BE IMPLEMENTED
    if (kDebugMode) {
      print('Feature not implemented: Open camera');
    }
  }

  // GUI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spectra Guard',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Welcome to Spectra Guard',
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => _openSnapshots(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.grey[200],
                    ),
                    child: const Icon(Icons.folder, color: Colors.green),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => _openCamera(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.grey[200],
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.red),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _importFiles(context),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.green,
                          backgroundColor: Colors.grey[200],
                        ),
                        child: const Text('Import',
                            style: TextStyle(color: Colors.green)),
                      ),
                      ElevatedButton(
                        onPressed: () => _exportFiles(context),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.green,
                          backgroundColor: Colors.grey[200],
                        ),
                        child: const Text('Export',
                            style: TextStyle(color: Colors.green)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.red,
          child: IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => _openSettings(context),
          ),
        ),
      ),
    );
  }
}
