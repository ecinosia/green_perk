import 'dart:io';

import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";

class CameraTestPage extends StatefulWidget {
  const CameraTestPage({super.key});

  @override
  State<CameraTestPage> createState() => _CameraTestPageState();
}

class _CameraTestPageState extends State<CameraTestPage> {
  final ImagePicker picker = ImagePicker();
  String path = "";
  void getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      path = image!.path;
    });
  }

  void takePhoto() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      path = photo!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Test Page'),
      ),
      body: Column(
        children: [
          path != "" ? Image.file(File(path)) : const Text('Select an image'),
          ElevatedButton(
            onPressed: () async {
              getImage();
            },
            child: const Text(
              'Select from gallery',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              takePhoto();
            },
            child: const Text(
              'Take a photo with camera',
            ),
          ),
        ],
      ),
    );
  }
}
