import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/CombinedWidgets/OrdersContioner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompletedOrdersScreen extends StatefulWidget {
  final String uid;
  const CompletedOrdersScreen({super.key, required this.uid});

  @override
  State<CompletedOrdersScreen> createState() => _CompletedOrdersScreenState();
}

class _CompletedOrdersScreenState extends State<CompletedOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Container(
          color: leghtGreen,
          width: double.infinity,
          height: 40,
          child: const Center(
            child: Text(
              'Till Now Completed Orders',
              style: TextStyle(
                  fontFamily: 'SumanaRegular', fontSize: 16, color: whiteColor),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder(
          future: _combineStreams(widget.uid),
          builder:
              (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
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
                child: Text('No Orders Available'),
              );
            }
        
            return Expanded(
              child: ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final document = docs[index];
                  final orderData =
                      document.data() as Map<String, dynamic>?;
        
                  if (orderData != null) {
                    final orderName = (orderData['name'] as String?) ??
                        ''; // Name for orders
                    final amcName = (orderData['Name'] as String?) ??
                        ''; // Name for AMC
        
                    final ordercontact =
                        (orderData['contact'] as String?) ??
                            ''; // Name for orders
                    final amccontact = (orderData['Contact'] as String?) ??
                        ''; // Name for AMC
        
                    final orderaddress =
                        (orderData['address'] as String?) ??
                            ''; // Name for orders
                    final amcaddress = (orderData['Address'] as String?) ??
                        ''; // Name for AMC
        
                    final lat = (orderData['lat'] as String?) ?? '';
                    final lon = (orderData['lon'] as String?) ?? '';
        
                    ////////////////////////////////////////
        
                    final totalamount =
                        (orderData['totalamount'] as num?) ?? 0;
                    final orderPaymentstatus =
                        (orderData['orderPayment'] as String?) ?? '';
                    final email = (orderData['email'] as String?) ?? '';
                    final orderDetails =
                        (orderData['OrderDetails'] as List<dynamic>?) ?? [];
                    final serviceno =
                        (orderData['serviceno'] as String?) ?? '';
                    final img = (orderData['Image'] as String?) ?? '';
                    final title = (orderData['Title'] as String?) ?? '';
                    final sparesincluded =
                        (orderData['SparesIncluded'] as bool?) ?? false;
                    final iscompleted =
                        (orderData['workDone'] as bool?) ?? false;
        
                    final claimed =
                        (orderData['Claimed'] as bool?) ?? false;
                    final benefits =
                        (orderData['Benefits'] as List<dynamic>?) ?? [];
        
                    // Determine if it's an AMC order based on the collection
                    final isAMC = document.reference.parent!.id ==
                        'CompletedAMCOrders';
        
                    return OrdersContaier(
                      name: isAMC ? amcName : orderName,
                      lat: lat,
                      lon: lon,
                      uid: widget.uid,
                      ishistory: true,
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
              ),
            );
          },
        ),
      ]),
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
        .collection('CompletedOrders')
        .get();

    final amcOrderStream = FirebaseFirestore.instance
        .collection('ServicePartner')
        .doc(uid)
        .collection('CompletedAMCOrders')
        .get();

    final orderDocs = await orderStream;
    final amcOrderDocs = await amcOrderStream;

    final List<DocumentSnapshot> combinedDocs = [];

    combinedDocs.addAll(orderDocs.docs);
    combinedDocs.addAll(amcOrderDocs.docs);

    // Sort the combinedDocs by timestamp
    combinedDocs.sort((a, b) => (a['completedTime'] as Timestamp)
        .compareTo(b['completedTime'] as Timestamp));

    return combinedDocs;
  }

  void _refreshData() {
    setState(() {
      // Call setState to trigger a refresh of the screen
    });
  }
}
