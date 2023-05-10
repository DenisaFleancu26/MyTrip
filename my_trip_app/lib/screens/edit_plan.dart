import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_trip_app/screens/home_screen.dart';
import 'package:my_trip_app/screens/profile_screen.dart';
import 'package:my_trip_app/screens/new_trip_plan.dart';
import 'package:my_trip_app/widgets/custom_button.dart';

class EditPlanScreen extends StatefulWidget {
  const EditPlanScreen({Key? key}) : super(key: key);

  @override
  State<EditPlanScreen> createState() => _EditPlanScreenState();
}

class _EditPlanScreenState extends State<EditPlanScreen> {
  User user = FirebaseAuth.instance.currentUser!;

  String _bigPhoto = 'assets/images/dummy_datas/corfu1.jpg';
  final String _smallPhoto1 = 'assets/images/dummy_datas/corfu1.jpg';
  final String _smallPhoto2 = 'assets/images/dummy_datas/corfu2.jpg';
  final String _smallPhoto3 = 'assets/images/dummy_datas/corfu3.jpg';

  int bottomTabIndex = 0;
  int _selectedPhotoIndex = 1;
  int _buttonSelected = 1;
  bool _hotelVisible = true;
  bool _transportVisible = false;
  bool _notesVisible = false;
  String dropDownValue = 'Plane';

  TimeOfDay? timeIn = const TimeOfDay(hour: 12, minute: 12);
  TimeOfDay? timeOut = const TimeOfDay(hour: 12, minute: 12);
  TimeOfDay? timeDeparture = const TimeOfDay(hour: 12, minute: 12);
  TimeOfDay? timeReturn = const TimeOfDay(hour: 12, minute: 12);

  final TextEditingController _controllerHotel = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerContact = TextEditingController();

