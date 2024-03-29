
import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:flutter/material.dart';

class OrderProductContainer extends StatelessWidget {
  final bool isQtyReq;
  final String productid;
    final int count;
    final num productsorderamount;

  final String title;
  final String img;
  OrderProductContainer({super.key,this.productsorderamount =0, required this.isQtyReq,this.count=0,this.productid='',required this.title,required this.img});

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
