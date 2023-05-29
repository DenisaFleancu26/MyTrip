import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_trip_app/screens/home_screen.dart';
import 'package:my_trip_app/screens/new_trip_plan.dart';
import 'package:my_trip_app/screens/profile_screen.dart';
import 'package:my_trip_app/widgets/custom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String? errorMessage = '';
  bool isLogin = true;
  bool _obscureTextCurrent = true;
  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;
  int currentIndex = 2;
  int bottomTabIndex = 2;

  User user = FirebaseAuth.instance.currentUser!;

  final TextEditingController _controllerCurrent = TextEditingController();
  final TextEditingController _controllerNew = TextEditingController();
  final TextEditingController _controllerConfirm = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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

  Future<void> changePassword() async {
    if (_controllerCurrent.text.isEmpty) {
      setState(() {
        errorMessage = "Please enter your current password";
      });
      return;
    }
    if (_controllerNew.text.isEmpty || _controllerConfirm.text.isEmpty) {
      setState(() {
        errorMessage = "Please enter your new password";
      });
      return;
    }
    if (_controllerNew.text != _controllerConfirm.text) {
      setState(() {
        errorMessage = "The passwords you entered do not match!";
      });
      return;
    }

    try {
      AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!, password: _controllerCurrent.text);
      await user.reauthenticateWithCredential(credential).then((value) {
        user.updatePassword(_controllerNew.text);

        setState(() {
          errorMessage = "Success! Your password has been changed!";
          _controllerCurrent.clear();
          _controllerNew.clear();
          _controllerConfirm.clear();
        });
      });
    } catch (e) {
      if (e is FirebaseAuthException) {
        setState(() {
          if (e.code == 'wrong-password') {
            errorMessage = 'Your current password is wrong!';
          } else {
            errorMessage = "Invalid data!";
          }
        });
      }
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

  Widget _entryField(String title, TextEditingController controller,
      bool hasObscureText, bool obscureText, int nrfield) {
    return TextField(
      obscureText: hasObscureText ? obscureText : false,
      controller: controller,
      decoration: InputDecoration(
        hintText: title,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 2, color: Color.fromARGB(255, 202, 202, 202)),
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
        suffixIcon: Visibility(
          visible: hasObscureText,
          child: GestureDetector(
            onTap: () {
              setState(() {
                switch (nrfield) {
                  case 1:
                    _obscureTextCurrent = !_obscureTextCurrent;
                    obscureText = _obscureTextCurrent;
                    break;
                  case 2:
                    _obscureTextNew = !_obscureTextNew;
                    obscureText = _obscureTextNew;
                    break;
                  case 3:
                    _obscureTextConfirm = !_obscureTextConfirm;
                    obscureText = _obscureTextConfirm;
                    break;
                }
              });
            },
            child: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
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
              padding: const EdgeInsets.only(left: 30, top: 60, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    "Please enter your new password!",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
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
                    child: _entryField('Current Password', _controllerCurrent,
                        true, _obscureTextCurrent, 1),
                  ),
                  const SizedBox(height: 20),
                  Container(
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
                    child: _entryField('New Password', _controllerNew, true,
                        _obscureTextNew, 2),
                  ),
                  const SizedBox(height: 20),
                  Container(
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
                    child: _entryField('Confirm New Password',
                        _controllerConfirm, true, _obscureTextConfirm, 3),
                  ),
                  const SizedBox(height: 25),
                  _errorMessage(),
                  const SizedBox(height: 25),
                  Center(
                    child: CustomButton(
                      onTap: () => {changePassword()},
                      withGradient: true,
                      text: "Update Password",
                      colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                      colorGradient2: const Color.fromARGB(245, 4, 116, 177),
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
