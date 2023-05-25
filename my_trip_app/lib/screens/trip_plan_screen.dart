import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_trip_app/screens/edit_plan.dart';

import 'package:my_trip_app/screens/home_screen.dart';
import 'package:my_trip_app/screens/profile_screen.dart';
import 'package:my_trip_app/screens/new_trip_plan.dart';
import 'package:my_trip_app/screens/review.dart';

import '../services/auth.dart';
import '../models/plan.dart';

class TripPlanScreen extends StatefulWidget {
  final Plan plan;
  const TripPlanScreen({Key? key, required this.plan}) : super(key: key);

  @override
  State<TripPlanScreen> createState() => _TripPlanScreenState();
}

class _TripPlanScreenState extends State<TripPlanScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  late String _bigPhoto;
  late final String _smallPhoto1;
  late final String _smallPhoto2;
  late final String _smallPhoto3;

  @override
  void initState() {
    super.initState();
    _bigPhoto = widget.plan.imageUrl;
    _smallPhoto1 = widget.plan.imageUrl;
    _smallPhoto2 = widget.plan.imageUrl2;
    _smallPhoto3 = widget.plan.imageUrl3;
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
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
          break;
      }
    });
  }

  Future<void> deletePlan() async {
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: Auth().currentUser?.email)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      final userId = userQuerySnapshot.docs.first.id;
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
        var productDoc = querySnapshot.docs.first;
        var productId = productDoc.id;

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('trip-plan')
            .doc(productId)
            .delete();
      }
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> destination = [
      Stack(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
              image: DecorationImage(
                image: NetworkImage(_bigPhoto),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Row(
              children: [
                Container(
                  transformAlignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(73, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 4))
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditPlanScreen(plan: widget.plan)),
                      ),
                      child: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  transformAlignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(73, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 4))
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: deletePlan,
                      child: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  transformAlignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(73, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 4))
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ReviewScreen(plan: widget.plan)),
                      ),
                      child: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.rate_review,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
              height: 150,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(73, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 4))
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
                        height: 40,
                        width: 40,
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
                          _changeBigPhoto(_smallPhoto2);
                          _selectedPhotoIndex = 2;
                        }),
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_smallPhoto2),
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
                          _changeBigPhoto(_smallPhoto3);
                          _selectedPhotoIndex = 3;
                        }),
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_smallPhoto3),
                            fit: BoxFit.cover,
                          ),
                        ),
                        transform: Matrix4.diagonal3Values(
                            _selectedPhotoIndex == 3 ? 1.2 : 1.0,
                            _selectedPhotoIndex == 3 ? 1.2 : 1.0,
                            1.0),
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
                                    : Color.fromARGB(39, 71, 71, 71),
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
                                    : Color.fromARGB(39, 71, 71, 71),
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
                                    : Color.fromARGB(39, 71, 71, 71),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
