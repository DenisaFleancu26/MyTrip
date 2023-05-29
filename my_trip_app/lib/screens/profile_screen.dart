import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_trip_app/screens/change_password.dart';
import 'package:my_trip_app/screens/home_screen.dart';
import 'package:my_trip_app/screens/new_trip_plan.dart';

import '../services/auth.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentIndex = 2;
  int bottomTabIndex = 2;
  String userEmail = '';
  String userName = '';

  final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    userDetails();
  }

  Future<void> userDetails() async {
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: Auth().currentUser?.email)
        .get();

    setState(() {
      if (userQuerySnapshot.docs.isNotEmpty) {
        userEmail = userQuerySnapshot.docs[0].data()['email'];
        userName = userQuerySnapshot.docs[0].data()['name'] ?? '';
        if (userName.isEmpty) {
          final firstName = userQuerySnapshot.docs[0].data()['firstName'];
          final lastName = userQuerySnapshot.docs[0].data()['lastName'];

          userName = firstName + ' ' + lastName;
        }
      }
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

  Future<void> signOut() async {
    await Auth().signOut();
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 60),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 4.0,
                                color: Color.fromARGB(159, 66, 66, 66)),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Icon(Icons.account_circle, size: 150),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, top: 30),
                    child: Row(
                      children: [
                        const Text(
                          "Username",
                          style: TextStyle(
                            color: Color.fromARGB(255, 90, 90, 90),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            decoration: const BoxDecoration(borderRadius: null),
                            margin: const EdgeInsets.only(left: 10, right: 15),
                            child: Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 233, 231, 231),
                    height: 25,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Row(
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            color: Color.fromARGB(255, 90, 90, 90),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            decoration: const BoxDecoration(borderRadius: null),
                            margin: const EdgeInsets.only(left: 10, right: 15),
                            child: Text(
                              userEmail,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 233, 231, 231),
                    height: 25,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen()),
                      ),
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Change Password",
                              style: TextStyle(
                                color: Color.fromARGB(255, 90, 90, 90),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topRight,
                              decoration:
                                  const BoxDecoration(borderRadius: null),
                              margin: const EdgeInsets.only(right: 15),
                              child: const Icon(Icons.lock, color: Colors.cyan),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 233, 231, 231),
                    height: 25,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  GestureDetector(
                    onTap: () => {
                      signOut,
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen())),
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                color: Color.fromARGB(255, 90, 90, 90),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topRight,
                              decoration:
                                  const BoxDecoration(borderRadius: null),
                              margin: const EdgeInsets.only(right: 15),
                              child:
                                  const Icon(Icons.logout, color: Colors.cyan),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 233, 231, 231),
                    height: 25,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
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
