import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maincode/firebase_options.dart';
import 'package:maincode/page/changepicture.dart';
import 'package:maincode/page/contract.dart';
import 'package:maincode/page/create.dart';
import 'package:maincode/page/editprofile.dart';
import 'package:maincode/page/home.dart';
import 'package:maincode/page/login.dart';
import 'package:maincode/page/foodSummary.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => CreateAccountPage(),
        '/home': (context) => HomePage(),
        '/activity': (context) => FoodSummaryPage(),
        '/editprofile': (context) => EditProfilePage(),
        '/contract': (context) => ContactInformationPage(),
        '/changePicture': (context) => EditPicturePage(),
      },
    );
  }
}
