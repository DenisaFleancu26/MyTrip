import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_trip_app/screens/forgot_password_screen.dart';
import 'package:my_trip_app/screens/home_screen.dart';
import 'package:my_trip_app/screens/login_screen.dart';
import 'package:my_trip_app/widgets/custom_button.dart';

import '../auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signUpUser() async {
    if (_controllerFirstName.text.isEmpty) {
      setState(() {
        errorMessage = "Please enter your First Name";
      });
      return;
    }
    if (_controllerLastName.text.isEmpty) {
      setState(() {
        errorMessage = "Please enter your Last Name";
      });
      return;
    }

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      )
          .then((value) {
        FirebaseFirestore.instance.collection('Users').add({
          'email': _controllerEmail.text,
          'firstName': _controllerFirstName.text,
          'lastName': _controllerLastName.text
        });

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case "weak-password":
            errorMessage = "The password must be 6 characters long or more!";
            break;
          case "email-already-in-use":
            errorMessage = "The email address is already in use!";
            break;
          case "invalid-email":
            errorMessage = "The email is invalid!";
            break;
          case "wrong-password":
            errorMessage = "The password is invalid!";
            break;
          case "unknown":
            errorMessage = "Invalid data!";
            break;
          default:
            errorMessage = e.code;
        }
      });
    }
  }

  Widget _errorMessage() {
    return Center(
        child: Text(errorMessage == '' ? '' : "$errorMessage",
            style: const TextStyle(
              color: Color.fromARGB(255, 199, 6, 6),
              fontSize: 15,
            )));
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      obscureText: title == 'Password' ? true : false,
      decoration: InputDecoration(
        hintText: title,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 2, color: Color.fromARGB(255, 202, 202, 202)),
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Auth().signInWithGoogle().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
                child: Container(
                  height: 45,
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 100),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/google.png', width: 30),
                      const SizedBox(width: 10),
                      const Text(
                        "Google",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text("Or sign up using",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    )),
              ),
              const SizedBox(height: 20),
              _errorMessage(),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
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
                  child: _entryField('First Name', _controllerFirstName),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
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
                  child: _entryField('Last Name', _controllerLastName),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
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
                  child: _entryField('Email', _controllerEmail),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
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
                  child: _entryField('Password', _controllerPassword),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen())),
                child: Container(
                  height: 30,
                  width: 140,
                  margin: const EdgeInsets.only(left: 200),
                  decoration: const BoxDecoration(borderRadius: null),
                  child: const Center(
                      child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                        fontSize: 13, color: Color.fromARGB(255, 0, 165, 231)),
                  )),
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                onTap: signUpUser,
                withGradient: true,
                text: "Sign up",
                colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                colorGradient2: const Color.fromARGB(245, 4, 116, 177),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.only(left: 70),
                child: Row(
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen())),
                      child: Container(
                        height: 30,
                        width: 50,
                        decoration: const BoxDecoration(borderRadius: null),
                        child: const Center(
                            child: Text(
                          "Log in",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 165, 231)),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
