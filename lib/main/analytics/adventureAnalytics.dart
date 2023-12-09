import 'package:flutter/material.dart';
import 'package:mathville/constants.dart';
import 'package:mathville/widgets/questionAnalysisCard.dart';

class AdventureAnalysis extends StatefulWidget {
  const AdventureAnalysis({super.key, required this.data});
  final Map data;
  @override
  State<AdventureAnalysis> createState() => _AdventureAnalysisState();
}

class _AdventureAnalysisState extends State<AdventureAnalysis> {
  String calculateCorrect() {
    int correct = 0;
    if (widget.data["questionDetails"].length == 0) {
      return "0";
    }
    for (var x in widget.data["questionDetails"]) {
      if (x != null && x["isCorrect"]) {
        correct++;
      }
    }
    return correct.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.data);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Q",
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Question",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "A",
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Answer",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "S",
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Selected",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      widget.data["total"].toString(),
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Solved",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      widget.data["solved"].toString(),
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Correct",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      calculateCorrect(),
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(widget.data["title"],
                          style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700)),
                    ),
                    for (var x in widget.data["questionDetails"]) ...[
                      if (x != null) ...[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: questionAnalysisCard(context, {
                              "Q": "${x["n1"]}+${x["n2"]}",
                              "A": x["answer"].toString(),
                              "S": x["answer_chosen"].toString(),
                              "level":
                                  (widget.data["questionDetails"].indexOf(x) +
                                          1)
                                      .toString(),
                              "check": (x["isCorrect"]) ? "tick" : "wrong",
                            })),
                      ]
                    ],
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.02,
                    // ),
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    //     child: questionAnalysisCard(context, {
                    //       "Q": "2+2",
                    //       "A": "4",
                    //       "S": "5",
                    //       "level": "2",
                    //       "check": "wrong"
                    //     })),
                  ],
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 10,
                  child: Image.asset(
                    "${imagePath}line_1.png",
                    height: MediaQuery.of(context).size.height * 0.2,
                  ))
            ],
          ),
        ));
  }
}
