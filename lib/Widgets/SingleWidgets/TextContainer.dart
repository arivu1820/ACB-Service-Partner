import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextContainer extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isOptional;
  final bool isnum;

  TextContainer({
    required this.controller,
    required this.isnum,
    required this.label,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: "SumanaRegular",
              color: blackColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: isnum ? TextInputType.number : TextInputType.streetAddress,
            controller: controller,
            inputFormatters: [
              if (isnum) FilteringTextInputFormatter.allow(RegExp(r'\d')), // Allow only numeric characters
            ],
            decoration: InputDecoration(
              filled: true,
              fillColor: lightBlue20Color,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (!isOptional && (value == null || value.isEmpty)) {
                return "This field is required";
              }

              

              return null;
            },
          ),
        ],
      ),
    );
  }
}
