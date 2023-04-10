import 'package:flutter/material.dart';
import 'package:my_trip_app/screens/forgot_password_screen.dart';
import 'package:my_trip_app/screens/home_screen.dart';
import 'package:my_trip_app/screens/signup_screen.dart';
import 'package:my_trip_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth()
          .signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      )
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _errorMessage() {
    return Center(
        child: Text(
            errorMessage == ''
                ? ''
                : "The mail or password you entered is wrong!",
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
        backgroundColor: Color.fromARGB(255, 200, 239, 243),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/back.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () => Auth().signInWithGoogle().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
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
                  const SizedBox(height: 30),
                  const Center(
                    child: Text("Or log in using",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 13,
                        )),
                  ),
                  const SizedBox(height: 20),
                  _errorMessage(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordScreen())),
                    child: Container(
                      height: 30,
                      width: 140,
                      margin: const EdgeInsets.only(left: 200),
                      decoration: const BoxDecoration(borderRadius: null),
                      child: const Center(
                          child: Text(
                        "Forgot your password?",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 0, 206, 203)),
                      )),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    onTap: signInWithEmailAndPassword,
                    withGradient: true,
                    text: "Log in",
                    colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                    colorGradient2: const Color.fromARGB(245, 4, 116, 177),
                  ),
                  const SizedBox(height: 90),
                  Container(
                    margin: const EdgeInsets.only(left: 70),
                    child: Row(
                      children: [
                        const Text(
                          "Don't have an account yet?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
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
                                  color: Color.fromARGB(255, 0, 206, 203)),
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
        ],
      ),
    );
  }
}
