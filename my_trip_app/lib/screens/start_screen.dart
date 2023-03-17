import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_trip_app/screens/login_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final List<Widget> items = [
    Image.asset('assets/images/passport.png'),
    Image.asset('assets/images/travel-itinerary.png'),
    Image.asset('assets/images/image.png'),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 75, bottom: 30, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 115),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen())),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 206, 203),
                        Color.fromARGB(245, 4, 116, 177),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4))
                    ]),
                child: const Center(
                    child: Text(
                  "Log in",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                )),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
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
                child: const Center(
                    child: Text(
                  "Create account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
