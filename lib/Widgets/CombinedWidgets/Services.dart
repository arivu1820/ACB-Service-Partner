

import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/CombinedWidgets/CartAMCContainer.dart';
import 'package:flutter/material.dart';

class Services extends StatelessWidget {
    final Map<String, dynamic>? orderdetails;


  const Services({Key? key,    this.orderdetails,
 })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only( top:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
         const Text(
            "Services",
            style:  TextStyle(
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
  var products = orderdetails?['Services'] as Map<String, dynamic>?;

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
    num servicesOrderAmount = productData['totalPrice'] ?? 0;

    cartAMCContainers.add(CartAMCContainer(
      isQtyReq: true,
      title: title,
      count: count,
      orderamount: servicesOrderAmount,
    ));
  }
}

return Column(
  children: cartAMCContainers,
);

}
}
