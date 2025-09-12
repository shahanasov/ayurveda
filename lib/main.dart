import 'package:ayurveda/core/constants/app_theme.dart';
import 'package:ayurveda/presentation/splash/splash_screen.dart';
import 'package:ayurveda/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoginProvider())],
      child: MaterialApp(
        title: 'Ayurveda',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home:  SplashScreen(),
      ),
    );
  }
}
