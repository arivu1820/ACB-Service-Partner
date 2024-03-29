import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/CombinedWidgets/DrawerWidget.dart';
import 'package:acbaradiseservicepartner/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acbaradiseservicepartner/Widgets/CombinedWidgets/OrdersContioner.dart';
import 'dart:async';

class OrdersScreen extends StatefulWidget {
  final String uid;

  const OrdersScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            key: _scaffoldKey, // Assigning the key to Scaffold

       appBar: AppBar(
        title: const Text(
          "ACB Service Partner",
          style: TextStyle(
            fontFamily: "SumanaRegular",
            fontSize: 20,
            color: blackColor,
          ),
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Dark2ligthblueLRgradient,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            child: Image.asset(
              'Assets/Icons/list.png', // Replace with the correct path to your image asset
              width: 30, // Adjust the width as needed
              height: 30, // Adjust the height as needed
              color: blackColor, // Set the color of your icon
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      endDrawer: DrawerWidget(
        uid: widget.uid,
      ),
      body: FutureBuilder(
        future: _combineStreams(widget.uid),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final docs = snapshot.data;

          if (docs == null || docs.isEmpty) {
            return const Center(
              child: Text('No Current Orders',style: TextStyle(fontFamily: 'SumanaRegular',color: blackColor,fontSize: 20),),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final document = docs[index];
              final orderData = document.data() as Map<String, dynamic>?;

              if (orderData != null) {
                final orderName =
                    (orderData['name'] as String?) ?? ''; // Name for orders
                final amcName =
                    (orderData['Name'] as String?) ?? ''; // Name for AMC

                final ordercontact =
                    (orderData['contact'] as String?) ?? ''; // Name for orders
                final amccontact =
                    (orderData['Contact'] as String?) ?? ''; // Name for AMC

                final orderaddress =
                    (orderData['address'] as String?) ?? ''; // Name for orders
                final amcaddress =
                    (orderData['Address'] as String?) ?? ''; // Name for AMC

                final lat = (orderData['lat'] as String?) ?? '';
                final lon = (orderData['lon'] as String?) ?? '';

                ////////////////////////////////////////

                final totalamount = (orderData['totalamount'] as num?) ?? 0;
                final orderPaymentstatus =
                    (orderData['orderPayment'] as String?) ?? '';
                final email = (orderData['email'] as String?) ?? '';
                final orderDetails =
                    (orderData['OrderDetails'] as List<dynamic>?) ?? [];
                final serviceno = (orderData['serviceno'] as String?) ?? '';
                final img = (orderData['Image'] as String?) ?? '';
                final title = (orderData['Title'] as String?) ?? '';
                final sparesincluded =
                    (orderData['SparesIncluded'] as bool?) ?? false;
                final iscompleted = (orderData['workDone'] as bool?) ?? false;

                final claimed = (orderData['Claimed'] as bool?) ?? false;
                final benefits =
                    (orderData['Benefits'] as List<dynamic>?) ?? [];

                // Determine if it's an AMC order based on the collection
                final isAMC =
                    document.reference.parent!.id == 'CurrentAMCOrdersDetails';

                return OrdersContaier(
                  name: isAMC ? amcName : orderName,
                  lat: lat,
                  lon: lon,
                  uid: widget.uid,
                  orderid: document.id,
                  iscompleted: iscompleted,
                  contact: isAMC ? amccontact : ordercontact,
                  address: isAMC ? amcaddress : orderaddress,
                  isamc: isAMC,
                  totalamt: totalamount,
                  paymentstatus: orderPaymentstatus,
                  email: email,
                  orderdetails: orderDetails,
                  serviceno: serviceno,
                  img: img,
                  title: title,
                  sparesinclud: sparesincluded,
                  claimed: claimed,
                  benefits: benefits,
                );
              } else {
                // Handle the case when orderData is null
                return SizedBox(); // You can return an empty widget or a loading indicator
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshData,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }

  Future<List<DocumentSnapshot>> _combineStreams(String uid) async {
    final orderStream = FirebaseFirestore.instance
        .collection('ServicePartner')
        .doc(uid)
        .collection('CurrentOrdersDetails')
        .get();

    final amcOrderStream = FirebaseFirestore.instance
        .collection('ServicePartner')
        .doc(uid)
        .collection('CurrentAMCOrdersDetails')
        .get();

    final orderDocs = await orderStream;
    final amcOrderDocs = await amcOrderStream;

    final List<DocumentSnapshot> combinedDocs = [];

    combinedDocs.addAll(orderDocs.docs);
    combinedDocs.addAll(amcOrderDocs.docs);

    // Sort the combinedDocs by timestamp
    combinedDocs.sort((a, b) => (a['currentTime'] as Timestamp)
        .compareTo(b['currentTime'] as Timestamp));

    return combinedDocs;
  }

  void _refreshData() {
    setState(() {
      // Call setState to trigger a refresh of the screen
    });
  }
}
