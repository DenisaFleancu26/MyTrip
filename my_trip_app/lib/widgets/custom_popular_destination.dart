import 'package:flutter/material.dart';

class CustomPopularDestination extends StatelessWidget {
  const CustomPopularDestination(
      {super.key,
      required this.destinations,
      required this.index,
      required this.onPress});

  final List<dynamic> destinations;
  final int index;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => onPress(),
            child: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(destinations[index]['imageUrl4']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          left: 25,
          child: Text(
            destinations[index]['destination'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
