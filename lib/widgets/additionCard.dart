import 'package:flutter/material.dart';
import 'package:mathville/constants.dart';

Widget additionCard() {
  return Row(
    children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: kLightColor,
          borderRadius: BorderRadius.circular(kRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              // hintText: "0",
              // hintStyle: TextStyle(
              //     color: kPrimaryColor,
              //     fontSize: 18,
              //     fontFamily: 'Inter',
              //     fontWeight: FontWeight.w500),
            ),
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      const SizedBox(width: 20),
      Image.asset("${imagePath}plus_light.png", width: 40, height: 40),
      const SizedBox(width: 20),
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: kLightColor,
          borderRadius: BorderRadius.circular(kRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              // hintText: "0",
              // hintStyle: TextStyle(
              //     color: kPrimaryColor,
              //     fontSize: 18,
              //     fontFamily: 'Inter',
              //     fontWeight: FontWeight.w500),
            ),
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      const SizedBox(width: 20),
      Image.asset("${imagePath}equal_light.png", width: 40, height: 40),
      const SizedBox(width: 20),
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: kLightColor,
          borderRadius: BorderRadius.circular(kRadius),
        ),
        child: Center(
            child: Text("40",
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500))),
      ),
    ],
  );
}
