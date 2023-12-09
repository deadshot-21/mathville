import 'package:flutter/material.dart';
import 'package:mathville/main/analytics/adventureAnalytics.dart';

import '../constants.dart';

Widget adventureAnalysisCard(context, data) {

  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdventureAnalysis(
                data: data,
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
                width: MediaQuery.of(context).size.width * 0.35,
                child: Text(data['title'],
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500))),
            Row(
              children: [
                Text(data['solved'],
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: kPrimaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w500)),
                Text("/",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: kSecondaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w500)),
                Text(data['total'].toString(),
                    style: TextStyle(
                        fontFamily: 'Inter',
                        color: kPrimaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w500)),
              ],
            )
          ]),
        ),
      ),
    ),
  );
}
