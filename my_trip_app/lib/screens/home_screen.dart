import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_trip_app/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_trip_app/models/next_destination.dart';
import 'package:my_trip_app/screens/login_screen.dart';
import 'package:my_trip_app/screens/new_trip_plan.dart';
import 'package:my_trip_app/screens/profile_screen.dart';
import 'package:my_trip_app/screens/trip_plan_screen.dart';
import 'package:my_trip_app/widgets/custom_button.dart';

import '../models/plan.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = Auth().currentUser;
  int currentIndex = 0;
  int bottomTabIndex = 0;

  late List<Widget> items = [];

  late List<Widget> popularDestinations = [];

  final List<Widget> bestDeals = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4))
              ]),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Image.asset(
                  'assets/images/dummy_datas/punta_cana.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                left: 115,
                top: 10,
                child: Text(
                  "Punta Cana Resort",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Positioned(
                left: 115,
                top: 30,
                child: Text(
                  "Other location details",
                  maxLines: null,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              const Positioned(
                left: 115,
                bottom: 15,
                child: Text(
                  "100 EUR/night",
                  maxLines: null,
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4))
              ]),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Image.asset(
                  'assets/images/dummy_datas/bali.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                left: 115,
                top: 10,
                child: Text(
                  "Bali Resort",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Positioned(
                left: 115,
                top: 30,
                child: Text(
                  "Other location details",
                  maxLines: null,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              const Positioned(
                left: 115,
                bottom: 15,
                child: Text(
                  "150 EUR/night",
                  maxLines: null,
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4))
              ]),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Image.asset(
                  'assets/images/dummy_datas/maldives.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                left: 115,
                top: 10,
                child: Text(
                  "Maldives Resort",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Positioned(
                left: 115,
                top: 30,
                child: Text(
                  "Other location details",
                  maxLines: null,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              const Positioned(
                left: 115,
                bottom: 15,
                child: Text(
                  "75 EUR/night",
                  maxLines: null,
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
    ),
  ];

  List<dynamic> destinations = [];
  late NextDestination nextDestination;

  // TODO create futureDestination
  // TODO create history

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  initState() {
    super.initState();
  }

  late Plan plan;

  Future<List<dynamic>> _fetchDestinationsFromFirebase() async {
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: Auth().currentUser?.email)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      final userId = userQuerySnapshot.docs.first.id;
      var trips = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('trip-plan')
          .get();

      if (trips.docs.isNotEmpty) {
        trips.docs.forEach((element) => {
              //plan = Plan.fromMap(element as Map<String, dynamic>),
              destinations.contains(element) ? null : destinations.add(element)
            });
      }
    }

    return destinations;
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        signOut,
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())),
      },
      child: const Text('SignOut'),
    );
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
          child: FutureBuilder(
            future: _fetchDestinationsFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                plan = Plan.fromJson(destinations[0]);
                String destinationName = destinations.first['destination'];
                destinationName =
                    destinationName.substring(0, destinationName.indexOf(','));

                String countryName = destinations.first['destination'];
                countryName = countryName.substring(
                    countryName.indexOf(',') + 2,
                    countryName.length); // TODO separate them in model!!

                List<String> images = [destinations.first['imageUrl']];
                // ImageDestination image2 = await fetchImages(destinationName);
                // ImageDestination image3 = await fetchImages(countryName.toUpperCase());
                // images.addAll([image2.url, image3.url]);

                nextDestination = NextDestination(
                  destinationName: destinationName,
                  countryName: countryName,
                  images: images, // TODO fix
                );

                items = [
                  // TODO improve
                  Image.network(
                    nextDestination.images[0],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Image.network(
                    nextDestination.images[0],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Image.network(
                    nextDestination.images[0],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ];

                popularDestinations = [
                  // TODO improve
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            if (destinations.isNotEmpty) {
                              Plan trip = Plan.fromJson(destinations[0]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TripPlanScreen(plan: trip),
                                ),
                              );
                            }
                          }),
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image:
                                    NetworkImage(destinations[0]['imageUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 25,
                        child: Text(
                          destinations[0]['destination'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            if (destinations.isNotEmpty) {
                              Plan trip = Plan.fromJson(destinations[1]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TripPlanScreen(plan: trip),
                                ),
                              );
                            }
                          }),
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image:
                                    NetworkImage(destinations[1]['imageUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 25,
                        child: Text(
                          destinations[1]['destination'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            if (destinations.isNotEmpty) {
                              Plan trip = Plan.fromJson(destinations[2]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TripPlanScreen(plan: trip),
                                ),
                              );
                            }
                          }),
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image:
                                    NetworkImage(destinations[2]['imageUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 25,
                        child: Text(
                          destinations[2]['destination'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            if (destinations.isNotEmpty) {
                              Plan trip = Plan.fromJson(destinations[3]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TripPlanScreen(plan: trip),
                                ),
                              );
                            }
                          }),
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image:
                                    NetworkImage(destinations[3]['imageUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 25,
                        child: Text(
                          destinations[3]['destination'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 10),
                      child: Text(
                        "Next Destination",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: false,
                              aspectRatio: 1,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                            ),
                            items: items,
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          right: 50,
                          child: DotsIndicator(
                            dotsCount: items.length,
                            position: currentIndex.toDouble(),
                            decorator: const DotsDecorator(
                                color: Color.fromARGB(255, 199, 199, 199),
                                activeColor: Colors.cyan,
                                spacing: EdgeInsets.all(4)),
                          ),
                        ),
                        Positioned(
                          bottom: 7,
                          left: 35,
                          child: CustomButton(
                            onTap: () {
                              setState(() {
                                if (destinations.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TripPlanScreen(plan: plan),
                                    ),
                                  );
                                }
                              });
                            },
                            withGradient: false,
                            text: "View details",
                            color: Colors.cyan,
                            width: 125,
                            textColor: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 135,
                          left: 55,
                          child: Text(
                            nextDestination.destinationName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 120,
                          left: 55,
                          child: Text(
                            "___",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 95,
                          left: 55,
                          child: Text(
                            nextDestination.countryName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 10),
                      child: Text(
                        "Future Destinations",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: popularDestinations,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 10),
                      child: Text(
                        "History",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: bestDeals,
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
