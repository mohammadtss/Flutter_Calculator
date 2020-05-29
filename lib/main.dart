import 'package:flutter/material.dart';
import 'package:pymt_calc/utilities/header-text.dart';
import 'package:pymt_calc/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pymt_calc/View/standardView.dart';
import 'package:pymt_calc/View/reverseView.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:pymt_calc/View/historyView.dart';
import 'package:pymt_calc/utilities/NetworkHelper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pymt_calc/View/reverseMainView.dart';
import 'package:pymt_calc/View/LandingView.dart';

void main() => runApp(landingVieww());

class PYMT extends StatefulWidget {
  @override
  _PYMTState createState() => _PYMTState();
}

class _PYMTState extends State<PYMT> {
  dynamic currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

  void LoadTheAdv() async {
    await doAdvThings(advertiseUrl);
    advHeight = 100.0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    LoadTheAdv();
  }

  @override
  Widget build(BuildContext context) {
    //showDeviceType();
    //double width = MediaQuery.of(context).size.width;
    //print(
    //'firstLoad = ${appFirstLoad} press = ${reverseResetPressed} freqR = ${reverseFrequency}');

    if (fromReverseIntro == false) {
      //reversePaymentAmount = '0';
      //reverseFrequency = '';
    }

    print('reverse Pressed = $reverseResetPressed');

    if (reverseResetPressed == true) {
      //currentPage = 2;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: _getPage(currentPage),
            ),
          ),
          bottomNavigationBar: Container(
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FancyBottomNavigation(
                  initialSelection: 2,
                  circleColor: KGreenColor,
                  inactiveIconColor: KActiveColor,
                  textColor: KGreenColor,
                  tabs: [
                    TabData(
                      iconData: FontAwesomeIcons.calculator,
                      title: "STANDARD",
                      onclick: () {
                        final FancyBottomNavigationState fState =
                            bottomNavigationKey.currentState;
                        fState.setPage(0);
                      },
                    ),
                    TabData(
                        iconData: FontAwesomeIcons.history, title: "History"),
                    TabData(
                        iconData: FontAwesomeIcons.calculator, title: "Reverse")
                  ],
                  onTabChangedListener: (position) {
                    if (position == 0) {
                      reverseResetPressed = false;
                    }
                    setState(() {
                      fromHistory = false;
                      currentPage = 0;
                      //reversePaymentAmount = '';
                      currentPage = position;
                      onceReverse = false;
                    });
                  },
                ),
                Container(
                  height: 4.0,
                ),
              ],
            ),
          ),
        ),
      );

      reverseResetPressed = false;
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: _getPage(currentPage),
            ),
          ),
          bottomNavigationBar: Container(
            height: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FancyBottomNavigation(
                  circleColor: KGreenColor,
                  inactiveIconColor: KActiveColor,
                  textColor: KGreenColor,
                  tabs: [
                    TabData(
                      iconData: FontAwesomeIcons.calculator,
                      title: "STANDARD",
                      onclick: () {
                        final FancyBottomNavigationState fState =
                            bottomNavigationKey.currentState;
                        fState.setPage(0);
                      },
                    ),
                    TabData(
                        iconData: FontAwesomeIcons.history, title: "HISTORY"),
                    TabData(
                        iconData: FontAwesomeIcons.calculator, title: "REVERSE")
                  ],
                  onTabChangedListener: (position) {
                    setState(() {
                      fromHistory = false;
                      //reversePaymentAmount = '';
                      currentPage = position;
                      onceReverse = false;
                    });
                  },
                ),
                Container(
                  height: 4.0,
                ),
              ],
            ),
          ),
        ),
      );
    }

