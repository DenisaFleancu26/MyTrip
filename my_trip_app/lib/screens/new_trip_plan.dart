import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_trip_app/screens/home_screen.dart';

import '../auth.dart';
import '../widgets/custom_button.dart';

class NewTripPlanScreen extends StatefulWidget {
  const NewTripPlanScreen({super.key});

  @override
  State<NewTripPlanScreen> createState() => _NewTripPlanScreenState();
}

class _NewTripPlanScreenState extends State<NewTripPlanScreen> {
  final User? user = Auth().currentUser;
  int currentIndex = 1;
  int bottomTabIndex = 1;

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2023),
    end: DateTime(2023),
  );

  String dropDownValue = 'Plane';

  final TextEditingController _controllerDestination = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerHotel = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerContact = TextEditingController();

  Widget _entryField(
      String title, TextEditingController controller, bool hasObscureText) {
    return TextField(
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
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 0, 206, 203),
              onPrimary: Color.fromARGB(255, 255, 255, 255),
              onSurface: Color.fromARGB(245, 4, 116, 177),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 40),
                  child: Text(
                    "Planner Trip",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 40),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: const [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 10),
                                Text(
                                  "Trip start date",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            onTap: pickDateRange,
                            withGradient: true,
                            text: DateFormat('dd/MM/yyyy').format(start),
                            width: 150,
                            colorGradient1:
                                const Color.fromARGB(255, 0, 206, 203),
                            colorGradient2:
                                const Color.fromARGB(245, 4, 116, 177),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: const [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 10),
                                Text(
                                  "Trip end date",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            onTap: pickDateRange,
                            withGradient: true,
                            text: DateFormat('dd/MM/yyyy').format(end),
                            width: 150,
                            colorGradient1:
                                const Color.fromARGB(255, 0, 206, 203),
                            colorGradient2:
                                const Color.fromARGB(245, 4, 116, 177),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    child: _entryField('Trip Name', _controllerName, false),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    child: _entryField(
                        'Destination', _controllerDestination, false),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.only(left: 35),
                  child: Row(
                    children: const [
                      Icon(Icons.hotel),
                      SizedBox(width: 10),
                      Text(
                        "Hotel details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    child: _entryField('Hotel', _controllerHotel, false),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    child: _entryField('Address', _controllerAddress, false),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    child: _entryField(
                        'Phone or Email', _controllerContact, false),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: const [
                                Icon(Icons.event_available),
                                SizedBox(width: 10),
                                Text(
                                  "Check-In",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            onTap: () => {},
                            withGradient: true,
                            text: '',
                            width: 150,
                            colorGradient1:
                                const Color.fromARGB(255, 0, 206, 203),
                            colorGradient2:
                                const Color.fromARGB(245, 4, 116, 177),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: const [
                                Icon(Icons.event_busy),
                                SizedBox(width: 10),
                                Text(
                                  "Check-Out",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            onTap: () => {},
                            withGradient: true,
                            text: '',
                            width: 150,
                            colorGradient1:
                                const Color.fromARGB(255, 0, 206, 203),
                            colorGradient2:
                                const Color.fromARGB(245, 4, 116, 177),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.only(left: 35),
                  child: Row(
                    children: const [
                      Icon(Icons.flight),
                      SizedBox(width: 10),
                      Text(
                        "Transport details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.only(left: 35),
                  child: Row(
                    children: [
                      const Text(
                        "Choose transport:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 40),
                      DropdownButton(
                        value: dropDownValue,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.cyan,
                        ),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        underline: Container(
                          height: 2,
                          color: Color.fromARGB(255, 0, 206, 203),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                          });
                        },
                        items: const [
                          DropdownMenuItem<String>(
                            value: "Plane",
                            child: Text(
                              "Plane",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                              value: "Car",
                              child: Text(
                                "Car",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          DropdownMenuItem<String>(
                              value: "Train",
                              child: Text(
                                "Train",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 35),
                  child: Row(
                    children: [
                      const Icon(Icons.flight_takeoff),
                      const SizedBox(width: 10),
                      const Text(
                        "Departure to destination",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomButton(
                        onTap: () => {},
                        withGradient: true,
                        text: '',
                        width: 100,
                        colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                        colorGradient2: const Color.fromARGB(245, 4, 116, 177),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 35),
                  child: Row(
                    children: [
                      const Icon(Icons.flight_land),
                      const SizedBox(width: 10),
                      const Text(
                        "Departure from destination",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomButton(
                        onTap: () => {},
                        withGradient: true,
                        text: '',
                        width: 100,
                        colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                        colorGradient2: const Color.fromARGB(245, 4, 116, 177),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  onTap: () => {},
                  withGradient: true,
                  text: "Save Plan",
                  colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                  colorGradient2: const Color.fromARGB(245, 4, 116, 177),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
