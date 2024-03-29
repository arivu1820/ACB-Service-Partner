import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static Future<String?> getUid() async {
    User? user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      // User is not logged in
      return null;
    }
  }

//#######################################################################################################//

  Future<void> updateWorkDone(
      String uid, String orderId, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Work Done'),
        content: const Text(
            'If your work completed, then confirm. It wil reflect to Administrator.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);

              final CollectionReference servicePartnerRef =
                  FirebaseFirestore.instance.collection('ServicePartner');

              try {
                // Update 'workDone' field in ServicePartner
                await servicePartnerRef
                    .doc(uid)
                    .collection('CurrentOrdersDetails')
                    .doc(orderId)
                    .update(
                        {'workDone': true, 'completedTime': DateTime.now()});

                // Check if the order is in CurrentOrders
                DocumentSnapshot orderSnapshot = await FirebaseFirestore
                    .instance
                    .collection('CurrentOrders')
                    .doc(orderId)
                    .get();

                if (orderSnapshot.exists) {
                  // Update 'completed' field under OnDutyPartner
                  await FirebaseFirestore.instance
                      .collection('CurrentOrders')
                      .doc(orderId)
                      .collection('OnDutyPartner')
                      .doc(uid)
                      .update({'completed': true});
                } else {
                  // Check if the order is in CompletedCurrentOrders
                  DocumentSnapshot completedOrderSnapshot =
                      await FirebaseFirestore.instance
                          .collection('CompletedOrders')
                          .doc(orderId)
                          .collection('OnDutyPartner')
                          .doc(uid)
                          .get();

                  if (completedOrderSnapshot.exists) {
                    // Update 'completed' field under OnDutyPartner
                    await servicePartnerRef
                        .doc(uid)
                        .collection('CompletedOrders')
                        .doc(orderId)
                        .collection('OnDutyPartner')
                        .doc(uid)
                        .update({'completed': true});
                  } else {
                    // Show dialog to confirm
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error to confirm'),
                        content: Text(
                            'Contact AC Baradise Administrator to sort out this issue.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('Okay'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              } catch (error) {
                print('Error updating workDone: $error');
                // Handle error
              }
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  //#######################################################################################################//

  Future<void> updateAMCWorkDone(
      String uid, String orderId, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Work Done'),
        content: const Text(
            'If your work completed, then confirm. It wil reflect to Administrator.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);

              final CollectionReference servicePartnerRef =
                  FirebaseFirestore.instance.collection('ServicePartner');

              try {
                // Update 'workDone' field in ServicePartner
                await servicePartnerRef
                    .doc(uid)
                    .collection('CurrentAMCOrdersDetails')
                    .doc(orderId)
                    .update(
                        {'workDone': true, 'completedTime': DateTime.now()});

                // Check if the order is in CurrentOrders
                DocumentSnapshot orderSnapshot = await FirebaseFirestore
                    .instance
                    .collection('CurrentAMCSubscription')
                    .doc(orderId)
                    .get();

                if (orderSnapshot.exists) {
                  // Update 'completed' field under OnDutyPartner
                  await FirebaseFirestore.instance
                      .collection('CurrentAMCSubscription')
                      .doc(orderId)
                      .collection('OnDutyPartner')
                      .doc(uid)
                      .update({'completed': true});
                } else {
                  // Check if the order is in CompletedCurrentOrders
                  DocumentSnapshot completedOrderSnapshot =
                      await FirebaseFirestore.instance
                          .collection('CompletedAMCSubscription')
                          .doc(orderId)
                          .collection('OnDutyPartner')
                          .doc(uid)
                          .get();

                  if (completedOrderSnapshot.exists) {
                    // Update 'completed' field under OnDutyPartner
                    await servicePartnerRef
                        .doc(uid)
                        .collection('CompletedAMCSubscription')
                        .doc(orderId)
                        .collection('OnDutyPartner')
                        .doc(uid)
                        .update({'completed': true});
                  } else {
                    // Show dialog to confirm
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error to confirm'),
                        content: Text(
                            'Contact AC Baradise Administrator to sort out this issue.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('Okay'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              } catch (error) {
                print('Error updating workDone: $error');
                // Handle error
              }
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  //#######################################################################################################//
  Future<void> RemoveAMCContainer(
      String uid, String orderId, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove?'),
        content: const Text(
            'Are you sure you want to remove this order from the main page? If you remove this order, it will be stored in your history.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);

              final CollectionReference servicePartnerRef =
                  FirebaseFirestore.instance.collection('ServicePartner');

              try {
                // Retrieve document data before deleting
                DocumentSnapshot<Map<String, dynamic>> orderSnapshot =
                    await servicePartnerRef
                        .doc(uid)
                        .collection('CurrentAMCOrdersDetails')
                        .doc(orderId)
                        .get() as DocumentSnapshot<Map<String, dynamic>>;

                // Ensure that orderSnapshot contains data and is not null
                if (orderSnapshot.exists) {
                  // Store the document data in the CompletedAMCOrders collection
                  await servicePartnerRef
                      .doc(uid)
                      .collection('CompletedAMCOrders')
                      .doc(orderId)
                      .set(orderSnapshot.data()!);

                  // Delete the document from the original collection
                  await servicePartnerRef
                      .doc(uid)
                      .collection('CurrentAMCOrdersDetails')
                      .doc(orderId)
                      .delete() .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          'Order removed and stored in CompletedOrders'),
                    ),
                  );
                });
                  print('Document removed and stored in CompletedAMCOrders');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order does not exist'),
                    ),
                  );
                  print('Document does not exist');
                }
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error removing order: $error'),
                  ),
                );
                print('Error removing order: $error');
                // Handle error
              }
            },
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }

  //#######################################################################################################//
  Future<void> RemoveorderContainer(
      String uid, String orderId, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove?'),
        content: const Text(
            'Are you sure you want to remove this order from the main page? If you remove this order, it will be stored in your history.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);

              final CollectionReference servicePartnerRef =
                  FirebaseFirestore.instance.collection('ServicePartner');

              try {
                // Retrieve document data before deleting
                DocumentSnapshot<Map<String, dynamic>> orderSnapshot =
                    await servicePartnerRef
                        .doc(uid)
                        .collection('CurrentOrdersDetails')
                        .doc(orderId)
                        .get() as DocumentSnapshot<Map<String, dynamic>>;

                // Ensure that orderSnapshot contains data and is not null
                if (orderSnapshot.exists) {
                  // Store the document data in the CompletedAMCOrders collection
                  await servicePartnerRef
                      .doc(uid)
                      .collection('CompletedOrders')
                      .doc(orderId)
                      .set(orderSnapshot.data()!);

                  // Delete the document from the original collection
                  await servicePartnerRef
                    .doc(uid)
                    .collection('CurrentOrdersDetails')
                    .doc(orderId)
                    .delete()
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          'Order removed and stored in CompletedOrders'),
                    ),
                  );
                });

                  print('Document removed and stored in CompletedAMCOrders');
                 
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order does not exist'),
                    ),
                  );
                  print('Order does not exist');
                }
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error removing document: $error'),
                  ),
                );
                print('Error removing order: $error');
                // Handle error
              }
            },
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }
}
