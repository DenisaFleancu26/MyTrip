import 'package:flutter/material.dart';
import 'package:my_trip_app/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_trip_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final User? user = Auth().currentUser;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _userUid(),
          _signOutButton(context),
        ],
      ),
    );
  }
}
