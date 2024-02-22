import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_perk/components/h10_custom_sized_box.dart';
import 'package:green_perk/components/h40_custom_sized_box.dart';
import 'package:green_perk/components/page_title_widget.dart';
import 'package:green_perk/components/w02_custom_sized_box.dart';
import 'package:green_perk/constants/app_colors.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/auth.dart';
import '../../components/nav_bar.dart';
import 'components/custom_text_form_field_account.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String userUid = "";
  String? userEmail;
  String userName = "";
  String? userPassword;
  String userProfilePictureUrl = "";
  int userGreenPoint = -1;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  String path = "";
  bool uploadingProfilePicture = false;
  String imageUrl = "";
  List<String> redeemedRewardList = [];
  String tier = "";

  @override
  void initState() {
    super.initState();
    // Perform asynchronous operations
    _initializeState();
  }

  void _initializeState() async {
    // Get user name
    String? userName = returnUserName();
    if (userName != null) {
      setState(() {
        userUid = userName;
      });
    }

    // Get reward list
    List<String> rewardList = await getRewardListFromFirestore();
    setState(() {
      redeemedRewardList = rewardList;
    });

    // Get user details
    getUserDetails();
  }

  void getUserDetails() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        userName = ds['fullname'];
        nameController.text = userName;
        userEmail = ds['email'];
        emailController.text = userEmail!;
        userPassword = ds['password'];
        userProfilePictureUrl = ds['profile_picture_url'];
        userGreenPoint = ds['green_points'];
        if (userGreenPoint <= 3000) {
          setState(() {
            tier = 'Bronze Tier';
          });
        } else if (userGreenPoint <= 10000) {
          setState(() {
            tier = 'Silver Tier';
          });
        } else {
          setState(() {
            tier = 'Gold Tier';
          });
        }
      });
    });
  }

  void updateUserDetails() {
    DocumentReference docRefInside =
        FirebaseFirestore.instance.collection('users').doc(userUid);
    docRefInside.update({
      'fullname': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });
  }

  void getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      path = image!.path;
    });
    uploadProfilePicture();
  }

  void takePhoto() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      path = image!.path;
    });
    uploadProfilePicture();
  }

  uploadProfilePicture() async {
    await uplaodProfilePictureAndSaveItemInfo();
    setState(() {
      uploadingProfilePicture = false;
    });
    debugPrint("Profile Picture Uploaded Successfully");
  }

  uplaodProfilePictureAndSaveItemInfo() async {
    setState(() {
      uploadingProfilePicture = true;
    });
    PickedFile? pickedFile;

    pickedFile = PickedFile(path);
    imageUrl = await uploadProfilePictureToStorage(pickedFile);

    // Update Firestore with the image URL
    await updateFirestoreWithImageUrl(imageUrl);
  }

  Future<String> uploadProfilePictureToStorage(PickedFile? pickedFile) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('profile_pictures/$userUid/${userUid}_profile_picture');

    // Upload image to Firebase Storage
    await reference.putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );

    // Get download URL of the uploaded image
    String imageUrl = await reference.getDownloadURL();

    return imageUrl;
  }

  Future<void> updateFirestoreWithImageUrl(String imageUrl) async {
    // Reference to the user document
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userUid);

    // Update the profile_picture_url field in Firestore
    await userDocRef.update({
      'profile_picture_url': imageUrl,
    });
  }

  Future<List<String>> getRewardListFromFirestore() async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot docSnapshot = await collection.doc(userUid).get();

      if (docSnapshot.exists) {
        // Get the current array from Firestore
        List<dynamic> rewardList = docSnapshot['reward_list'] ?? [];
        List<String> rewardListString =
            rewardList.cast<String>(); // Cast to List<String>
        debugPrint('Reward List fetched successfully: $rewardListString');
        return rewardListString;
      } else {
        debugPrint('Document does not exist.');
        return []; // or throw an error, depending on your use case
      }
    } catch (e) {
      debugPrint('Error fetching reward list from Firestore: $e');
      return []; // or throw an error, depending on your use case
    }
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
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
            ),
            child: Column(
              children: [
                const PageTitleWidget(
                  title: 'GreenAccount',
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 150,
                  child: Card(
                    color: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: const AssetImage(
                                  'lib/assets/images/pp_placeholder.png'),
                              child: ImageNetwork(
                                borderRadius: BorderRadius.circular(80),
                                image: userProfilePictureUrl == ""
                                    ? imageUrl
                                    : userProfilePictureUrl,
                                height: 150,
                                width: 150,
                                onError: Container(),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: AppColors.primaryBlue,
                                builder: (context) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.camera_alt,
                                        ),
                                        title: const Text('Camera'),
                                        onTap: () {
                                          setState(() {
                                            takePhoto();
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.photo,
                                        ),
                                        title: const Text('Gallery'),
                                        onTap: () {
                                          setState(() {
                                            getImage();
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 85,
                                left: 100,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: AppColors.textPink,
                                size: 35,
                              ),
                            ),
                          ),
                        ]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userName != ""
                                ? Text(
                                    userName,
                                    style: TextStyle(
                                        fontFamily: 'Google Sans',
                                        fontSize: 25,
                                        color: AppColors.primaryBlue),
                                  )
                                : CircularProgressIndicator(
                                    color: AppColors.textPink,
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: AppColors.textPink,
                                  size: 30,
                                ),
                                userGreenPoint != -1
                                    ? Text(
                                        '$userGreenPoint\n$tier',
                                        style: TextStyle(
                                            fontFamily: 'Cy Grotestk Key',
                                            fontSize: 20,
                                            color: AppColors.primaryBlue,
                                            fontWeight: FontWeight.w300),
                                      )
                                    : CircularProgressIndicator(
                                        color: AppColors.textPink,
                                      ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Redeemed Rewards',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Cy Grotestk Key',
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGreen),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: redeemedRewardList.length,
                    itemBuilder: (context, index) {
                      return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          color: AppColors.primaryGreen,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 8,
                              bottom: 8,
                            ),
                            child: Text(
                              redeemedRewardList[index],
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontFamily: 'Cy Grotestk Key',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ));
                    },
                  ),
                ),
                CustomTextFormFieldAccount(
                  label: 'Full Name',
                  controller: nameController,
                  obscureText: false,
                ),
                CustomTextFormFieldAccount(
                  label: 'E-mail Address',
                  controller: emailController,
                  obscureText: false,
                ),
                CustomTextFormFieldAccount(
                  label: 'Confirm Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text == "") {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Error"),
                              content:
                                  const Text('Please enter your full name!'),
                              actions: [
                                TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      } else if (emailController.text == "") {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Error"),
                              content: const Text(
                                  'Please enter your email address!'),
                              actions: [
                                TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      } else if (passwordController.text != userPassword) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Error"),
                              content: const Text(
                                  'You entered your password wrong!'),
                              actions: [
                                TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        updateUserDetails();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textPink,
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: AppColors.white,
                        fontFamily: 'Google Sans',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
