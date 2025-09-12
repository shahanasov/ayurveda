import 'dart:ui';
import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:ayurveda/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // top background + logo
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/splashbg.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                          child: Container(
                            color: const Color.fromRGBO(
                              2,
                              20,
                              0,
                              1,
                            ).withValues(alpha: 0.6),
                            child: Center(
                              child: Image.asset("assets/images/logo.png", height: 80),
                            ),
                          ),
                        ),
                      ),

                      // Login Form
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login Or Register To Book Your Appointments",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 20),
                            Text("Email"),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Enter your email",
                                border: OutlineInputBorder(),
                              ),
                            ),

                            const SizedBox(height: 20),
                            Text("Password"),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Enter password",
                                border: OutlineInputBorder(),
                              ),
                            ),

                            const SizedBox(height: 50),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryGreen,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                ),
                                onPressed: provider.isLoading
                                    ? null
                                    : () async {
                                        await provider.login(
                                          emailController.text.trim(),
                                          passwordController.text.trim(),
                                        );
                                        if (provider.loginResponse?.token != null) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => HomeScreen(),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                provider.error ?? "Login failed",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                child: provider.isLoading
                                    ? CircularProgressIndicator(color: Colors.white)
                                    : Text("Login"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text.rich(
                      TextSpan(
                        text: "By creating or logging into an account you are agreeing with our ",
                        children: [
                          TextSpan(
                            text: "Terms and Conditions",
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}