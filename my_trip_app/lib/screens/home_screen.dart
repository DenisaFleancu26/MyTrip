import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_trip_app/screens/history.dart';
import 'package:my_trip_app/screens/trip_plan_screen.dart';
import 'package:my_trip_app/services/auth.dart';
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
  int bottomTabIndex = 0;

  late List<Widget> futureDestinations = [];
  late List<Widget> pastDestinations = [];

  List<dynamic> destinations = [];
  late NextDestination nextDestination;
  late PastDestination pastDestination;
  late Plan nextPlan;

  final List<Widget> mainTexts = [
    const Text(
      "Store your documents",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    const Text(
      "Book your flights",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    const Text(
      "Store your memories",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
  ];

  int currentIndex = 0;

  final List<Widget> items = [
    Image.asset('assets/images/passport.png'),
    Image.asset('assets/images/travel-itinerary.png'),
    Image.asset('assets/images/image.png'),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

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

    nextPlan = Plan(
        tripStart: destinations.first['start'],
        tripEnd: destinations.first['end'],
        name: destinations.first['name'],
        destination: destinations.first['destination'],
        hotel: destinations.first['hotel'],
        address: destinations.first['address'],
        contact: destinations.first['contact'],
        checkIn: destinations.first['check-in'],
        checkOut: destinations.first['check-out'],
        transport: destinations.first['transport'],
        departure: destinations.first['departure'],
        retur: destinations.first['return'],
        imageUrl: destinations.first['imageUrl'],
        imageUrl2: destinations.first['imageUrl2'],
        imageUrl3: destinations.first['imageUrl3'],
        notes: destinations.first['notes'],
        rating: "",
        review: "");
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
          imageUrl2: destinations[i]['imageUrl2'],
          imageUrl3: destinations[i]['imageUrl3'],
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
    for (int i = 0; i < destinations.length; i++) {
      if (destinations[i]['rating'] != '0.0') {
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
            imageUrl2: destinations[i]['imageUrl2'],
            imageUrl3: destinations[i]['imageUrl3'],
            notes: destinations[i]['notes'],
            rating: destinations[i]['rating'],
            review: destinations[i]['review']);

        pastDestinations.add(CustomPastDestination(
          destinations: destinations,
          index: i,
          onPress: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HistoryScreen(plan: plan))),
        ));
      }
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.cyan));
                  } else if (snapshot.hasData) {
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
                        CustomNextDestination(
                            nextDestination: nextDestination, plan: nextPlan),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 25, top: 20, bottom: 7),
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
                        if (pastDestinations.isNotEmpty)
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
                        if (pastDestinations.isNotEmpty)
                          SizedBox(
                            height: 150,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: pastDestinations,
                            ),
                          ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          const Text("You don't have any plans yet?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          const Text(
                            "What are you waiting for?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 50),
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                            ),
                            items: items,
                          ),
                          const SizedBox(height: 30),
                          DotsIndicator(
                            dotsCount: items.length,
                            position: currentIndex.toDouble(),
                            decorator: const DotsDecorator(
                                color: Color.fromARGB(70, 0, 0, 0),
                                activeColor: Color.fromARGB(255, 0, 206, 203),
                                spacing: EdgeInsets.all(4)),
                          ),
                          const SizedBox(height: 30),
                          IndexedStack(
                            index: currentIndex,
                            alignment: AlignmentDirectional.center,
                            children: mainTexts,
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Upload your files and keep them save",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 50),
                          Center(
                            child: IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NewTripPlanScreen())),
                              icon: const Icon(Icons.add_circle),
                              color: Colors.cyan,
                              iconSize: 75,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                })));
  }
}
