import 'package:flutter/material.dart';
import 'package:mathville/constants.dart';
import 'package:mathville/main/home/levels.dart';

Widget adventureCard(context, data) {
  return GestureDetector(
    onTap: () {
      print(data["uuid"]);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Levels(
                    questionSetUuid: data["uuid"],
                    title: data["title"],
                  )));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(kRadius),
            border: Border.all(color: kPrimaryColor, width: 2)),
        height: MediaQuery.of(context).size.height * 0.10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: Text(data['title'],
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500))),
            Image.asset("$imagePath${data["difficulty"]}.png",
                width: 40, height: 40)
          ]),
        ),
      ),
    ),
  );
}
