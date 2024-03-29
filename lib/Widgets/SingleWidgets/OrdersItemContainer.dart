import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/CombinedWidgets/AMC.dart';
import 'package:acbaradiseservicepartner/Widgets/CombinedWidgets/GeneralProducts.dart';
import 'package:acbaradiseservicepartner/Widgets/CombinedWidgets/Products.dart';
import 'package:acbaradiseservicepartner/Widgets/CombinedWidgets/Services.dart';
import 'package:flutter/material.dart';

class OrdersItemsContainer extends StatelessWidget {
final List<dynamic> orderdetails;
   OrdersItemsContainer({super.key,required this.orderdetails});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            if (orderdetails[3]['GeneralProducts'].isNotEmpty)
              GeneralProducts(
                isQtyReq: true,
                orderdetails: orderdetails[3],
              ),
            if (orderdetails[2]['Products'].isNotEmpty)
              Products(
                isQtyReq: true,
                orderdetails: orderdetails[2],
              ),
            if (orderdetails[1]['Services'].isNotEmpty)
              Services(
                orderdetails: orderdetails[1],
              ),
            if (orderdetails[0]['AMC'].isNotEmpty)
              AMC(
                isQtyReq: true,
                orderdetails: orderdetails[0],
              ),
            
          ],
        ),
      ],
    );
  }
}
