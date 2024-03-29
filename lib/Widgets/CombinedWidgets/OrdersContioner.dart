import 'package:acbaradiseservicepartner/Models/DataBaseHelper.dart';
import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/SingleWidgets/AMCItemsContainer.dart';
import 'package:acbaradiseservicepartner/Widgets/SingleWidgets/OrdersItemContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersContaier extends StatefulWidget {
  final bool iscompleted;

  final String name,
      lat,
      lon,
      address,
      contact,
      title,
      serviceno,
      img,
      uid,
      orderid,
      email,
      paymentstatus;
  final bool sparesinclud, claimed, isamc, ishistory;
  final num totalamt;
  final List<dynamic> benefits, orderdetails;
  OrdersContaier(
      {super.key,
      required this.name,
      required this.lat,
      required this.uid,
      required this.orderid,
      required this.lon,
      required this.contact,
      required this.address,
      required this.isamc,
      this.totalamt = 0,
      this.paymentstatus = '',
      this.iscompleted = false,
      this.ishistory = false,
      this.serviceno = '',
      this.email = '',
      this.title = '',
      this.img = '',
      this.sparesinclud = false,
      this.claimed = false,
      this.benefits = const [],
      this.orderdetails = const []});

  @override
  State<OrdersContaier> createState() => _OrdersContaierState();
}

class _OrdersContaierState extends State<OrdersContaier> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: lightBlueColor,
              blurRadius: 4.0,
              offset: Offset(0.0, 0.0),
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  widget.name,
                  style: const TextStyle(
                      fontFamily: 'SumanaRegular',
                      fontSize: 20,
                      color: blackColor),
                )),
                const Spacer(),
                const Flexible(
                    child: Text(
                  'Location',
                  style: TextStyle(
                      fontFamily: 'SumanaRegular',
                      fontSize: 20,
                      color: darkBlueColor),
                )),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                                    onTap: () => _openMap(widget.lat,widget.lon),
                
                  child: Image.asset(
                    'Assets/Icons/LocationIcon.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (widget.email.isNotEmpty)
              Text(
                widget.email,
                style: const TextStyle(
                    fontFamily: 'SumanaRegular',
                    fontSize: 20,
                    color: blackColor),
              ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '+91 ${widget.contact}',
                  style: const TextStyle(
                      fontFamily: 'SumanaBold',
                      fontSize: 20,
                      color: blackColor),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => _makePhoneCall(widget.contact),
                  child: Text(
                    "Call",
                    style: const TextStyle(
                        fontFamily: 'SumanaBold',
                        fontSize: 20,
                        color: darkBlueColor),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
                child: Text(
              widget.address,
              style: const TextStyle(
                  fontFamily: 'SumanaRegular', fontSize: 20, color: blackColor),
            )),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                if (widget.paymentstatus.isNotEmpty)
                  Text(
                    widget.paymentstatus == 'online' ||
                            widget.paymentstatus == 'confirm'
                        ? 'Paid'
                        : 'COD',
                    style: TextStyle(
                        fontFamily: 'SumanaRegular',
                        fontSize: 20,
                        color: widget.paymentstatus == 'online' ||
                                widget.paymentstatus == 'confirm'
                            ? leghtGreen
                            : darkBlueColor),
                  ),
                if (widget.isamc)
                  Row(
                    children: [
                      Text(
                        widget.serviceno,
                        style: const TextStyle(
                            fontFamily: 'SumanaBold',
                            fontSize: 20,
                            color: darkBlueColor),
                      ),
                      if (widget.claimed)
                        const SizedBox(
                          width: 30,
                        ),
                      if (widget.claimed)
                        const Text(
                          'Claimed',
                          style: TextStyle(
                              fontFamily: 'SumanaRegular',
                              fontSize: 20,
                              color: leghtGreen),
                        ),
                    ],
                  ),
                const Spacer(),
                if (widget.totalamt != 0)
                  Text(
                    'Total: ${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(widget.totalamt)}',
                    style: const TextStyle(
                        fontFamily: 'SumanaBold',
                        fontSize: 20,
                        color: blackColor),
                  )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (!widget.isamc)
              OrdersItemsContainer(
                orderdetails: widget.orderdetails,
              ),
            if (widget.isamc)
              AMCItemsContainer(
                img: widget.img,
                title: widget.title,
                uid: widget.uid,
                orderid: widget.orderid,
                benefits: widget.benefits,
                includespares: widget.sparesinclud,
              ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  widget.iscompleted ? 'Completed' : 'InDuty',
                  style: TextStyle(
                      fontFamily: 'SumanaRegular',
                      fontSize: 16,
                      color: widget.iscompleted ? leghtGreen : darkBlueColor),
                ),
                const Spacer(),
                if (!widget.ishistory)
                  GestureDetector(
                    onTap: widget.iscompleted
                        ? () async {
                            widget.isamc
                                ? await DatabaseHelper().RemoveAMCContainer(
                                    widget.uid, widget.orderid, context)
                                : await DatabaseHelper().RemoveorderContainer(
                                    widget.uid, widget.orderid, context);
                          }
                        : () async {
                            widget.isamc
                                ? await DatabaseHelper().updateAMCWorkDone(
                                    widget.uid, widget.orderid, context)
                                : await DatabaseHelper().updateWorkDone(
                                    widget.uid, widget.orderid, context);
                          },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: widget.iscompleted
                              ? darkGrey50Color
                              : lightBlueColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          widget.iscompleted ? 'Remove' : 'Work Done',
                          style: TextStyle(
                              fontFamily: 'SumanaRegular',
                              fontSize: 18,
                              color: widget.iscompleted
                                  ? brown50Color
                                  : blackColor),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 20,),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
               '#'+ widget.orderid,
                style: const TextStyle(
                    fontFamily: 'SumanaRegular', fontSize: 18, color: blackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

void _openMap(String lat, String lon) {
  try {
    var latitude = double.parse(lat); // Parse latitude string to double
    var longitude = double.parse(lon); // Parse longitude string to double

    MapsLauncher.launchCoordinates(latitude, longitude);
  } catch (e) {
    print('Error opening map: $e');
    // Handle error
  }
}


    void _makePhoneCall(String number) async {
    final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: number);

    try {
      if (await canLaunch(_phoneLaunchUri.toString())) {
        await launch(_phoneLaunchUri.toString());
      } else {
        throw 'Could not launch $_phoneLaunchUri';
      }
    } catch (e) {
      print('Error launching phone call: $e');
      // Handle error
    }
  }
  
}
