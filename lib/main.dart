import 'package:flutter/material.dart';
import 'package:grad_project/network/cache_helper.dart';
import 'package:grad_project/network/dio_factory.dart';
import 'package:grad_project/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioFactory.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffD4D4D4),
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xff3DB166),
        ),
      ),
    );
  }
}
