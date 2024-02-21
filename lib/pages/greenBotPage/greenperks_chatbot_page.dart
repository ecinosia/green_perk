// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:green_perk/components/page_title_widget.dart';

import '../../auth/auth.dart';
import '../../components/nav_bar.dart';
import '../../constants/app_colors.dart';

class GreenBotPage extends StatefulWidget {
  const GreenBotPage({super.key});

  @override
  State<GreenBotPage> createState() => _GreenBotPageState();
}

class _GreenBotPageState extends State<GreenBotPage> {
  TextEditingController userMessageController = TextEditingController();

  final model = GenerativeModel(
      model: 'gemini-pro', apiKey: "AIzaSyDDOY0xzyK41CR5XN9K3zapzIDKcsAm7Nc");
  final List<String> chatHistory = [];
  final List<String> chatSender = [];

  bool loading = false;
  String userUid = "";
  String? userName;
  var userNameManipulated;

  @override
  void initState() {
    super.initState();
    model;
    setState(() {
      userUid = returnUserName()!;
    });
    getUserName();
  }

  @override
  void dispose() {
    userMessageController.dispose();
    super.dispose();
  }

  void sendMessage(String message) async {
    setState(() {
      loading = true;
      userMessageController.clear();
    });
    chatSender.add('${userNameManipulated[0]}: ');
    chatHistory.add(message);
    final prompt = message;
    final content = [Content.text(prompt)];

    try {
      final response = await model.generateContent(content);
      setState(() {
        chatSender.add('GreenBot: ');
        chatHistory.add("${response.text}");
        loading = false;
      });
    } catch (e) {
      setState(() {
        chatHistory.add("Something went wrong! Please try again.");
        debugPrint('Error: $e');
        loading = false;
      });
    }
  }

  void getUserName() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        userName = ds['fullname'];
        userNameManipulated = userName!.split(' ');
      });
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
          ),
          child: Column(
            children: [
              const PageTitleWidget(title: 'GreenBot'),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .65,
                child: ListView.builder(
                  itemCount: chatHistory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: chatSender[index],
                            style: TextStyle(
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPink,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: '\n${chatHistory[index]}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textGreen,
                              fontSize: 18,
                            ),
                          ),
                        ]),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'How can I help you today?',
                  style: TextStyle(
                    fontFamily: 'Cy Grotestk Key',
                    fontSize: 14,
                    color: AppColors.textGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                height: 50,
                child: CupertinoTextField.borderless(
                  controller: userMessageController,
                  cursorColor: AppColors.textPink,
                  placeholder: 'Enter your message!',
                  placeholderStyle: TextStyle(
                    fontFamily: 'Google Sans',
                    fontSize: 13,
                    color: AppColors.white.withOpacity(.5),
                    fontWeight: FontWeight.w300,
                  ),
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffix: loading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.textPink,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            sendMessage(userMessageController.text);
                            userMessageController.clear();
                          },
                          icon: Icon(
                            Icons.send_rounded,
                            color: AppColors.textPink,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
