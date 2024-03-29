import 'package:acbaradiseservicepartner/Authentication/SigninScreen.dart';
import 'package:acbaradiseservicepartner/Screens/CompletedOrdersScreen.dart';
import 'package:acbaradiseservicepartner/Screens/OrdersScreen.dart';
import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:acbaradiseservicepartner/Widgets/SingleWidgets/DrawerChildContioner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/link.dart';

class DrawerWidget extends StatelessWidget {
  final String uid;

  DrawerWidget({required this.uid});
  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('ServicePartner')
          .doc(uid)
          .get();
      return userDoc.data() ?? {};
    } catch (e) {
      print("Error fetching user data from Firestore: $e");
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(); // Show loading indicator while data is being fetched
        }

        String name = snapshot.data?['name'] ?? '';
        String email = snapshot.data?['email'] ?? '';
        String number = snapshot.data?['number'] ?? '';

        return Drawer(
          // Rest of your existing code...
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: lightBlue50Color,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            const  Text(
                                'Welcome',
                                style:  TextStyle(
                                  fontFamily: "SumanaBold",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 22,
                                  color: blackColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                name,
                                style: const TextStyle(
                                  fontFamily: "SumanaRegular",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20,
                                  color: blackColor,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                email,
                                style: const TextStyle(
                                  fontFamily: "SumanaRegular",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  color: blackColor,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '+91 '+number,
                                style: const TextStyle(
                                  fontFamily: "SumanaRegular",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrdersScreen(uid: uid)),
                    );
                  },
                  child: DrawerChildContioner(
                      name: "Current Orders", ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompletedOrdersScreen(uid: uid)
                      ),
                    );
                  },
                  child: DrawerChildContioner(
                      name: "Completed Orders", ),
                ),
                
                Link(
                    uri: Uri.parse('https://acbaradise.com/'),
                    target: LinkTarget.blank,
                    builder: ((context, FollowLink) => GestureDetector(
                          onTap: FollowLink,
                          child: DrawerChildContioner(
                            name: "Annual Us",
                         ),
                        ))), // Replace wit;h desired URL

                Link(
                    uri: Uri.parse('https://acbaradise.com/support'),
                    target: LinkTarget.blank,
                    builder: ((context, FollowLink) => GestureDetector(
                          onTap: FollowLink,
                          child: DrawerChildContioner(
                            name: "Support",
                          ),
                        ))),
               GestureDetector(
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SigninScreen(
                          uid: uid,
                        );
                      }));
                    } on FirebaseAuthException catch (e) {
                      throw e.message!;
                    } catch (e) {
                      throw "Unable to logout, Try again";
                    }
                  },
                  child: DrawerChildContioner(
                      name: "Logout", ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
