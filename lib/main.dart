import 'package:acbaradiseservicepartner/Authentication/auth_page.dart';
import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());

  // Check for app update
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AC Baradise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: darkBlueColor),
        useMaterial3: true,
      ),
      home: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AuthPage(),
      ),
    );
  }
}
