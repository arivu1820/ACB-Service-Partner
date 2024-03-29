import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: whiteColor,

      body: Center(
        child: Image.asset(
          "Assets/Icons/ACB_ServicePartner_Icon.png",
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
