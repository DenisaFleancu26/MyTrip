import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.withGradient,
    required this.text,
    this.colorGradient1,
    this.colorGradient2,
  });

  final void Function() onTap;
  final bool withGradient;
  final Color? colorGradient1;
  final Color? colorGradient2;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: withGradient
                ? LinearGradient(
                    colors: [
                      colorGradient1!,
                      colorGradient2!,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: !withGradient ? Colors.white : null,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4))
            ]),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: withGradient ? Colors.white : Colors.black),
        )),
      ),
    );
  }
}
