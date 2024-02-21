import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_perk/firebase_options.dart';
import 'package:green_perk/pages/accountPage/account_page.dart';
import 'package:green_perk/pages/greenBotPage/greenperks_chatbot_page.dart';
import 'package:green_perk/pages/greenRewardsPage/green_reward_page.dart';
import 'package:green_perk/pages/homePage/home_page.dart';
import 'package:green_perk/pages/recyclePage/recycle_page.dart';
import 'package:green_perk/pages/registerPage/register_page.dart';
import 'package:green_perk/pages/saveTheGreenPage/save_the_green_page.dart';
import 'package:green_perk/pages/signInPage/sign_in_page.dart';
import 'package:green_perk/pages/signInRegisterPage/sign_in_register_page.dart';
import 'package:green_perk/pages/welcomePage/welcome_page.dart';
import 'package:green_perk/testPages/cam_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'camera_test_page',
          builder: (BuildContext context, GoRouterState state) {
            return const CameraTestPage();
          },
        ),
        GoRoute(
          path: 'home_page',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: 'sign_in_register_page',
          builder: (BuildContext context, GoRouterState state) {
            return const SignInRegisterPage();
          },
        ),
        GoRoute(
          path: 'sign_in_register_page/sign_in_page',
          builder: (BuildContext context, GoRouterState state) {
            return const SignInPage();
          },
        ),
        GoRoute(
          path: 'sign_in_register_page/sign_up_page',
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterPage();
          },
        ),
        GoRoute(
          path: 'recycle_page',
          builder: (BuildContext context, GoRouterState state) {
            return const RecyclePage();
          },
        ),
        GoRoute(
          path: 'greenbot_page',
          builder: (BuildContext context, GoRouterState state) {
            return const GreenBotPage();
          },
        ),
        GoRoute(
          path: 'save_the_green_page',
          builder: (BuildContext context, GoRouterState state) {
            return const SaveTheGreenPage();
          },
        ),
        GoRoute(
          path: 'green_rewards_page',
          builder: (BuildContext context, GoRouterState state) {
            return const GreenRewardPage();
          },
        ),
        GoRoute(
          path: 'account_page',
          builder: (BuildContext context, GoRouterState state) {
            return const AccountPage();
          },
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
