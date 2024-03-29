

import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderGeneralProductContainer extends StatelessWidget {
  final bool isQtyReq;
  final String productid;
    final int count;
    final num productsorderamount;

  final String title;
  final String img;
  OrderGeneralProductContainer({super.key,this.productsorderamount =0, required this.isQtyReq,this.count=0,this.productid='',required this.title,required this.img});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        
        child: Row(
          children: [
            
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: "SumanaRegular",
                  fontSize: 16,
                  color: blackColor,
                ),
              ),
            ),
            const SizedBox(width: 20,),
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
