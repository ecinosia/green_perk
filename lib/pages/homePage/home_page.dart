import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_perk/auth/auth.dart';
import 'package:green_perk/components/h40_custom_sized_box.dart';
import 'package:green_perk/components/nav_bar.dart';
import 'package:green_perk/constants/app_colors.dart';
import 'package:pedometer/pedometer.dart';

import '../../components/w02_custom_sized_box.dart';
import 'components/home_page_custom_card_widget.dart';
import 'components/welcome_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userUid = "";
  String userName = "";
  late Stream<StepCount> _stepCountStream;
  String _steps = '?';

  @override
  void initState() {
    super.initState();
    setState(() {
      userUid = returnUserName()!;
    });
    getUserName();
    initPlatformState();
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

  void onStepCount(StepCount event) {
    debugPrint(event.toString());
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onStepCountError(error) {
    debugPrint('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            color: AppColors.primaryBlue,
            onPressed: () {
              signOut();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text("Logging out..."),
                    content: Text(
                        "You successfuly logget out.\nRedirecting to welcome page!"),
                  );
                },
              );
              Future.delayed(
                const Duration(seconds: 5),
                () {
                  context.go('/sign_in_register_page');
                },
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
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
              const H40CustomSizedBox(),
              WelcomeCardWidget(userName: userName),
              const H40CustomSizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //TODO PEDOMETER Steps need to be checked!
                  HomePageCustomCardWidget(
                    steps: _steps,
                    title: 'Steps',
                    imagePath: 'lib/assets/images/step.png',
                    value: "7.806",
                  ),
                  const W02CustomSizedBox(),
                  // TODO Awards Points need to be checked!
                  HomePageCustomCardWidget(
                    steps: _steps,
                    title: 'Awards',
                    imagePath: 'lib/assets/images/award.png',
                    value: "999 Points",
                  ),
                ],
              ),
              const H40CustomSizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //TODO Recycle counts need to be checked!
                  HomePageCustomCardWidget(
                    steps: _steps,
                    title: 'Recycle\nCounts',
                    imagePath: 'lib/assets/images/recycle.png',
                    value: "99",
                  ),
                  const W02CustomSizedBox(),
                  // TODO This card is empty need to add feature!
                  HomePageCustomCardWidget(
                    steps: _steps,
                    title: 'EMPTY',
                    imagePath: 'lib/assets/images/recycle.png',
                    value: "EMPTY",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
