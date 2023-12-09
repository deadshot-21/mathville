import 'package:flutter/material.dart';
import 'package:mathville/constants.dart';
import 'package:mathville/widgets/levelCards.dart';
import 'package:mathville/widgets/loader.dart';

class Levels extends StatefulWidget {
  const Levels({super.key, required this.questionSetUuid, required this.title});
  final String questionSetUuid;
  final String title;
  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  List oddQuestionSet = [];
  List evenQuestionSet = [];
  bool isLoading = false;

  void callback() {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
  }



  void preprocessData() {
    for (var x in questionSets) {
      if (x["uuid"] == widget.questionSetUuid) {
        int index = 0;
        for (var y in x["question"]) {
          index++;
          y["level"] = index;
          if (index % 2 == 0) {
            evenQuestionSet.add(y);
          } else {
            oddQuestionSet.add(y);
          }
        }
      }
    }
    print(evenQuestionSet);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preprocessData();
  }

  @override
  void dispose() {
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 24,
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Inter"),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              // Odd Numbers
                              for (var x in oddQuestionSet) ...[
                                levelCard(context, x, callback,
                                    widget.questionSetUuid, widget.title),
                                const SizedBox(
                                  height: 30,
                                ),
                                emptyCard(),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                              // levelCard(),
                              // const SizedBox(
                              //   height: 30,
                              // ),
                              // emptyCard(),
                              // const SizedBox(
                              //   height: 30,
                              // ),
                              // levelCard(),
                              // const SizedBox(
                              //   height: 30,
                              // ),
                              // emptyCard(),
                            ],
                          ),
                          Column(
                            children: [
                              // Even Numbers
                              for (var x in evenQuestionSet) ...[
                                emptyCard(),
                                const SizedBox(
                                  height: 30,
                                ),
                                levelCard(context, x, callback,
                                    widget.questionSetUuid, widget.title),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                              // emptyCard(),
                              // const SizedBox(
                              //   height: 30,
                              // ),
                              // levelCard(),
                              // const SizedBox(
                              //   height: 30,
                              // ),
                              // emptyCard(),
                              // const SizedBox(
                              //   height: 30,
                              // ),
                              // levelCard(),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
          );
  }
}
