import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_trip_app/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_trip_app/screens/login_screen.dart';
import 'package:my_trip_app/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = Auth().currentUser;
  int currentIndex = 0;
  int bottomTabIndex = 0;

  final List<Widget> items = [
    Image.asset(
      'assets/images/dummy_datas/corfu1.jpg',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ),
    Image.asset(
      'assets/images/dummy_datas/corfu2.jpg',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ),
    Image.asset(
      'assets/images/dummy_datas/corfu3.jpg',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ),
  ];
  final List<Widget> popularDestinations = [
    Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/dummy_datas/japan.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 25,
          left: 25,
          child: Text(
            "Japan",
            style: TextStyle(
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/dummy_datas/portugal.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 25,
          left: 25,
          child: Text(
            "Portugal",
            style: TextStyle(
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/dummy_datas/italy.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 25,
          left: 25,
          child: Text(
            "Italy",
            style: TextStyle(
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/dummy_datas/australia.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 25,
          left: 25,
          child: Text(
            "Australia",
            style: TextStyle(
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/dummy_datas/norvegia.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 25,
          left: 25,
          child: Text(
            "Norvegia",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    ),
  ];
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

  Future<void> signOut() async {
    await Auth().signOut();
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
            icon: Icon(Icons.notifications_none_outlined),
            label: 'Notification',
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // _userUid(),
                // _signOutButton(context),

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
                    onTap: () {},
                    withGradient: false,
                    text: "View details",
                    color: Colors.cyan,
                    width: 125,
                    textColor: Colors.white,
                  ),
                ),
                const Positioned(
                  bottom: 135,
                  left: 55,
                  child: Text(
                    "Corfu",
                    style: TextStyle(
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
                const Positioned(
                  bottom: 95,
                  left: 55,
                  child: Text(
                    "Europe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 80,
                  left: 55,
                  child: Text(
                    "Greece",
                    style: TextStyle(
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
                "Popular Destinations",
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
                "Best Deals",
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
        ),
      ),
    );
  }
}
