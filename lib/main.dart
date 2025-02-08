import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'pages/image_classificaton.dart';
import 'package:rain/pages/OTP_page.dart';
import 'package:rain/pages/Verification_page.dart';
import 'package:rain/pages/lang_page.dart';
import 'package:rain/pages/welcome_page.dart';
import 'package:rain/services/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure system UI mode is properly set
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return GetMaterialApp(
      title: 'Rain',
      debugShowCheckedModeBanner: false,
      fallbackLocale: const Locale('en', 'US'),
      home: const Welcome(),
      routes: {
        'welcome': (context) => const Welcome(),
        'language': (context) => Lang_page(),
        'verif': (context) => MyPhone(),
        'OTP': (context) => MyVerify(),
        'login': (context) => LoginScreen(),
        'plant_dieases': (context) => PlantDiseaseDetector()
      },
    );
  }
}
