import 'package:flutter/material.dart';
import 'package:mathville/constants.dart';

Widget questionAnalysisCard(context, data) {
  return Container(
    decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kPrimaryColor, width: 2)),
    // height: MediaQuery.of(context).size.height * 0.10,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.28,
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Q:",
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      data["Q"],
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "A:",
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      data["A"],
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: SizedBox(
              // width: MediaQuery.of(context).size.width * 0.25,
              // height: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: kBoxBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kBoxBackgroundColor),
                ),
                // height: 35,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: Row(
                    children: [
                      Text(
                        "S:",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        data["S"],
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 24),
                      Image.asset(
                        "${imagePath}${data["check"]}.png",
                        width: 18,
                        height: 18,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Stack(
              // crossAxisAlignment: CrossAxisAlignment.end,
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text("Level",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(data["level"],
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 64,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
