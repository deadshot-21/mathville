import 'package:flutter/material.dart';

import '../../constants.dart';

class AddCustom extends StatefulWidget {
  const AddCustom({super.key});

  @override
  State<AddCustom> createState() => _AddCustomState();
}


class _AddCustomState extends State<AddCustom> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        child: Column(children: [
          Image.asset("${imagePath}add_custom_top.png"),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(kRadius),
                  border: Border.all(color: kPrimaryColor, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Addition",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500)),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        "${imagePath}plus_red.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // additionCard(),
        ]),
      ),
    );
  }
}
