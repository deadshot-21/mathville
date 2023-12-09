import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mathville/widgets/adventureAnalysisCard.dart';
import 'package:mathville/widgets/loader.dart';

import '../../constants.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  bool isLoading = true;
  var analyticsData = {};
  Future<void> getAnalytics() async {
    Dio dio = Dio();
    Response response =
        await dio.get('${baseUrl}analytics/getGeneralAnalytics/$uuid');
    print(response.data);
    if (response.data["status"]) {
      print(response.data["data"]);
    }
    analyticsData = response.data["data"];
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  String calculateSolved(x) {
    if (x["question_details"].length == 0) {
      return "0";
    } else {
      int solved = 0;
      for (var element in x["question_details"]) {
        if (element != null) {
          solved++;
        }
      }
      return solved.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnalytics();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? loader(context)
        : Scaffold(
            backgroundColor: kBackgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "${imagePath}profile_pic.png",
                                    width: 130,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RatingBar.builder(
                                    itemSize: 25,
                                    initialRating: 4.5,
                                    minRating: 3,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    unratedColor: kLightColor,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: kPrimaryColor,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  )
                                ],
                              ),
                              // Image.asset(
                              //   "${imagePath}line.png",
                              //   height: MediaQuery.of(context).size.height * 0.3,
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Solved: ",
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 20,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(analyticsData["solved"].toString(),
                                            style: TextStyle(
                                                color: kSecondaryColor,
                                                fontSize: 20,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Correct: ",
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 20,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            analyticsData["correct"].toString(),
                                            style: TextStyle(
                                                color: kSecondaryColor,
                                                fontSize: 20,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.11,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text("Adventure-wise Analysis",
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontSize: 22,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700)),
                        ),
                        for (var x in analyticsData["games_played"]) ...[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          adventureAnalysisCard(context, {
                            "title": x["name"],
                            "solved": calculateSolved(x),
                            "total": x["totalQuestions"],
                            "questionDetails": x["question_details"]
                          }),
                        ],
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width / 2 - 10,
                      height: MediaQuery.of(context).size.height * 0.33,
                      child: Image.asset("${imagePath}line.png"),
                    )
                  ],
                ),
              ),
            ));
  }
}
