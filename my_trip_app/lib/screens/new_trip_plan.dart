import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_trip_app/screens/home_screen.dart';
import 'package:my_trip_app/screens/profile_screen.dart';
import 'package:my_trip_app/trip.dart';
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
  String? errorMessage = '';

  TimeOfDay? timeIn = const TimeOfDay(hour: 12, minute: 12);
  TimeOfDay? timeOut = const TimeOfDay(hour: 12, minute: 12);
  TimeOfDay? timeDeparture = const TimeOfDay(hour: 12, minute: 12);
  TimeOfDay? timeReturn = const TimeOfDay(hour: 12, minute: 12);

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

  Widget _errorMessage() {
    return Center(
        child: Text(errorMessage == '' ? '' : "$errorMessage",
            style: const TextStyle(
              color: Color.fromARGB(255, 199, 6, 6),
              fontSize: 15,
            )));
  }

  Future<void> addPlan() async {
    if (_controllerName.text.isEmpty) {
      setState(() {
        errorMessage = "Please enter your Trip Name";
      });
      return;
    }
    if (_controllerDestination.text.isEmpty) {
      setState(() {
        errorMessage = "Please enter your destination";
      });
      return;
    }
    if (_controllerHotel.text.isEmpty) {
      setState(() {
        errorMessage = "Please enter the name of the hotel";
      });
      return;
    }
    if (_controllerAddress.text.isEmpty) {
      setState(() {
        errorMessage = "Please enter the hotel address";
      });
      return;
    }
    if (_controllerContact.text.isEmpty) {
      setState(() {
        errorMessage = "Please enter hotel contact details";
      });
      return;
    }
    DateTime startDate = dateRange.start;
    DateTime endDate = dateRange.end;

    Trip trip = Trip();

    await trip.addPlanTrip(
        DateFormat('dd/MM/yyyy').format(startDate),
        DateFormat('dd/MM/yyyy').format(endDate),
        _controllerName.text,
        _controllerDestination.text,
        _controllerHotel.text,
        _controllerAddress.text,
        _controllerContact.text,
        '${timeIn!.hour.toString().padLeft(2, '0')}:${timeIn!.minute.toString().padLeft(2, '0')}',
        '${timeOut!.hour.toString().padLeft(2, '0')}:${timeOut!.minute.toString().padLeft(2, '0')}',
        dropDownValue,
        '${timeDeparture!.hour.toString().padLeft(2, '0')}:${timeDeparture!.minute.toString().padLeft(2, '0')}',
        '${timeReturn!.hour.toString().padLeft(2, '0')}:${timeReturn!.minute.toString().padLeft(2, '0')}');
    setState(() {
      _controllerName.clear();
      _controllerDestination.clear();
      _controllerHotel.clear();
      _controllerAddress.clear();
      _controllerContact.clear();
      dateRange = DateTimeRange(
        start: DateTime(2023),
        end: DateTime(2023),
      );
      timeIn = TimeOfDay.now();
      timeOut = TimeOfDay.now();
      timeDeparture = TimeOfDay.now();
      timeReturn = TimeOfDay.now();
      errorMessage = 'Plan Trip added successfully!';
    });
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
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
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
                const SizedBox(height: 10),
                _errorMessage(),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            width: 135,
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
                            width: 135,
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
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            onTap: () async {
                              TimeOfDay? newTimeIn = await showTimePicker(
                                context: context,
                                initialTime: timeIn!,
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary:
                                            Color.fromARGB(255, 0, 206, 203),
                                        onPrimary:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (newTimeIn != null) {
                                setState(() {
                                  timeIn = newTimeIn;
                                });
                              }
                            },
                            withGradient: true,
                            text:
                                '${timeIn!.hour.toString().padLeft(2, '0')}:${timeIn!.minute.toString().padLeft(2, '0')}',
                            width: 135,
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
                            onTap: () async {
                              TimeOfDay? newTimeOut = await showTimePicker(
                                context: context,
                                initialTime: timeOut!,
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary:
                                            Color.fromARGB(255, 0, 206, 203),
                                        onPrimary:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (newTimeOut != null) {
                                setState(() {
                                  timeOut = newTimeOut;
                                });
                              }
                            },
                            withGradient: true,
                            text:
                                '${timeOut!.hour.toString().padLeft(2, '0')}:${timeOut!.minute.toString().padLeft(2, '0')}',
                            width: 135,
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
                  margin: const EdgeInsets.only(left: 65),
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
                  margin: const EdgeInsets.only(left: 30),
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
                      CustomButton(
                        onTap: () async {
                          TimeOfDay? newTimeDeparture = await showTimePicker(
                            context: context,
                            initialTime: timeDeparture!,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromARGB(255, 0, 206, 203),
                                    onPrimary:
                                        Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (newTimeDeparture != null) {
                            setState(() {
                              timeDeparture = newTimeDeparture;
                            });
                          }
                        },
                        withGradient: true,
                        text:
                            '${timeDeparture!.hour.toString().padLeft(2, '0')}:${timeDeparture!.minute.toString().padLeft(2, '0')}',
                        width: 80,
                        colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                        colorGradient2: const Color.fromARGB(245, 4, 116, 177),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
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
                      CustomButton(
                        onTap: () async {
                          TimeOfDay? newTimeReturn = await showTimePicker(
                            context: context,
                            initialTime: timeReturn!,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color.fromARGB(255, 0, 206, 203),
                                    onPrimary:
                                        Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (newTimeReturn != null) {
                            setState(() {
                              timeReturn = newTimeReturn;
                            });
                          }
                        },
                        withGradient: true,
                        text:
                            '${timeReturn!.hour.toString().padLeft(2, '0')}:${timeReturn!.minute.toString().padLeft(2, '0')}',
                        width: 80,
                        colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                        colorGradient2: const Color.fromARGB(245, 4, 116, 177),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(left: 35),
                  child: Row(
                    children: const [
                      Icon(Icons.description),
                      SizedBox(width: 10),
                      Text(
                        "Notes",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
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
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Notes..",
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 202, 202, 202)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 30, top: 15, bottom: 15),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  onTap: addPlan,
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
