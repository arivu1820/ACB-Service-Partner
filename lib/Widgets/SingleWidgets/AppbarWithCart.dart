import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:flutter/material.dart';

class AppbarWithpartner extends StatelessWidget implements PreferredSizeWidget {
  final String PageName;
  final String uid;
  final bool isreplacepage;

  const AppbarWithpartner({
    required this.PageName,
    required this.uid,
    this.isreplacepage = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: Text(
              PageName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: "LexendRegular",
                fontSize: 18,
                color: blackColor,
              ),
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: Dark2ligthblueLRgradient,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
