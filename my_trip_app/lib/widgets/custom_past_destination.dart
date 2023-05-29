import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomPastDestination extends StatelessWidget {
  const CustomPastDestination(
      {super.key,
      required this.destinations,
      required this.index,
      required this.onPress});

  final List<dynamic> destinations;
  final int index;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Padding(
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
                    destinations[index]['imageUrl'],
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: 110,
                  top: 10,
                  child: Text(
                    '${destinations[index]['name']} - ${destinations[index]['destination']}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  left: 110,
                  top: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          "Rating: ${destinations[index]['rating']}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      RatingBar.builder(
                        itemSize: 30,
                        initialRating:
                            double.parse(destinations[index]['rating']),
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {},
                        ignoreGestures: true,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
