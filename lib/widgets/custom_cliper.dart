import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {
  final double left;

  CustomShape({super.reclip, required this.left});
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * left);
    path.cubicTo(0, size.height * left, size.width / 2, size.height, size.width,
        size.height * 0.7);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
