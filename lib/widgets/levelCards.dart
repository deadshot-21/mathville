import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mathville/constants.dart';
import 'package:mathville/main/home/levels.dart';

import '../main/home/timer.dart';

Widget levelCard(
    context, var details, void Function() callback, String questionSetUuid, String title) {
  EdgeInsets padding;
  double width = 20;

  Future<void> updateSolvedQuestion(selected) async {
    Dio dio = Dio();
    Response response = await dio.post(
      '${baseUrl}home/updateQuestionSolved',
      options:
          Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
      data: {
        "userUuid": uuid,
        "questionSetUuid": questionSetUuid,
        "questionIndex": details["level"] - 1,
        "answerChosen":selected,
      },
    );
    if (response.data["status"]) {
      Response response =
          await dio.get('${baseUrl}home/getAllQuestionSetsForUser/$uuid');
      if (response.data["status"]) {
        // print(response.data["data"]);
        questionSets = response.data["data"]["questionSets"];
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Levels(
                      questionSetUuid: questionSetUuid,
                      title: title,
                    )));
      }
    }
  }

  if (details["level"] < 10) {
    padding = const EdgeInsets.symmetric(horizontal: 12.0);
  } else {
    width = 5;
    padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3);
  }
  return GestureDetector(
    onTap: () async {
      print(details);
      var selected = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TimerScreen(
                    details: details,
                  )));
      if (selected != null) {
        callback();
        updateSolvedQuestion(selected);
      }
    },
    child: Container(
      // height: 80 * 1.2,
      // width: 120 * 1.39,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: (details["isSolved"].contains(uuid))
                ? kGreenColor
                : kPrimaryColor,
            width: 2),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text("Level",
                  style: TextStyle(
                    fontSize: 18,
                    color: (details["isSolved"].contains(uuid))
                        ? kGreenColor
                        : kPrimaryColor,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  )),
            ),
            SizedBox(
              width: width,
            ),
            Text(details["level"].toString(),
                style: TextStyle(
                  fontSize: 64,
                  color: (details["isSolved"].contains(uuid))
                      ? kSecondaryColor
                      : kPrimaryColor,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    ),
  );
}

Widget emptyCard() {
  return Container(
    height: 80,
    width: 120,
    decoration: BoxDecoration(
      color: kBackgroundColor,
    ),
  );
}
