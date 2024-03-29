import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/CombinedWidgets/CartAMCContainer.dart';
import 'package:flutter/material.dart';

class AMC extends StatelessWidget {
  final bool isQtyReq;
  final Map<String, dynamic>? orderdetails;

  const AMC({
    Key? key,
    this.orderdetails,
    required this.isQtyReq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only( top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "AMC",
            style: TextStyle(
              fontFamily: "SumanaRegular",
                fontSize: 18,
              color: darkBlueColor,
            ),
          ),
          buildProductsFromListview(),
        ],
      ),
    );
  }

  Widget buildProductsFromListview() {
    var products = orderdetails?['AMC'] as Map<String, dynamic>?;

    if (products == null) {
      // Handle the case where 'Products' is null or not a Map
      return Container();
    }

    var productIds = products.keys.toList();
    List<Widget> cartAMCContainers = [];

    for (int index = 0; index < productIds.length; index++) {
      var productId = productIds[index];
      var productData = products[productId] as Map<String, dynamic>;

      if (productData != null) {
        String title = productData['title'] ?? '';
        int count = productData['count'] ?? 0;
        num amcorderamount = productData['totalPrice'] ?? 0;

        cartAMCContainers.add(CartAMCContainer(
          isQtyReq: isQtyReq,
          title: title,
          count: count,
          orderamount: amcorderamount,
        ));
      }
    }

    return Column(
      children: cartAMCContainers,
    );
  }
}
