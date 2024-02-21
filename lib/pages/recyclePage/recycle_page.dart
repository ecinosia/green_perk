import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:green_perk/components/h40_custom_sized_box.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/auth.dart';
import '../../components/nav_bar.dart';
import '../../constants/app_colors.dart';
import 'components/custom_elevated_button_for_image.dart';

class RecyclePage extends StatefulWidget {
  const RecyclePage({super.key});

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  final ImagePicker picker = ImagePicker();
  String path = "";
  String label = '';
  String userUid = "";
  String userName = "";
  int userPoints = 0;
  String congrats = "";

  @override
  void initState() {
    super.initState();
    _tfLiteInit();
    setState(() {
      userUid = returnUserName()!;
      // userPoints = getUserPoints();
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        userPoints = ds['green_points'];
      });
    });
  }

  void getUserName() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        userName = ds['fullname'];
      });
    });
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
    runPrediction(path);
  }

  void takePhoto() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      path = photo!.path;
    });
    runPrediction(path);
  }

  void runPrediction(String pathForPrediction) async {
    var recognitions = await Tflite.runModelOnImage(
      path: pathForPrediction,
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

    if (label == 'Battery' ||
        label == 'Brown-Glass' ||
        label == 'Cardboard' ||
        label == 'Green-Glass' ||
        label == 'Metal' ||
        label == 'Paper' ||
        label == 'Plastic' ||
        label == 'Trash' ||
        label == 'White-Glass') {
      userPoints += 50;
      updateUserPoint();
    }
  }

  void updateUserPoint() {
    FirebaseFirestore.instance.collection('users').doc(userUid).update({
      'green_points': userPoints,
    });
    setState(() {
      congrats = "Congrats $userName. You won 50 points!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            color: AppColors.primaryBlue,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu_rounded),
          );
        }),
        title: Text(
          'greenperks',
          style: TextStyle(
              fontFamily: 'Cy Grotestk Key',
              color: AppColors.white,
              fontSize: 32),
        ),
        backgroundColor: AppColors.primaryGreen,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'RecycleGreen',
                    style: TextStyle(
                      fontFamily: 'Google Sans',
                      fontSize: 30,
                      color: AppColors.textGreen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const H40CustomSizedBox(),
              SizedBox(
                width: MediaQuery.of(context).size.width * .86,
                height: MediaQuery.of(context).size.width * .86,
                child: Card(
                  color: AppColors.primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: path == ""
                      ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Please select an\nimage or take a photo!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Cy Grotestk Key',
                              fontSize: 26,
                              color: AppColors.white,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(
                              path,
                            ),
                          ),
                        ),
                ),
              ),
              const H40CustomSizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButtonForImage(
                    onPressed: getImage,
                    text: 'Select From Gallery',
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .02,
                  ),
                  CustomElevatedButtonForImage(
                    onPressed: takePhoto,
                    text: 'Take a Photo',
                  ),
                ],
              ),
              const H40CustomSizedBox(),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Google Sans',
                  fontSize: 35,
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const H40CustomSizedBox(),
              Text(
                congrats,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Google Sans',
                  fontSize: 30,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