  final TextEditingController controllerNotes = TextEditingController(
      text: "Don't forget your passport and call the hotel before take-off.");

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2023),
    end: DateTime(2023),
  );

  void _toggleHotel() {
    setState(() {
      _hotelVisible = true;
      _transportVisible = false;
      _notesVisible = false;
    });
  }

  void _toggleTransport() {
    setState(() {
      _hotelVisible = false;
      _transportVisible = true;
      _notesVisible = false;
    });
  }

  void _toggleNotes() {
    setState(() {
      _hotelVisible = false;
      _transportVisible = false;
      _notesVisible = true;
    });
  }

  void _changeBigPhoto(String photo) async {
    setState(() {
      _bigPhoto = photo;
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

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    final List<Widget> destination = [
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(30)),
                image: DecorationImage(
                  image: AssetImage(_bigPhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 17,
            child: Container(
              transformAlignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(73, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 4))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: () => {},
                  child: const SizedBox(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            left: 25,
            child: Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(width: 10),
                Text(
                  "Corfu",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 60,
            left: 25,
            child: Text(
              "Corfu, Greece",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: Row(
              children: [
                CustomButton(
                  onTap: pickDateRange,
                  withGradient: true,
                  text: DateFormat('dd/MM/yyyy').format(start),
                  width: 100,
                  height: 30,
                  colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                  colorGradient2: const Color.fromARGB(245, 4, 116, 177),
                ),
                const Text(
                  "-",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomButton(
                  onTap: pickDateRange,
                  withGradient: true,
                  text: DateFormat('dd/MM/yyyy').format(end),
                  width: 100,
                  height: 30,
                  colorGradient1: const Color.fromARGB(255, 0, 206, 203),
                  colorGradient2: const Color.fromARGB(245, 4, 116, 177),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: Container(
              transformAlignment: Alignment.center,
              height: 150,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(73, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 4))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () => {
                        _changeBigPhoto(_smallPhoto1),
                        _selectedPhotoIndex = 1
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Transform.scale(
                          scale: _selectedPhotoIndex == 1 ? 1.5 : 1.0,
                          child: Image.asset(
                            _smallPhoto1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () => {
                        _changeBigPhoto(_smallPhoto2),
                        _selectedPhotoIndex = 2
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Transform.scale(
                          scale: _selectedPhotoIndex == 2 ? 1.5 : 1.0,
                          child: Image.asset(
                            _smallPhoto2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () => {
                        _changeBigPhoto(_smallPhoto3),
                        _selectedPhotoIndex = 3
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Transform.scale(
                          scale: _selectedPhotoIndex == 3 ? 1.5 : 1.0,
                          child: Image.asset(
                            _smallPhoto3,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];

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
              padding: const EdgeInsets.only(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 390,
                    child: ListView(
                      shrinkWrap: true,
                      children: destination,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RotatedBox(
                            quarterTurns: -1,
                            child: GestureDetector(
                              onTap: () => {
                                setState(() {
                                  _buttonSelected = 1;
                                  _toggleHotel();
                                }),
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _buttonSelected == 1
                                      ? const Color.fromARGB(255, 0, 206, 203)
                                      : Color.fromARGB(39, 71, 71, 71),
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(30)),
                                ),
                                height: 30,
                                width: 80,
                                child: const Center(
                                  child: Text(
                                    "Hotel",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          RotatedBox(
                            quarterTurns: -1,
                            child: GestureDetector(
                              onTap: () => {
                                setState(() {
                                  _buttonSelected = 2;
                                  _toggleTransport();
                                }),
                              },
                              child: Container(
                                height: 30,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: _buttonSelected == 2
                                      ? const Color.fromARGB(255, 0, 206, 203)
                                      : Color.fromARGB(39, 71, 71, 71),
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(30)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Transport",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          RotatedBox(
                            quarterTurns: -1,
                            child: GestureDetector(
                              onTap: () => {
                                setState(() {
                                  _buttonSelected = 3;
                                  _toggleNotes();
                                }),
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _buttonSelected == 3
                                      ? const Color.fromARGB(255, 0, 206, 203)
                                      : Color.fromARGB(39, 71, 71, 71),
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(30)),
                                ),
                                height: 30,
                                width: 80,
                                child: const Center(
                                  child: Text(
                                    "Notes",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_hotelVisible)
                        Container(
                          padding: const EdgeInsets.only(
                              left: 40, right: 15, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.hotel,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Hotel details",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  const Text(
                                    "Name:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                                spreadRadius: 0,
                                                blurRadius: 4,
                                                offset: const Offset(0, 4))
                                          ]),
                                      width: 202,
                                      child: _entryField('Pink hotel',
                                          _controllerHotel, false),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Address:",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            spreadRadius: 0,
                                            blurRadius: 4,
                                            offset: const Offset(0, 4))
                                      ]),
                                  width: 256,
                                  child: _entryField(
                                      '20 Bis Rue Dugommier, 75012 Corfu, Greece',
                                      _controllerAddress,
                                      false),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Contact:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                                spreadRadius: 0,
                                                blurRadius: 4,
                                                offset: const Offset(0, 4))
                                          ]),
                                      width: 190,
                                      child: _entryField('+33143434773',
                                          _controllerContact, false),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Check_In:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CustomButton(
                                    onTap: () async {
                                      TimeOfDay? newTimeIn =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: timeIn!,
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                primary: Color.fromARGB(
                                                    255, 0, 206, 203),
                                                onPrimary: Color.fromARGB(
                                                    255, 255, 255, 255),
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
                                    width: 60,
                                    height: 30,
                                    colorGradient1:
                                        const Color.fromARGB(255, 0, 206, 203),
                                    colorGradient2:
                                        const Color.fromARGB(245, 4, 116, 177),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Check_Out:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CustomButton(
                                    onTap: () async {
                                      TimeOfDay? newTimeOut =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: timeOut!,
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                primary: Color.fromARGB(
                                                    255, 0, 206, 203),
                                                onPrimary: Color.fromARGB(
                                                    255, 255, 255, 255),
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
                                    width: 60,
                                    height: 30,
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
                      if (_transportVisible)
                        Container(
                          padding: const EdgeInsets.only(left: 40, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.connecting_airports,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Transport details",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              Row(
                                children: [
                                  const Text(
                                    "Transport:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        DropdownButton(
                                          value: dropDownValue,
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.cyan,
                                          ),
                                          style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                          underline: Container(
                                            height: 2,
                                            color: Color.fromARGB(
                                                255, 0, 206, 203),
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
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "Departure to destination:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(),
                                    child: Row(
                                      children: [
                                        CustomButton(
                                          onTap: () async {
                                            TimeOfDay? newTimeDeparture =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: timeDeparture!,
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                      primary: Color.fromARGB(
                                                          255, 0, 206, 203),
                                                      onPrimary: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                            );
                                            if (newTimeDeparture != null) {
                                              setState(() {
                                                timeDeparture =
                                                    newTimeDeparture;
                                              });
                                            }
                                          },
                                          withGradient: true,
                                          text:
                                              '${timeDeparture!.hour.toString().padLeft(2, '0')}:${timeDeparture!.minute.toString().padLeft(2, '0')}',
                                          width: 60,
                                          height: 30,
                                          colorGradient1: const Color.fromARGB(
                                              255, 0, 206, 203),
                                          colorGradient2: const Color.fromARGB(
                                              245, 4, 116, 177),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Departure from destination:",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        CustomButton(
                                          onTap: () async {
                                            TimeOfDay? newTimeReturn =
                                                await showTimePicker(
                                              context: context,
                                              initialTime: timeReturn!,
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                      primary: Color.fromARGB(
                                                          255, 0, 206, 203),
                                                      onPrimary: Color.fromARGB(
                                                          255, 255, 255, 255),
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
                                          width: 60,
                                          height: 30,
                                          colorGradient1: const Color.fromARGB(
                                              255, 0, 206, 203),
                                          colorGradient2: const Color.fromARGB(
                                              245, 4, 116, 177),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (_notesVisible)
                        Container(
                          margin: const EdgeInsets.only(left: 40, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.description,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Notes",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            spreadRadius: 0,
                                            blurRadius: 4,
                                            offset: const Offset(0, 4))
                                      ]),
                                  width: 256,
                                  child: TextField(
                                    controller: controllerNotes,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 202, 202, 202)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 15,
                                          top: 15,
                                          bottom: 15,
                                          right: 15),
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
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
