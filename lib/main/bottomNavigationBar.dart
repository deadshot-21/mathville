import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathville/constants.dart';
import 'package:mathville/main/analytics/analytics.dart';
import 'package:mathville/main/home/home.dart';

class BottomPageController extends StatefulWidget {
  BottomPageController(
      {super.key,
      this.selectedIndex = 0,
      this.selectedSubIndex = 0,
      this.security = false});
  int selectedIndex;
  int selectedSubIndex;
  bool security;

  // int getSubIndex() {
  //   return selectedSubIndex;
  // }

  @override
  State<BottomPageController> createState() => BottomPageControllerState();
}

class BottomPageControllerState extends State<BottomPageController> {
  int _selectedIndex = 0;
  String selectedView = "Home";
  final modules = {"home": "Home", "analytics": "Analytics"};
  // final modules = {"home": "Home", "add": "Add", "analytics": "Analytics"};
  List selectedColor = [];

  PageController _pageController = PageController();
  List<Widget> _screens = [];

  void setColor() {
    // if (!mounted) return;
    selectedColor = [];
    for (var x in modules.entries) {
      selectedColor.add(kSecondaryColor);
    }
  }

  void updatePage() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // getJWT();
    // getUserId();
    // getUserName();
    // connectWebSocket();
    _selectedIndex = widget.selectedIndex;
    _screens = [const Home(), const Analytics()];

    _pageController = PageController(initialPage: _selectedIndex);
    _pageController.addListener(() {
      // globalSelectedIndex = _selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    for (var x in modules.entries) {
      selectedColor.add(kSecondaryColor);
    }
    selectedColor[_selectedIndex] = kBackgroundColor;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          // boxShadow: const [
          //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          // ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: CupertinoTabBar(
              backgroundColor: kPrimaryColor,
              // activeColor: kLightColor,
              // inactiveColor: kBackgroundColor,
              // selectedLabelStyle: TextStyle(color: kSecondaryColor),
              // unselectedLabelStyle: TextStyle(color: kLightColor),
              // useLegacyColorScheme: false,
              // selectedItemColor: kLightColor,
              // type: BottomNavigationBarType.fixed,
              height: 40,
              currentIndex: _selectedIndex,
              onTap: (selectedPageIndex) {
                selectedColor = [];
                for (var x in modules.entries) {
                  selectedColor.add(kLightColor);
                }
                if (!mounted) return;
                setState(() {
                  _selectedIndex = selectedPageIndex;
                  _pageController.jumpToPage(selectedPageIndex);
                  selectedColor[selectedPageIndex] = kPrimaryColor;
                  if (selectedPageIndex == 1) {
                    selectedView = "Home";
                  } else if (selectedPageIndex == 2) {
                    // selectedView = "Add";
                    selectedView = "Analytics";
                  }
                  //else if (selectedPageIndex == 3) {
                  //   selectedView = "Analytics";
                  // }
                  // connectWebSocket();
                });
              },
              // selectedLabelStyle: fontIconText(kPrimary),
              // unselectedLabelStyle: fontIconText(kText),
              items: [
                // for (var x in modules.keys) ...[
                BottomNavigationBarItem(
                  icon: Image.asset(
                    (selectedView == "Home")
                        ? "${imagePath}home.png"
                        : "${imagePath}home.png",
                    // color:
                    //     selectedColor[modules.keys.toList().indexOf(x)],
                    height: 20,
                    width: 20,
                  ),

                  // label: modules[x].toString(),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    (selectedView == "Analytics")
                        ? "${imagePath}analytics.png"
                        : "${imagePath}analytics.png",
                    // color:
                    //     selectedColor[modules.keys.toList().indexOf(x)],
                    height: 20,
                    width: 20,
                  ),

                  // label: modules[x].toString(),
                ),
              ]
              // ],
              ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _screens,
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: 80,
            ),
          ),
        ],
      ),
    );
  }
}
