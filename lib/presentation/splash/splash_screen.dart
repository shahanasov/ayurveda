import 'package:ayurveda/presentation/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateNext();
  }

  void navigateNext() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: const Color.fromRGBO(2, 20, 0, 1).withValues(alpha: 0.6),
          child: Center(
            child: Image.asset("assets/images/logo.png", height: 100),
          ),
        ),
      ),
    );
  }
}
