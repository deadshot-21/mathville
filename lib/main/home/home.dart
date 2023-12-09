import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mathville/constants.dart';
import 'package:mathville/widgets/adventureCard.dart';
import 'package:mathville/widgets/loader.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  final Dio dio = Dio();

  Future<void> getQuestionSetDetails() async {
    Response response =
        await dio.get('${baseUrl}home/getAllQuestionSetsForUser/$uuid');
    if (response.data["status"]) {
      print(response.data["data"]);
      questionSets = response.data["data"]["questionSets"];
    }
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestionSetDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (isLoading)
          ? loader(context)
          : Scaffold(
              backgroundColor: kBackgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('${imagePath}home_page_top.png'),
                    const SizedBox(height: 20),
                    for (var x in questionSets) ...[
                      adventureCard(context,
                          {"title": x["name"], "difficulty": x["difficulty"], "uuid": x["uuid"]}),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}
