// ignore_for_file: unused_import, library_private_types_in_public_api, unnecessary_import, duplicate_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/network/cache_helper.dart';
import 'package:grad_project/screens/home_screen.dart';
import 'package:grad_project/screens/login_screen.dart';
import 'package:grad_project/screens/main_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final String? token = CacheHelper.token;
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              token == null ? const LoginScreen() : const MainLayout(),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // Your logo widget
        child: Image.asset(
          'assets/images/logo.png', // Assuming your logo is in the assets folder
          width: 500,
          height: 500,
        ),
      ),
    );
  }
}
