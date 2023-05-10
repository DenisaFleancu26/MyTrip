import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_trip_app/screens/edit_plan.dart';

import 'package:my_trip_app/screens/home_screen.dart';
import 'package:my_trip_app/screens/profile_screen.dart';
import 'package:my_trip_app/screens/new_trip_plan.dart';

class TripPlanScreen extends StatefulWidget {
  const TripPlanScreen({Key? key}) : super(key: key);

  @override
  State<TripPlanScreen> createState() => _TripPlanScreenState();
}

class _TripPlanScreenState extends State<TripPlanScreen> {
  User user = FirebaseAuth.instance.currentUser!;

  String _bigPhoto = 'assets/images/dummy_datas/corfu1.jpg';
  final String _smallPhoto1 = 'assets/images/dummy_datas/corfu1.jpg';
  final String _smallPhoto2 = 'assets/images/dummy_datas/corfu2.jpg';
  final String _smallPhoto3 = 'assets/images/dummy_datas/corfu3.jpg';

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
                  image: AssetImage(_bigPhoto),
                  fit: BoxFit.cover,
                ),
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
                            builder: (context) => const EditPlanScreen()),
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
                      onTap: () => {},
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
                )
              ],
            ),
          ),
          Positioned(
            bottom: 70,
            left: 25,
            child: Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(width: 10),
                Text(
                  "Corfu",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 40,
            left: 25,
            child: Text(
              "Corfu, Greece",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            bottom: 15,
            left: 25,
            child: Text(
              "15/10/2023 - 20/10/2023",
              style: TextStyle(
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
                        _changeBigPhoto(_smallPhoto1),
                        _selectedPhotoIndex = 1
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Transform.scale(
                          scale: _selectedPhotoIndex == 1 ? 1.5 : 1.0,
                          child: Image.asset(
                            _smallPhoto1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () => {
                        _changeBigPhoto(_smallPhoto2),
                        _selectedPhotoIndex = 2
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Transform.scale(
                          scale: _selectedPhotoIndex == 2 ? 1.5 : 1.0,
                          child: Image.asset(
                            _smallPhoto2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () => {
                        _changeBigPhoto(_smallPhoto3),
                        _selectedPhotoIndex = 3
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Transform.scale(
                          scale: _selectedPhotoIndex == 3 ? 1.5 : 1.0,
                          child: Image.asset(
                            _smallPhoto3,
                            fit: BoxFit.cover,
                          ),
                        ),
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
                                children: const [
                                  Text(
                                    "Name:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "Pink Hotel",
                                    style: TextStyle(
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
                              Container(
                                width: 250,
                                child: const Text(
                                  "20 Bis Rue Dugommier, 75012 Corfu, Greece",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: const [
                                  Text(
                                    "Contact:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "+33143434773",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: const [
                                  Text(
                                    "Check_In:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "12:00",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: const [
                                  Text(
                                    "Check_Out:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "10:00",
                                    style: TextStyle(
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
                                children: const [
                                  Text(
                                    "Transport:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "Plane",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: const [
                                  Text(
                                    "Departure to destination:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "15:30",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: const [
                                  Text(
                                    "Departure from destination:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "16:00",
                                    style: TextStyle(
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
                                child: const Text(
                                  "Don't forget your passport and call the hotel before take-off.",
                                  style: TextStyle(
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
          ),
        ],
      ),
    );
  }
}
