import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:flutter/material.dart';

class CommonBtn extends StatelessWidget {
  final String BtnName;
  final VoidCallback function;
  final bool isSelected;

  CommonBtn({required this.BtnName, required this.function, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSelected ? () {
        function(); // Call the function using parentheses
      }: (){},
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:isSelected? lightBlueColor: lightBlue50Color,
        ),
        child: Center(
          child: Text(
            BtnName,
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontSize: 24,
              fontFamily: "SumanaRegular",
              color: isSelected? blackColor: black50Color,
            ),
          ),
        ),
      ),
    );
  }
}

