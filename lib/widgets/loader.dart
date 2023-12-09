import 'package:flutter/material.dart';
import 'package:mathville/constants.dart';

Widget loader(context) {
  return Scaffold(
    backgroundColor: kBackgroundColor,
    body: Center(
      child: Transform.scale(
        scale: 1.0,
        child: CircularProgressIndicator(
          color: kPrimaryColor,
          strokeWidth: 2,
        ),
      ),
    ),
  );
}