//    if (appFirstLoad == true) {
//      appFirstLoad = false;
//
//    } else if (appFirstLoad == false &&
//        reverseResetPressed != false &&
//        reverseFrequency != '') {
//      return MaterialApp(
//        debugShowCheckedModeBanner: false,
//        home: Scaffold(
//          body: Container(
//            decoration: BoxDecoration(color: Colors.white),
//            child: Center(
//              child: _getPage(currentPage),
//            ),
//          ),
//          bottomNavigationBar: Container(
//            height: 100.0,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                FancyBottomNavigation(
//                  circleColor: KGreenColor,
//                  inactiveIconColor: KActiveColor,
//                  textColor: KGreenColor,
//                  initialSelection: 2,
//                  tabs: [
//                    TabData(
//                      iconData: FontAwesomeIcons.calculator,
//                      title: "Standard",
//                      onclick: () {
//                        final FancyBottomNavigationState fState =
//                            bottomNavigationKey.currentState;
//                        fState.setPage(0);
//                      },
//                    ),
//                    TabData(
//                        iconData: FontAwesomeIcons.history, title: "History"),
//                    TabData(
//                        iconData: FontAwesomeIcons.calculator, title: "Reverse")
//                  ],
//                  onTabChangedListener: (position) {
//                    setState(() {
//                      currentPage = position;
//                    });
//                  },
//                ),
//                Container(
//                  height: 4.0,
//                ),
//              ],
//            ),
//          ),
//        ),
//      );
//    } else {
//      return MaterialApp(
//        debugShowCheckedModeBanner: false,
//        home: Scaffold(
//          body: Container(
//            decoration: BoxDecoration(color: Colors.white),
//            child: Center(
//              child: _getPage(currentPage),
//            ),
//          ),
//          bottomNavigationBar: Container(
//            height: 100.0,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                FancyBottomNavigation(
//                  initialSelection: 0,
//                  circleColor: KGreenColor,
//                  inactiveIconColor: KActiveColor,
//                  textColor: KGreenColor,
//                  tabs: [
//                    TabData(
//                      iconData: FontAwesomeIcons.calculator,
//                      title: "Standard",
//                      onclick: () {
//                        final FancyBottomNavigationState fState =
//                            bottomNavigationKey.currentState;
//                        fState.setPage(0);
//                      },
//                    ),
//                    TabData(
//                        iconData: FontAwesomeIcons.history, title: "History"),
//                    TabData(
//                        iconData: FontAwesomeIcons.calculator, title: "Reverse")
//                  ],
//                  onTabChangedListener: (position) {
//                    setState(() {
//                      currentPage = position;
//                    });
//                  },
//                ),
//                Container(
//                  height: 4.0,
//                ),
//              ],
//            ),
//          ),
//        ),
//      );
//    }
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        if (reverseResetPressed == true) {
          return reverseVieww();
        } else {
          return standardVieww();
        }
        break;
      case 1:
        return historyVieww();
      case 2:
        print('rv = ${reverseFrequency} pressed = ${reverseResetPressed}');
        if (fromReverseIntro == true) {
          return reverseMainVieww();
        } else {
          return reverseVieww();
        }

        break;
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("This is the basket page"),
            RaisedButton(
              child: Text(
                "Start new page",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            )
          ],
        );
    }
  }
}

//DefaultTabController(
//        length: 3,
//        child: Scaffold(
//          bottomNavigationBar: TabBar(
//            indicatorColor: Color(0xff78AE1D),
//            labelColor: Colors.black,
//            indicatorWeight: 1.0,
//            indicatorPadding:
//                EdgeInsets.only(bottom: 16.0, left: 8.0, right: 8.0),
//            indicatorSize: TabBarIndicatorSize.tab,
//            labelPadding: EdgeInsets.only(bottom: 22.0, left: 8.0, right: 8.0),
//            tabs: [
//              Tab(
//                icon: Icon(
//                  FontAwesomeIcons.calculator,
//                  size: 30.0,
//                  color: KActiveColor,
//                ),
//                child: Text(
//                  'Standard',
//                  style: TextStyle(
//                    color: Colors.blueGrey,
//                  ),
//                ),
//              ),
//              Tab(
//                icon: Icon(
//                  Icons.history,
//                  color: KActiveColor,
//                  size: 30.0,
//                ),
//                child: Text(
//                  'History',
//                  style: TextStyle(
//                    color: Colors.blueGrey,
//                  ),
//                ),
//              ),
//              Tab(
//                icon: Icon(
//                  FontAwesomeIcons.calculator,
//                  size: 30.0,
//                  color: KActiveColor,
//                ),
//                child: Text(
//                  'Reverse',
//                  style: TextStyle(
//                    color: Colors.blueGrey,
//                  ),
//                ),
//              ),
//            ],
//          ),
//          body: TabBarView(
//            children: [
//              //mainView(),
//              standardVieww(),
//              Icon(Icons.directions_bike),
//              reverseVieww(),
//            ],
//          ),
//        ),
//      ),
