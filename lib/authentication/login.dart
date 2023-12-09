import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mathville/constants.dart';
import 'package:mathville/widgets/loader.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main/bottomNavigationBar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final Dio dio = Dio();
  final storage = const FlutterSecureStorage();
  bool isLoading = true;
  bool isValid = true;

  Future<bool> requestPermission() async {
    const permission = Permission.camera;

    if (await permission.status.isDenied) {
      await permission.request();
    }

    return await permission.status.isGranted;
  }

  Future<void> onSubmit() async {
    if (emailController.text.isEmpty || pwdController.text.isEmpty) {
      return;
    }
    var data = {
      "email": emailController.text,
      "password": pwdController.text,
    };
    print(data);
    Response response = await dio.post(
      '${baseUrl}user/login',
      options:
          Options(headers: {HttpHeaders.contentTypeHeader: "application/json"}),
      data: {
        "email": emailController.text,
        "password": pwdController.text,
      },
    );
    if (response.data["status"]) {
      print(response.data);
      await storage.write(key: "uuid", value: response.data["data"]["uuid"]);
      uuid = response.data["data"]["uuid"];
      bool isPermitted = await requestPermission();
      print(isPermitted);
      if (!isPermitted) {
        SystemNavigator.pop();
      }
      if (!mounted) return;
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return BottomPageController();
      }));
    } else {
      setState(() {
        isValid = false;
      });
      print(response.data);
    }
  }

  Future<void> checkUuid() async {
    try {
      String? readUuid = (await storage.read(key: "uuid"));
      print(readUuid);
      // if (uuid != null) {
      Response response = await dio.post(
        '${baseUrl}user/isValidUser',
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: {
          "uuid": readUuid,
        },
      );
      if (response.data["status"] && readUuid != null) {
        uuid = readUuid;
        bool isPermitted = await requestPermission();
        print(isPermitted);
        if (!isPermitted) {
          SystemNavigator.pop();
        }
        if (!mounted) return;
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return BottomPageController();
        }));
      }
      // }
    } finally {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  bool checkValidEmailAndPassword() {
    if (emailController.text.isEmpty ||
        !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(emailController.text)) {
      if (!mounted) return false;
      setState(() {
        isValid = false;
      });
      return false;
    } else if (pwdController.text.isEmpty || pwdController.text.length < 6) {
      if (!mounted) return false;
      setState(() {
        isValid = false;
      });
      return false;
    } else {
      if (!mounted) return false;
      setState(() {
        isValid = true;
      });
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFirstTime = true;
    checkUuid();
    // isLoading = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    pwdController.dispose();
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
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.05),
                            child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.055,
                              child: Image.asset('${imagePath}logo.png'),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child:
                                    Image.asset('${imagePath}yellow_girl.png'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0,
                                    top: MediaQuery.of(context).size.height *
                                        0.08),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hey Kiddo,\nLet's dive into",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor),
                                    ),
                                    Text(
                                      "Mathverse!",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.w700,
                                          color: kPrimaryColor),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Let's Start.",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor)),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.059,
                                      child: TextFormField(
                                        //textCapitalization: TextCapitalization.characters,
                                        // style: fontUserInputText(kSecondaryText),
                                        // obscureText: pwdobscureText,
                                        //scrollPadding: EdgeInsets.only(bottom: 40),
                                        // inputFormatters: [LengthLimitingTextInputFormatter(12)],
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        // validator: (text) {
                                        //   if (text == null || text.isEmpty) {
                                        //     return 'Please enter your email';
                                        //   }
                                        //   if (!RegExp(
                                        //           r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        //       .hasMatch(text)) {
                                        //     return 'Please enter a valid email';
                                        //   }
                                        //   return null;
                                        // },
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          // filled: true,
                                          // fillColor: kBoxBackground,
                                          // hintStyle: fontUserInputText(kSecondaryText),
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                              fontFamily: 'Inter',
                                              color: kPrimaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                          contentPadding: EdgeInsets.zero,
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                            size: 22,
                                            color: kPrimaryColor,
                                          ),

                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kRadius),
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 2)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kRadius),
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 2)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kRadius)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.016,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.059,
                                      child: TextFormField(
                                        //textCapitalization: TextCapitalization.characters,
                                        // style: fontUserInputText(kSecondaryText),
                                        obscureText: true,
                                        //scrollPadding: EdgeInsets.only(bottom: 40),
                                        // inputFormatters: [LengthLimitingTextInputFormatter(12)],
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        // validator: (text) {
                                        //   if (text == null || text.isEmpty) {
                                        //     return 'Please enter your password';
                                        //   }
                                        //   if (text.length < 6) {
                                        //     return 'Password must be at least 6 characters long';
                                        //   }
                                        //   return null;
                                        // },
                                        controller: pwdController,
                                        decoration: InputDecoration(
                                          // filled: true,
                                          // fillColor: kBoxBackground,
                                          hintStyle: TextStyle(
                                              fontFamily: 'Inter',
                                              color: kPrimaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                          hintText: 'Password',
                                          contentPadding: EdgeInsets.zero,
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            size: 22,
                                            color: kPrimaryColor,
                                          ),

                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kRadius),
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 2)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kRadius),
                                              borderSide: BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 2)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      kRadius)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.016,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.057,
                                      child: TextButton(
                                        onPressed: () {
                                          // Navigator.pushNamed(context, '/gameScreen');
                                          // setState(() {
                                          //   isLoading = true;
                                          // });

                                          if (checkValidEmailAndPassword()) {
                                            onSubmit();
                                          }
                                          // setState(() {
                                          //   isLoading = false;
                                          // });
                                          // onSubmit();
                                        },
                                        style: TextButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(kRadius),
                                          ),
                                        ),
                                        child: const Text(
                                          "Start the adventure!",
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: MediaQuery.of(context).size.height * 0.01,
                                // ),
                                // TextButton(
                                //   onPressed: () {},
                                //   child: Text("Continue as Guest ->",
                                //       style: TextStyle(
                                //           fontFamily: 'Inter',
                                //           fontSize: 14.0,
                                //           fontWeight: FontWeight.w600,
                                //           color: kPrimaryColor)),
                                // )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: !isValid,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                // color: kBackgroundColor,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kSecondaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: kBackgroundColor,
                                ),
                                child: Center(
                                    child: Text(
                                        "Enter a valid email and password",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: kSecondaryColor))),
                              ),
                            ),
                          )
                        ]),
                    Positioned(
                      right: 0,
                      child: Image.asset(
                        "${imagePath}9.png",
                        width: 130,
                        // height: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
