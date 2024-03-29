

import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:flutter/material.dart';

class CartAMCContainer extends StatelessWidget {
  final bool isQtyReq;
  final String productid;
  final num orderamount;
  final int count;

  final String title;
  CartAMCContainer({super.key, required this.isQtyReq,this.productid='',required this.title,this.orderamount=0, this.count=0});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: "SumanaRegular",
                  fontSize: 16,
                  color: blackColor,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
                'Qty: $count',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: "SumanaBold",
                  fontSize: 16,
                  color: blackColor,
                  decoration: TextDecoration.underline,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
