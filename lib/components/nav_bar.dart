import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_perk/auth/auth.dart';
import 'package:green_perk/constants/app_colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String userUid = "";
  String? userEmail;
  String? userName;

  @override
  void initState() {
    super.initState();
    setState(() {
      userUid = returnUserName()!;
    });
    getUserName();
  }

  void getUserName() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        userName = ds['fullname'];
        userEmail = ds['email'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryGreen,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "$userName",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: AppColors.black),
            ),
            accountEmail: Text(
              "$userEmail",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.black),
            ),
            decoration: BoxDecoration(color: AppColors.primaryBlue),
          ),

          ListTile(
            leading: Icon(
              Icons.home,
              color: AppColors.primaryBlue,
            ),
            title: Text(
              "Home Page",
              style: TextStyle(
                fontFamily: 'Google Sans',
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            onTap: () => context.go('/home_page'),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.recycling_rounded,
              color: AppColors.primaryBlue,
            ),
            title: Text(
              "RecycleGreen",
              style: TextStyle(
                fontFamily: 'Google Sans',
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            onTap: () => context.go('/recycle_page'),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.monetization_on_rounded,
              color: AppColors.primaryBlue,
            ),
            title: Text(
              "GreenReward",
              style: TextStyle(
                fontFamily: 'Google Sans',
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            onTap: () => context.go('/green_rewards_page'),
          ),
          //Divider used for space part with buttons.
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.chat_rounded,
              color: AppColors.primaryBlue,
            ),
            title: Text(
              "GreenBot",
              style: TextStyle(
                fontFamily: 'Google Sans',
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            onTap: () => context.go('/greenbot_page'),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.nature_outlined,
              color: AppColors.primaryBlue,
            ),
            title: Text(
              "SaveTheGreen",
              style: TextStyle(
                fontFamily: 'Google Sans',
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            onTap: () => context.go('/save_the_green_page'),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: AppColors.primaryBlue,
            ),
            title: Text(
              "My Account",
              style: TextStyle(
                fontFamily: 'Google Sans',
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            onTap: () => context.go('/account_page'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_outlined, color: Colors.red),
            title: Text(
              "Sign Out",
              style: TextStyle(
                fontFamily: 'Google Sans',
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            onTap: () => signOut(context),
          ),
        ],
      ),
    );
  }
}
