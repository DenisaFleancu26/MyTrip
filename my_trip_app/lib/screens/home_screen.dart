import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_trip_app/screens/trip_plan_screen.dart';
import 'package:my_trip_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_trip_app/models/next_destination.dart';
import 'package:my_trip_app/screens/new_trip_plan.dart';
import 'package:my_trip_app/screens/profile_screen.dart';
import 'package:my_trip_app/widgets/custom_next_destination.dart';
import 'package:my_trip_app/widgets/custom_past_destination.dart';
import 'package:my_trip_app/widgets/custom_popular_destination.dart';

import '../models/plan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = Auth().currentUser;
  int bottomTabIndex = 0;

  late List<Widget> futureDestinations = [];
  late List<PastDestination> pastDestinations = [];
  late List<Widget> pastDestinationsWidgets = [];

  List<dynamic> destinations = [];
  late NextDestination nextDestination;

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
        for (var element in trips.docs) {
          destinations.contains(element.id) ? null : destinations.add(element);
        }
      }
    }
    return destinations;
  }

  Future<List<dynamic>> _fetchAllData() async {
    await _fetchDestinationsFromFirebase();
    _populateNextDestinationWidget();
    _populateFutureDestinationWidgets();
    _populatePastDestinationWidgets();

    return destinations;
  }

  void _onItemTapped(int index) {
    setState(() {
      bottomTabIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NewTripPlanScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
          break;
      }
    });
  }

  _populateNextDestinationWidget() {
    String destinationName = destinations.first['destination'];
    String countryName = destinations.first['destination'];
    List<String> images = [
      destinations.first['imageUrl'],
      destinations.first['imageUrl2'],
      destinations.first['imageUrl3'],
      destinations.first['imageUrl4']
    ];

    nextDestination = NextDestination(
      destinationName: destinationName,
      countryName: countryName,
      images: images,
    );
  }

  _populateFutureDestinationWidgets() {
    for (int i = 0; i < destinations.length; i++) {
      Plan plan = Plan(
          tripStart: destinations[i]['start'],
          tripEnd: destinations[i]['end'],
          name: destinations[i]['name'],
          destination: destinations[i]['destination'],
          hotel: destinations[i]['hotel'],
          address: destinations[i]['address'],
          contact: destinations[i]['contact'],
          checkIn: destinations[i]['check-in'],
          checkOut: destinations[i]['check-out'],
          transport: destinations[i]['transport'],
          departure: destinations[i]['departure'],
          retur: destinations[i]['return'],
          imageUrl: destinations[i]['imageUrl'],
          notes: destinations[i]['notes'],
          rating: "",
          review: "");

      futureDestinations.add(CustomPopularDestination(
        destinations: destinations,
        index: i,
        onPress: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TripPlanScreen(plan: plan))),
      ));
    }
  }

  _populatePastDestinationWidgets() {
    for (var destination in destinations) {
      pastDestinations.add(PastDestination(
          destinationName: destination['name'],
          countryName: destination['destination'],
          feedback: "feedback sth sth",
          image: destination['imageUrl']));
    }

    for (int i = 0; i < pastDestinations.length; i++) {
      pastDestinationsWidgets
          .add(CustomPastDestination(pastDestination: pastDestinations[i]));
    }
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
                future: _fetchAllData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                        CustomNextDestination(nextDestination: nextDestination),
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
                            children: futureDestinations,
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
                            children: pastDestinationsWidgets,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                })));
  }
}
