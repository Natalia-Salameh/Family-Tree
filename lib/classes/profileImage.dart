import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String name;
  final double radius;
  final double fontsize;
  final ImageProvider? imageFile;

  ProfileImage({
    required this.name,
    required this.radius,
    required this.fontsize,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageFile,
      child: imageFile == null
          ? Text(
              name.isNotEmpty ? name[0] : '',
              style: TextStyle(fontSize: fontsize),
            )
          : null,
    );
  }
}
