import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:flutter/material.dart';

class DrawerChildContioner extends StatelessWidget {
  final String name;
  DrawerChildContioner({required this.name,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      height: 60,
      width: double.infinity,
      child: Row(children: [
        
        Text(name, style: const TextStyle(
                fontFamily: 'SumanaRegular',
                fontSize: 24,
                color: blackColor,
              ),),
      ],),
    );
  }
}