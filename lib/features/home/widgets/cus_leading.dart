import 'package:flutter/material.dart';

class CustomLeading extends StatelessWidget {
  final String image;
  final bool networkImage;
  final Color? col;
  const CustomLeading(
      {super.key,
      required this.image,
      this.col = Colors.white,
      this.networkImage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: col,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFEDEDFF),
          )),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: networkImage
            ? Image.network(image)
            : Image.asset(
                image,
              ),
      ),
    );
  }
}
