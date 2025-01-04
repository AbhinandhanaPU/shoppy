import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/view/screens/login/user_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool iswaiting = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      iswaiting = false;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (iswaiting == false) {
      return const UserLogin();
    }
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimationLimiter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 900),
                childAnimationBuilder: (widget) => ScaleAnimation(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Lottie.asset(
                    'assets/animations/Animation - 1735984122557.json',
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'SHOPPY',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '''We're glad you're here, let's get started''',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
