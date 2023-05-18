import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_trip_app/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_trip_app/models/next_destination.dart';
import 'package:my_trip_app/screens/new_trip_plan.dart';
import 'package:my_trip_app/screens/profile_screen.dart';
import 'package:my_trip_app/widgets/custom_next_destination.dart';
import 'package:my_trip_app/widgets/custom_past_destination.dart';
import 'package:my_trip_app/widgets/custom_popular_destination.dart';

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

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  initState() {
    super.initState();
    _fetchDestinationsFromFirebase();
  }

  _fetchDestinationsFromFirebase() async {
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
      futureDestinations
          .add(CustomPopularDestination(destinations: destinations, index: i));
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
    _populateNextDestinationWidget();
    _populateFutureDestinationWidgets();
    _populatePastDestinationWidgets();

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
            // child: FutureBuilder(
            //   future: _fetchDestinationsFromFirebase(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {

            // destinationName =
            //     destinationName.substring(0, destinationName.indexOf(','));

            // countryName = countryName.substring(
            //     countryName.indexOf(',') + 2,
            //     countryName.length); // TODO separate them in model!!

            child: Column(
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
            )));
  }
}
