import 'package:ayurveda/core/constants/app_theme.dart';
import 'package:ayurveda/data/services/register_patient_service.dart';
import 'package:ayurveda/presentation/splash/splash_screen.dart';
import 'package:ayurveda/providers/login_provider.dart';
import 'package:ayurveda/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterPatientService service = RegisterPatientService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(
          create: (_) => RegisterPatientProvider(service),
        ),
      ],
      child: MaterialApp(
        title: 'Ayurveda',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: SplashScreen(),
      ),
    );
  }
}
