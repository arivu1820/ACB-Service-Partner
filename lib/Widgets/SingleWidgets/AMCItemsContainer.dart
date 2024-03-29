import 'dart:io';

import 'package:acbaradiseservicepartner/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AMCItemsContainer extends StatefulWidget {
  final String img,uid,orderid;
  final String title;
  final List<dynamic> benefits;
  final bool includespares;


  AMCItemsContainer({
    Key? key,
    required this.img,
    required this.title,
    required this.uid,
    required this.orderid,
    required this.benefits,
    required this.includespares,
  }) : super(key: key);

  @override
  _AMCItemsContainerState createState() => _AMCItemsContainerState();
}

class _AMCItemsContainerState extends State<AMCItemsContainer> {
  final ImagePicker _picker = ImagePicker();
  late File? _pickedImage;

Future<void> _pickImage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _pickedImage = File(pickedFile.path);
    });

    // Show dialog confirming the selection
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('You selected:'),
        content: _pickedImage != null ? Image.file(_pickedImage!) : SizedBox(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_pickedImage != null) {
                try {
                  // Show circular progress indicator
                  showDialog(
                    context: context,
                    builder: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  // Upload image to Firebase Storage
                  final ref = firebase_storage.FirebaseStorage.instance
                      .ref()
                      .child('images').child('UsersAMC')
                      .child(widget.uid)
                      .child('${widget.orderid}.jpg');

                  final uploadTask = ref.putFile(_pickedImage!);
                  final snapshot = await uploadTask.whenComplete(() {});

                  // Get the download URL
                  final downloadURL = await snapshot.ref.getDownloadURL();

                  // Close the circular progress indicator dialog
                  Navigator.of(context).pop();

                  // Close the selection dialog
                  Navigator.of(context).pop();

                  // Check if the order ID exists in CurrentAMCOrdersDetails
                  final CollectionReference servicePartnerRef =
                      FirebaseFirestore.instance.collection('ServicePartner');

                  final currentOrderSnapshot = await servicePartnerRef
                      .doc(widget.uid)
                      .collection('CurrentAMCOrdersDetails')
                      .doc(widget.orderid)
                      .get();

                  if (currentOrderSnapshot.exists) {
                    // Update image URL in CurrentAMCOrdersDetails
                    await servicePartnerRef
                        .doc(widget.uid)
                        .collection('CurrentAMCOrdersDetails')
                        .doc(widget.orderid)
                        .update({'Image': downloadURL});
                  } else {
                    // Update image URL in CompletedAMCOrders
                    await servicePartnerRef
                        .doc(widget.uid)
                        .collection('CompletedAMCOrders')
                        .doc(widget.orderid)
                        .set({'Image': downloadURL}, SetOptions(merge: true));
                  }

                  final CollectionReference amc1orderRef =
                      FirebaseFirestore.instance.collection('CurrentAMCSubscription');

                  final OrderSnapshot1 = await amc1orderRef
                    
                      .doc(widget.orderid)
                      .get();

                  if (OrderSnapshot1.exists) {
                    // Update image URL in CurrentAMCOrdersDetails
                    await amc1orderRef
                        .doc(widget.orderid)
                        .update({'Image': downloadURL});
                  } else {
                    // Update image URL in CompletedAMCOrders
                    await 
                        FirebaseFirestore.instance.collection('CompletedAMCSubscription')
                        .doc(widget.orderid)
                        .set({'Image': downloadURL}, SetOptions(merge: true));
                  }

                  // Show dialog confirming the upload
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Image Uploaded!'),
                      content: Text('Download URL: $downloadURL'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Okay'),
                        ),
                      ],
                    ),
                  );
                } catch (error) {
                  print('Error uploading image: $error');
                  // Handle error
                }
              }
            },
            child: Text('Upload'),
          ),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AMC',
          style: TextStyle(
            fontFamily: 'SumanaRegular',
            fontSize: 20,
            color: darkBlueColor,
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'SumanaRegular',
                  fontSize: 16,
                  color: blackColor,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            widget.img.isEmpty
                  ?
            GestureDetector(
              onTap: _pickImage, // Call the function to open image picker
              child:  Image.asset(
                      'Assets/Icons/upload.png',
                      width: 40,
                      height: 40,
                    )
                  
            ):GestureDetector(
  onTap: () {
    if (widget.img.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.network(
              widget.img,
              width: MediaQuery.of(context).size.width * 0.8, // Adjust as needed
            ),
          ),
        ),
      );
    }
  },
  child: widget.img.isEmpty
      ? Image.asset(
          'Assets/Icons/upload.png',
          width: 40,
          height: 40,
        )
      : Image.network(
          widget.img,
          width: 40,
          height: 40,
        ),
)

          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Benefits:',
                style: TextStyle(
                  fontFamily: 'SumanaBold',
                  fontSize: 18,
                  color: blackColor,
                ),
              ),
            ),
            if (widget.includespares)
              const Text(
                'Spares Included',
                style: TextStyle(
                  fontFamily: 'SumanaBold',
                  fontSize: 16,
                  color: leghtGreen,
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        // List of benefits
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.benefits.map<Widget>((benefit) {
            return Text(
              '- $benefit',
              style: const TextStyle(
                fontFamily: 'SumanaRegular',
                fontSize: 16,
                color: blackColor,
              ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
