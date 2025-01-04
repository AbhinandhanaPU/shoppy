import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Shoppy',
      home: SplashScreen(),
    );
  }
}
