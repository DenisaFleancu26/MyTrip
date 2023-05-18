import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_trip_app/models/next_destination.dart';

import 'custom_button.dart';

class CustomNextDestination extends StatefulWidget {
  const CustomNextDestination({super.key, required this.nextDestination});

  final NextDestination nextDestination;

  @override
  State<CustomNextDestination> createState() => _CustomNextDestinationState();
}

class _CustomNextDestinationState extends State<CustomNextDestination> {
  List<Widget> items = [];
  int currentIndex = 0;

  Widget _imageNetwork(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  @override
  void initState() {
    super.initState();

    items = [
      _imageNetwork(widget.nextDestination.images[0]),
      _imageNetwork(widget.nextDestination.images[1]),
      _imageNetwork(widget.nextDestination.images[2]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              aspectRatio: 1,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: items,
          ),
        ),
        Positioned(
          bottom: 30,
          right: 50,
          child: DotsIndicator(
            dotsCount: items.length,
            position: currentIndex.toDouble(),
            decorator: const DotsDecorator(
                color: Color.fromARGB(255, 199, 199, 199),
                activeColor: Colors.cyan,
                spacing: EdgeInsets.all(4)),
          ),
        ),
        Positioned(
          bottom: 7,
          left: 35,
          child: CustomButton(
            onTap: () {},
            withGradient: false,
            text: "View details",
            color: Colors.cyan,
            width: 125,
            textColor: Colors.white,
          ),
        ),
        Positioned(
          bottom: 135,
          left: 55,
          child: Text(
            widget.nextDestination.destinationName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Positioned(
          bottom: 120,
          left: 55,
          child: Text(
            "___",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Positioned(
          bottom: 95,
          left: 55,
          child: Text(
            widget.nextDestination.countryName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
