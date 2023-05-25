import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_trip_app/screens/home_screen.dart';
import 'package:my_trip_app/screens/profile_screen.dart';
import 'package:my_trip_app/screens/new_trip_plan.dart';

import '../auth.dart';
import '../models/plan.dart';

class HistoryScreen extends StatefulWidget {
  final Plan plan;
  const HistoryScreen({Key? key, required this.plan}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  late String _bigPhoto;
  late final String _smallPhoto1;
  late final String _smallPhoto2;
  late final String _smallPhoto3;

  double rating = 3.0;

  @override
  void initState() {
    super.initState();
    _bigPhoto = widget.plan.imageUrl;
    _smallPhoto1 = widget.plan.imageUrl;
    _smallPhoto2 = 'assets/images/dummy_datas/corfu2.jpg';
    _smallPhoto3 = 'assets/images/dummy_datas/corfu3.jpg';
  }

  int bottomTabIndex = 0;
  int _selectedPhotoIndex = 1;
  int _buttonSelected = 1;
  bool _hotelVisible = true;
  bool _transportVisible = false;
  bool _notesVisible = false;

  void _toggleHotel() {
    setState(() {
      _hotelVisible = true;
      _transportVisible = false;
      _notesVisible = false;
    });
  }

  void _toggleTransport() {
    setState(() {
      _hotelVisible = false;
      _transportVisible = true;
      _notesVisible = false;
    });
  }

  void _toggleNotes() {
    setState(() {
      _hotelVisible = false;
      _transportVisible = false;
      _notesVisible = true;
    });
  }

  void _changeBigPhoto(String photo) async {
    setState(() {
      _bigPhoto = photo;
    });
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
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> destination = [
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(30)),
                image: DecorationImage(
                  image: NetworkImage(_bigPhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 25,
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.plan.name,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 25,
            child: Text(
              widget.plan.destination,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 25,
            child: Text(
              '${widget.plan.tripStart} - ${widget.plan.tripEnd}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: Container(
              transformAlignment: Alignment.center,
              height: 200,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(73, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 4))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () => {
                        setState(() {
                          _changeBigPhoto(_smallPhoto1);
                          _selectedPhotoIndex = 1;
                        }),
                      },
                      child: Container(
                        height: 60,
                        width: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(_smallPhoto1),
                              fit: BoxFit.cover),
                        ),
                        transform: Matrix4.diagonal3Values(
                            _selectedPhotoIndex == 1 ? 1.2 : 1.0,
                            _selectedPhotoIndex == 1 ? 1.2 : 1.0,
                            1.0),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () => {
                        setState(() {
                          _changeBigPhoto(_smallPhoto1);
                          _selectedPhotoIndex = 2;
                        }),
                      },
                      child: Container(
                        height: 60,
                        width: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_smallPhoto1),
                            fit: BoxFit.cover,
                          ),
                        ),
                        transform: Matrix4.diagonal3Values(
                            _selectedPhotoIndex == 2 ? 1.2 : 1.0,
                            _selectedPhotoIndex == 2 ? 1.2 : 1.0,
                            1.0),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () => {
                        setState(() {
                          _changeBigPhoto(_smallPhoto1);
                          _selectedPhotoIndex = 3;
                        }),
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Container(
                              height: 60,
                              width: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(_smallPhoto1),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              transform: Matrix4.diagonal3Values(
                                  _selectedPhotoIndex == 3 ? 1.2 : 1.0,
                                  _selectedPhotoIndex == 3 ? 1.2 : 1.0,
                                  1.0),
                              child: new BackdropFilter(
                                filter: new ImageFilter.blur(
                                    sigmaX: 1.0, sigmaY: 1.0),
                                child: new Container(
                                  decoration: new BoxDecoration(
                                      color: Colors.white.withOpacity(0.0)),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 18,
                            left: 10,
                            child: Text(
                              '+250',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[
                                    Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 4.0,
                                        color: Color.fromARGB(159, 66, 66, 66)),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 390,
                    child: ListView(
                      shrinkWrap: true,
                      children: destination,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RotatedBox(
                            quarterTurns: -1,
                            child: GestureDetector(
                              onTap: () => {
                                setState(() {
                                  _buttonSelected = 1;
                                  _toggleHotel();
                                }),
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _buttonSelected == 1
                                      ? const Color.fromARGB(255, 0, 206, 203)
                                      : const Color.fromARGB(39, 71, 71, 71),
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(30)),
                                ),
                                height: 30,
                                width: 80,
                                child: const Center(
                                  child: Text(
                                    "Hotel",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          RotatedBox(
                            quarterTurns: -1,
                            child: GestureDetector(
                              onTap: () => {
                                setState(() {
                                  _buttonSelected = 2;
                                  _toggleTransport();
                                }),
                              },
                              child: Container(
                                height: 30,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: _buttonSelected == 2
                                      ? const Color.fromARGB(255, 0, 206, 203)
                                      : const Color.fromARGB(39, 71, 71, 71),
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(30)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Transport",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          RotatedBox(
                            quarterTurns: -1,
                            child: GestureDetector(
                              onTap: () => {
                                setState(() {
                                  _buttonSelected = 3;
                                  _toggleNotes();
                                }),
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: _buttonSelected == 3
                                      ? const Color.fromARGB(255, 0, 206, 203)
                                      : const Color.fromARGB(39, 71, 71, 71),
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(30)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Notes",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_hotelVisible)
                        Container(
                          padding: const EdgeInsets.only(left: 40, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.hotel,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Hotel details",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  const Text(
                                    "Name:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    widget.plan.hotel,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Address:",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  widget.plan.address,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Contact:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    widget.plan.contact,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Check_In:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    widget.plan.checkIn,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Check_Out:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    widget.plan.checkOut,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (_transportVisible)
                        Container(
                          padding: const EdgeInsets.only(left: 40, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.connecting_airports,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Transport details",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  const Text(
                                    "Transport:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    widget.plan.transport,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Departure to destination:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    widget.plan.departure,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Departure from destination:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    widget.plan.retur,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (_notesVisible)
                        Container(
                          margin: const EdgeInsets.only(left: 40, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.description,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Notes",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Container(
                                width: 250,
                                margin: const EdgeInsets.only(),
                                child: Text(
                                  widget.plan.notes,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
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
                        initialRating: rating,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {},
                        ignoreGestures: true,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 30, top: 5, bottom: 5),
                        child: Text(
                          "Your experience in ${widget.plan.destination}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: const Text(
                      "Bali este o insulă care aparține Indoneziei, din Oceanul Indian, cu un climat mediu tropical cald. Capitala insulei este Denpasar. Cu o suprafață de 5577 km², Bali este de departe cea mai mare insulă din provincia cu același nume. La recensământul din 2010, Bali avea o populație de aproximativ 3,9 milioane de locuitori[3], iar în 2012 era estimată la 4,22 milioane.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
