import 'package:acbaradiseservicepartner/Screens/OrdersScreen.dart';
import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/SingleWidgets/CommonBtn.dart';
import 'package:acbaradiseservicepartner/Widgets/SingleWidgets/SimplyExpand.dart';
import 'package:acbaradiseservicepartner/Widgets/SingleWidgets/TCandPrivacyPolicy.dart';
import 'package:acbaradiseservicepartner/Widgets/SingleWidgets/TextContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  final String uid;
  const SigninScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final TextEditingController field1Controller = TextEditingController();
    final TextEditingController field2Controller = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    Future<void> _submitForm(
      TextEditingController field1Controller,
      TextEditingController field2Controller,
    ) async {
      if (_formKey.currentState!.validate()) {
        // Check if the entered email matches the allowed email
        try {
          // Show loading indicator
          showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(
                  color: darkBlueColor,
                ),
              );
            },
          );

          // Authenticate user with email and password
          UserCredential authResult =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: field1Controller.text.trim(), // Trimmed email
            password: field2Controller.text
                .trim(), // Replace with user-entered password
          );
          User? user = authResult.user;

          // Hide loading indicator
          Navigator.of(context).pop();

          // Navigate to the next page on successful sign-in
          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrdersScreen(
                  uid: uid,
                ),
              ),
            );
          }
        } catch (e) {
          // Hide loading indicator
          Navigator.of(context).pop();

          // Display error message
          print("Error signing in with email and password: $e");

          // Show error dialog
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Failed to sign in. Please try again."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Show error dialog for invalid email
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Invalid email address or password"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SimplyExpand(),
          Center(
            child: Image.asset(
              "Assets/Icons/ACB_ServicePartner_Icon.png",
              width: 150,
              height: 150,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextContainer(
                  controller: field1Controller,
                  label: "Email",
                  isnum: false,
                ),
                TextContainer(
                  controller: field2Controller,
                  label: "Password",
                  isnum: false,
                ),
              ],
            ),
          ),
          const SimplyExpand(),
          // FittedBox(
          //     fit: BoxFit.contain,
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 20),
          //       child: TCandPrivacy(
          //         uid: uid,
          //       ),
          //     )),
          // const SizedBox(
          //   height: 20,
          // ),
          CommonBtn(
              BtnName: 'Sign In',
              function: () => _submitForm(
                    field1Controller,
                    field2Controller,
                  ),
              isSelected: true),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }


}
