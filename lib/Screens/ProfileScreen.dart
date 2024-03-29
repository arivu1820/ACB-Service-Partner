import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/SingleWidgets/SimplyExpand.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                  fontFamily: 'SumanaRegular',
                  fontSize: 32,
                  color: darkBlueColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "name",
                  style: TextStyle(
                      fontFamily: 'SumanaRegular',
                      fontSize: 24,
                      color: blackColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  color: black50Color,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "email",
                  style: TextStyle(
                      fontFamily: 'SumanaRegular',
                      fontSize: 24,
                      color: blackColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  color: black50Color,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "+91 XXXXXXXXXX",
                  style: TextStyle(
                      fontFamily: 'SumanaRegular',
                      fontSize: 24,
                      color: blackColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  color: black50Color,
                ),
                Container(
                  margin: const EdgeInsets.only(top:200),
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: darkGrey50Color,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontFamily: 'SumanaRegular',
                              fontSize: 24,
                              color: brown50Color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      appBar: AppBar(),
    );
  }
}
