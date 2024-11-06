// ignore: file_names
import 'package:flutter/material.dart';

class RoundedImageWithShadow extends StatelessWidget {
  final String imagePath;

  const RoundedImageWithShadow({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Image.asset(
          imagePath,
          width: 10,
          height: 250,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
