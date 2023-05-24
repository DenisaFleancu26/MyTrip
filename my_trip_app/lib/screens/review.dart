import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_trip_app/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_trip_app/screens/new_trip_plan.dart';
import 'package:my_trip_app/screens/profile_screen.dart';
import '../models/plan.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class ReviewScreen extends StatefulWidget {
  final Plan plan;
  const ReviewScreen({Key? key, required this.plan}) : super(key: key);
  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  final User? user = Auth().currentUser;
  int currentIndex = 0;
  int bottomTabIndex = 0;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  final TextEditingController _controllerReview = TextEditingController();

  double rating = 0;

  void selectImage() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
  }

  Future saveReview() async {}

  Future uploadFile() async {
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: Auth().currentUser?.email)
        .get();

    late var tripId;
    late var userId;

    if (userQuerySnapshot.docs.isNotEmpty) {
      userId = userQuerySnapshot.docs.first.id;
      var trip = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('trip-plan')
          .where('start', isEqualTo: widget.plan.tripStart)
          .where('end', isEqualTo: widget.plan.tripEnd)
          .where('name', isEqualTo: widget.plan.name)
          .where('destination', isEqualTo: widget.plan.destination)
          .where('hotel', isEqualTo: widget.plan.hotel)
          .where('address', isEqualTo: widget.plan.address)
          .where('contact', isEqualTo: widget.plan.contact)
          .where('check-in', isEqualTo: widget.plan.checkIn)
          .where('check-out', isEqualTo: widget.plan.checkOut)
          .where('transport', isEqualTo: widget.plan.transport)
          .where('departure', isEqualTo: widget.plan.departure)
          .where('return', isEqualTo: widget.plan.retur)
          .where('imageUrl', isEqualTo: widget.plan.imageUrl)
          .where('notes', isEqualTo: widget.plan.notes);

      var querySnapshot = await trip.get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs[0];
        tripId = documentSnapshot.reference.id;
      }
    }
    if (imageFileList != null) {
      for (var img in imageFileList!) {
        var path = File(img.path);
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('$userId/$tripId/images/${Path.basename(img.path)}');
        await ref.putFile(path).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            imgRef.add({'url': value});
          });
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imagesURLs');
  }

  void _onItemTapped(int index) {
    setState(() {
      bottomTabIndex = index;
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewTripPlanScreen()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'New Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
        currentIndex: bottomTabIndex,
        selectedItemColor: Colors.cyan,
        onTap: _onItemTapped,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 35, top: 20),
              child: Row(
                children: [
                  const Icon(Icons.location_on, size: 40, shadows: <Shadow>[
                    Shadow(
                        offset: Offset(2.0, 3.0),
                        blurRadius: 4.0,
                        color: Color.fromARGB(159, 66, 66, 66)),
                  ]),
                  const SizedBox(width: 10),
                  Text(
                    widget.plan.destination,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1.0, 2.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(159, 66, 66, 66)),
                        ]),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 0, 206, 203),
                      Color.fromARGB(245, 4, 116, 177),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                child: Text(
                  "Let's save some of your memories",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: GestureDetector(
                onTap: selectImage,
                child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage(
                            "assets/images/dummy_datas/maldives.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.file_upload,
                            size: 60,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 4.0,
                                  color: Color.fromARGB(159, 66, 66, 66)),
                            ]),
                        Text(
                          "Upload photos",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 4.0,
                                    color: Color.fromARGB(159, 66, 66, 66)),
                              ]),
                        ),
                      ],
                    )),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 206, 203),
                        Color.fromARGB(245, 4, 116, 177),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 40, right: 30, top: 5, bottom: 5),
                  child: Text(
                    "Rate your trip",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Text(
                    "Rating: $rating",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RatingBar.builder(
                  minRating: 1,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) => setState(() {
                    this.rating = rating;
                  }),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 0, 206, 203),
                      Color.fromARGB(245, 4, 116, 177),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 20, top: 5, bottom: 5),
                child: Text(
                  "How was your trip to ${widget.plan.destination}?",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4))
                    ]),
                child: TextField(
                  controller: _controllerReview,
                  decoration: InputDecoration(
                    hintText: "My trip was..",
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 202, 202, 202)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 30, top: 15, bottom: 15),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 5,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: CustomButton(
                onTap: saveReview,
                withGradient: true,
                text: "Save",
                height: 40,
                colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                colorGradient2: const Color.fromARGB(245, 4, 116, 177),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
