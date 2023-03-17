import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // trb sa ii schimbi culoarea (Colors.transparent)
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // in lista asta iti pui tu toate elementele
              // o sa ai nevoie de:
              // 1x GestureDetector cu child Container (asta e Google)
              // nu facem si Facebook
              // 1x Text
              // 2x TextInputField pt mail si pass
              // 1x Gesture Detector cu child Text pt "forgot password"
              // buton ai pe celelalte ecrane
              Text("Acesta va fi un Login page!")
            ],
          )),
    );
  }
}
