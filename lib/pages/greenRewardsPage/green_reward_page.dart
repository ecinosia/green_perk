import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_perk/auth/auth.dart';
import 'package:green_perk/components/page_title_widget.dart';
import 'package:image_network/image_network.dart';
import 'package:green_perk/constants/list_values.dart' as list_values;
import '../../components/nav_bar.dart';
import '../../constants/app_colors.dart';

class GreenRewardPage extends StatefulWidget {
  const GreenRewardPage({super.key});

  @override
  State<GreenRewardPage> createState() => _GreenRewardPageState();
}

class _GreenRewardPageState extends State<GreenRewardPage> {
  String userUid = "";
  String userProfilePictureUrl = "";
  int userGreenPoint = -1;
  String userName = "";
  String imageUrl = "";
  String tierBannerPath = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      userUid = returnUserName()!;
    });
    getUserDetails();
    imageUrl = loadProfilePicture().toString();
  }

  void getUserDetails() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        userName = ds['fullname'];
        userProfilePictureUrl = ds['profile_picture_url'];
        userGreenPoint = ds['green_points'];
        if (userGreenPoint <= 3000) {
          setState(() {
            tierBannerPath = 'lib/assets/images/bronze_tier.png';
          });
        } else if (userGreenPoint <= 10000) {
          setState(() {
            tierBannerPath = 'lib/assets/images/silver_tier.png';
          });
        } else {
          setState(() {
            tierBannerPath = 'lib/assets/images/gold_tier.png';
          });
        }
      });
    });
  }

  Future<String> loadProfilePicture() async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('profile_pictures/$userUid/${userUid}_profile_picture');

    String imageUrlFromFS = await reference.getDownloadURL();

    return imageUrlFromFS;
  }

  Future<void> addRewardToFirestore(dynamic newItem) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot docSnapshot = await collection.doc(userUid).get();

      if (docSnapshot.exists) {
        // Get the current array from Firestore
        List<dynamic> currentArray = docSnapshot['reward_list'] ?? [];

        // Add the new item to the array
        currentArray.add(newItem);

        // Update the document with the new array
        await collection.doc(userUid).update({
          'reward_list': currentArray,
        });
        debugPrint('Item added successfully to array.');
      } else {
        debugPrint('Document does not exist.');
      }
    } catch (e) {
      debugPrint('Error adding item to array: $e');
    }
  }

  Future<void> updateGreenPoints(int newValue) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('users');

      // Update the document with the new integer value
      await collection.doc(userUid).update({
        'green_points': newValue,
      }).then(
        (value) {
          getUserDetails();
        },
      );

      debugPrint('Integer field updated successfully.');
    } catch (e) {
      debugPrint('Error updating integer field: $e');
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
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
          ),
          child: Column(
            children: [
              const PageTitleWidget(
                title: 'GreenReward',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Image.asset(
                          tierBannerPath,
                          width: 150,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0, left: 20),
                    child: Column(
                      children: [
                        userName != ""
                            ? Text(
                                userName,
                                style: TextStyle(
                                    fontFamily: 'Google Sans',
                                    fontSize: 25,
                                    color: AppColors.primaryGreen),
                              )
                            : CircularProgressIndicator(
                                color: AppColors.textPink,
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              color: AppColors.textPink,
                              size: 30,
                            ),
                            userGreenPoint != -1
                                ? Text(
                                    '$userGreenPoint',
                                    style: TextStyle(
                                        fontFamily: 'Cy Grotestk Key',
                                        fontSize: 20,
                                        color: AppColors.primaryGreen,
                                        fontWeight: FontWeight.w300),
                                  )
                                : CircularProgressIndicator(
                                    color: AppColors.textPink,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list_values.rewardNames.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Row(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    side: BorderSide(
                                      color: AppColors.textPink,
                                    ),
                                  ),
                                  margin: const EdgeInsets.all(8),
                                  color: AppColors.primaryBlue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      list_values.rewardIcons[index],
                                      fit: BoxFit.cover,
                                      width: 40,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      child: Text(
                                        list_values.rewardNames[index],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          color: AppColors.primaryBlue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      child: Text(
                                        list_values.rewardDesc[index],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16,
                                          color: AppColors.primaryBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .03,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      list_values.rewardPoints[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: AppColors.textPink,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          addRewardToFirestore(
                                            list_values.rewardNames[index],
                                          );
                                          var newUserGreenPoints =
                                              userGreenPoint -
                                                  int.parse(list_values
                                                      .rewardPoints[index]);
                                          updateGreenPoints(newUserGreenPoints);

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Congrats"),
                                                content: Text(
                                                  "You successfuly redeemed ${list_values.rewardNames[index]}.\nThank you!",
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: const Text("Ok"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryBlue,
                                          elevation: 12,
                                        ),
                                        child: Text(
                                          'Redeem',
                                          style: TextStyle(
                                            color: AppColors.textPink,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
