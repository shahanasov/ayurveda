import 'dart:ui';
import 'package:ayurveda/data/services/login_service.dart';
import 'package:ayurveda/presentation/auth/login_screen.dart';
import 'package:ayurveda/presentation/home/home_screen.dart';
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

 Future<void> navigateNext() async {
  await Future.delayed(const Duration(seconds: 3));

  try {
    final token = await LoginService().getToken();

    if (token != null && token.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) =>  LoginScreen()),
      );
    }
  } catch (e) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) =>  LoginScreen()),
    );
  }
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
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            color: const Color.fromRGBO(2, 20, 0, 1).withValues(alpha: 0.6),
            child: Center(
              child: Image.asset("assets/images/logo.png", height: 100),
            ),
          ),
        ),
      ),
    );
  }
}
