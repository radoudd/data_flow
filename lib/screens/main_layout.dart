import 'dart:convert';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/network/api_constants.dart';
import 'package:grad_project/network/cache_helper.dart';
import 'package:grad_project/network/data.dart';
import 'package:grad_project/network/dio_factory.dart';
import 'package:grad_project/screens/form_screen.dart';
import 'package:grad_project/screens/home_screen.dart';
import 'package:grad_project/screens/models/user_model.dart';
import 'package:grad_project/screens/settings_screen.dart';
import 'package:grad_project/screens/training_screen.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentindex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const FormScreen(),
    const TrainingScreen(),
    const SettingsScreen(),
  ];
  @override
  void initState() {
    super.initState();
    String? token = CacheHelper.token;
    final parts = token?.split('.') ?? [];
    if (parts.isNotEmpty) {
      final payload = parts[1];
      final String decoded = B64urlEncRfc7515.decodeUtf8(payload);
      String id = jsonDecode(decoded)['id'];

      getUserData(id);
    }
  }

  void getUserData(String id) async {
    DioFactory.getData('${ApiConstants.users}/$id').then((value) {
      setState(() {
        userModel = UserModel.fromJson(value.data);
      });
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
      body: userModel.id == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : screens[currentindex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: CustomNavigationBar(
          isFloating: true,
          borderRadius: const Radius.circular(16),
          currentIndex: currentindex,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          iconSize: 32,
          items: [
            CustomNavigationBarItem(
              selectedIcon: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    'assets/images/homeicon.png',
                    color: Colors.white,
                  ),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset('assets/images/homeiconn.png'),
              ),
            ),
            CustomNavigationBarItem(
              selectedIcon: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    'assets/images/itemiconselected.png',
                    color: Colors.white,
                  ),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset('assets/images/itemicon.png'),
              ),
            ),
            CustomNavigationBarItem(
              selectedIcon: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    'assets/images/personiconselected.png',
                    color: Colors.white,
                  ),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset('assets/images/personicon.png'),
              ),
            ),
            CustomNavigationBarItem(
              selectedIcon: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    'assets/images/sittingiconselected.png',
                    color: Colors.white,
                  ),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset('assets/images/sittingicon.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
