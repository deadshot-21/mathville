import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathville/constants.dart';
import 'package:mathville/gameScreen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key, required this.details});
  final Map details;
  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int timeLeft = 10;

  int setTime() {
    if (widget.details["operator"] == "/" ||
        widget.details["operator"] == "x") {
      return 30;
    } else {
      return 10;
    }
  }

  void startTimer(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!mounted) return;
      setState(() {
        timeLeft--;
      });
      if (timeLeft == 0) {
        timer.cancel();

        var message = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GameScreen(
                      answer: widget.details["answer"].toString(),
                    )));
        if (!mounted) return;
        Navigator.pop(context, message);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeLeft = setTime();
    startTimer(context);
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Text(
                "Level ${widget.details["level"]}",
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Text(
                (widget.details["operator"] == "/")
                    ? "${widget.details["n1"]} ${String.fromCharCodes(Runes('\u00f7'))} ${widget.details["n2"]} = ?"
                    : "${widget.details["n1"]} ${widget.details["operator"]} ${widget.details["n2"]} = ?",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 56,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    color: kBackgroundColor,
                    border: Border.all(color: kLightColor, width: 10),
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Text(
                    timeLeft.toString(),
                    style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 56,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Image.asset(
                "${imagePath}timer_kids.png",
                width: 230,
              )
            ],
          ),
        ),
      ),
    );
  }
}
