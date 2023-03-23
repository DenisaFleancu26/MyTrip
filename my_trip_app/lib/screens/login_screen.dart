import 'package:flutter/material.dart';
import 'package:my_trip_app/screens/forgotPassword_screen.dart';
import 'package:my_trip_app/screens/google_screen.dart';
import 'package:my_trip_app/screens/home_screen.dart';
import 'package:my_trip_app/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  get tEmail => "Email";
  get tPassword => "Password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "  Log in",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GoogleScreen())),
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
                    children: [
                      const SizedBox(width: 30),
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
              const SizedBox(height: 30),
              const Center(
                child: Text("Or log in using",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    )),
              ),
              const SizedBox(height: 40),
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
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: tEmail,
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 202, 202, 202)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 30, top: 15, bottom: 15),
                    ),
                  ),
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
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: tPassword,
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 202, 202, 202)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 30, top: 15, bottom: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  )),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen())),
                child: Container(
                  height: 50,
                  width: 340,
                  margin: const EdgeInsets.only(left: 10),
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
              const SizedBox(height: 90),
              Container(
                margin: const EdgeInsets.only(left: 70),
                child: Row(
                  children: [
                    const Text(
                      "Don't have an account yet?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen())),
                      child: Container(
                        height: 30,
                        width: 50,
                        //margin: const EdgeInsets.only(left: 100),
                        decoration: const BoxDecoration(borderRadius: null),
                        child: const Center(
                            child: Text(
                          "Sign up",
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
