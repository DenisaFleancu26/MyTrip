import 'package:flutter/material.dart';
import 'package:my_trip_app/screens/start_screen.dart';
import 'package:my_trip_app/widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/landing.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/jet.png',
                  width: 100,
                ),
                const Text(
                  "MyTrip",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
                const SizedBox(height: 125),
                const Text(
                  "Welcome to YourTrip!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                const Text(
                  "An easy way to store all your memories",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 175),
                CustomButton(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StartScreen())),
                  withGradient: true,
                  text: "Let's start",
                  colorGradient1: const Color.fromARGB(245, 4, 116, 177),
                  colorGradient2: const Color.fromARGB(219, 5, 84, 127),
                )
              ]),
        ),
      ),
    );
  }
}
