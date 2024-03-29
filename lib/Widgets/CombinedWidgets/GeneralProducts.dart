
import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/CombinedWidgets/OrderGeneralProductContainer.dart';
import 'package:flutter/material.dart';


class GeneralProducts extends StatelessWidget {
  final bool isQtyReq;
  final Map<String, dynamic>? orderdetails;

  GeneralProducts({
    Key? key,
    required this.isQtyReq,
    this.orderdetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only( top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
        const  Text(
            "General Products",
            style: TextStyle(
              fontFamily: "SumanaRegular",
                fontSize: 18,
              color: darkBlueColor,
            ),
          ),
          buildProductsFromListview()
        ],
      ),
    );
  }

Widget buildProductsFromListview() {
  var products = orderdetails?['GeneralProducts'] as Map<String, dynamic>?;

  if (products == null) {
    // Handle the case where 'Products' is null or not a Map
    return Container();
  }

  var productIds = products.keys.toList();

 List<Widget> orderGeneralProductContainers = [];

for (int index = 0; index < productIds.length; index++) {
  var productId = productIds[index];
  var productData = products[productId] as Map<String, dynamic>;

  if (productData != null) {
    String title = productData['title'] ?? '';
    String img = productData['img'] ?? '';
    int count = productData['count'] ?? 0;
    num productsorderamount = productData['totalPrice'] ?? 0;

    orderGeneralProductContainers.add(OrderGeneralProductContainer(
      isQtyReq: isQtyReq,
      count: count,
      title: title,
      img: img,
      productsorderamount: productsorderamount,
    ));
  }
}

return Column(
  children: orderGeneralProductContainers,
);

}


}
