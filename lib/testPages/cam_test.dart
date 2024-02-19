import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import "package:image_picker/image_picker.dart";

class CameraTestPage extends StatefulWidget {
  const CameraTestPage({super.key});

  @override
  State<CameraTestPage> createState() => _CameraTestPageState();
}

class _CameraTestPageState extends State<CameraTestPage> {
  final ImagePicker picker = ImagePicker();
  String path = "";
  String label = '';

  @override
  void initState() {
    super.initState();
    _tfLiteInit();
  }

  Future<String?> _tfLiteInit() async {
    String? res = await Tflite.loadModel(
      model: "lib/assets/models/model.tflite",
      labels: "lib/assets/models/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
    return res;
  }

  void getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      path = image!.path;
    });

    var recognitions = await Tflite.runModelOnImage(
      path: image!.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );

    debugPrint(recognitions.toString());

    setState(() {
      label = recognitions![0]['label'].toString();
    });
  }

  void takePhoto() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      path = photo!.path;
    });
    var recognitions = await Tflite.runModelOnImage(
      path: photo!.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );
    debugPrint(recognitions.toString());

    setState(() {
      label = recognitions![0]['label'].toString();
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
          Text(
            label,
            style: const TextStyle(fontSize: 25),
          ),
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
