import 'package:flutter/material.dart';
import 'package:my_trip_app/models/next_destination.dart';

class CustomPastDestination extends StatelessWidget {
  const CustomPastDestination({super.key, required this.pastDestination});

  final PastDestination pastDestination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4))
              ]),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Image.network(
                  pastDestination.image,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: 115,
                top: 10,
                child: Text(
                  '${pastDestination.destinationName} - ${pastDestination.countryName}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Positioned(
                left: 115,
                top: 30,
                child: Text(
                  "Feedback",
                  maxLines: null,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              Positioned(
                left: 115,
                top: 50,
                child: Text(
                  pastDestination.feedback,
                  maxLines: null,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
