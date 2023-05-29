import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_trip_app/screens/login_screen.dart';
import 'package:my_trip_app/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  Future resetPassword() async {
    if (_controllerEmail.text.isEmpty) {
      setState(() {
        errorMessage = "Please enter your Email!";
      });
      return;
    }
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _controllerEmail.text.trim())
          .then((value) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message.toString();
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
      decoration: InputDecoration(
        hintText: title,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.5, color: Colors.cyan),
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
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Center(
                    child: Text(
                        "Please enter your Email and we will send you a password reset link!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        )),
                  ),
                  const SizedBox(height: 30),
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
                  const SizedBox(height: 20),
                  _errorMessage(),
                  const SizedBox(height: 30),
                  CustomButton(
                    onTap: resetPassword,
                    withGradient: true,
                    text: "Send Request",
                    colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                    colorGradient2: const Color.fromARGB(245, 4, 116, 177),
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
