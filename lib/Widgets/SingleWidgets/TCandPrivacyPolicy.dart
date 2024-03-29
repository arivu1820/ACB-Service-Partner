import 'dart:io';

import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/SingleWidgets/DrawerChildContioner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class TCandPrivacy extends StatelessWidget {
  final String uid;

  const TCandPrivacy({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: "SumanaRegular",
              fontSize: 12,
              color: blackColor,
            ),
            children: [
              const TextSpan(
                text: "By continuing, you accept",
              ),
              TextSpan(
                text: " T&C",
                style: const TextStyle(
                  color: darkBlueColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    String url = 'https://acbaradise.com/privacy-policy-1';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
              ),
              const TextSpan(
                text: " and",
              ),
              TextSpan(
                text: " Privacy Policy",
                style: const TextStyle(
                  color: darkBlueColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    Uri uri = Uri.parse('https://acbaradise.com/privacy-policy-1');
                    if (await canLaunch(uri.toString())) {
                      await launch(uri.toString());
                    } else {
                      throw 'Could not launch $uri';
                    }
                  },
              ),
            ],
          ),
        ),
        const SizedBox(width: 10), // Add spacing between text and link
        Link(
          uri: Uri.parse('https://acbaradise.com/'),
          target: LinkTarget.blank,
          builder: (context, FollowLink) => GestureDetector(
            onTap: FollowLink,
            child: DrawerChildContioner(
              name: "Annual Us",
            ),
          ),
        ),
      ],
    );
  }
}
