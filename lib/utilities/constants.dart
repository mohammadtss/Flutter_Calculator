import 'package:flutter/material.dart';
import 'package:pymt_calc/utilities/NetworkHelper.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:pymt_calc/View/reverseView.dart';
import 'package:ndialog/ndialog.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:device_info/device_info.dart';
import 'package:pymt_calc/Models/History.dart';
import 'package:pymt_calc/Models/oldData.dart';
import 'dart:io';

String returnPlatform() {
  if (Platform.isAndroid) {
    return 'android';
  } else if (Platform.isIOS) {
    return 'ios';
  }
}

//final LocalStorage storage = new LocalStorage('corporateStorage');

//const Colors KCleaColor = Colors.white.withOpacity(0.0);

//©Autogard Advantage
//1994-2019, All Rights Reserved.
//Version 5.5\

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]},';

//void showDeviceType() async {
//  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//  print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
//
//  IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//  print('Running on ${iosInfo.utsname.machine}');
//}

void showAlert2(BuildContext context, String text, String title) async {
  await showDialog(
      context: context,
      builder: (context) {
        return BlurDialogBackground(
          dialog: AlertDialog(
            title: Text(title),
            content: Text(
              text,
              style: TextStyle(),
            ),
            actions: <Widget>[
              DialogButton(
                color: Colors.green,
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              ),
            ],
          ),
        );
      });
}

var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.red,
  ),
);

void showAlert(String title, String description, String text, AlertType type,
    BuildContext context) {
  Alert(
    style: alertStyle,
    context: context,
    type: type,
    title: title,
    desc: description,
    buttons: [
      DialogButton(
        color: Colors.green,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void doAdvThings(String url) async {
  HelperNetwork networkHelper = HelperNetwork(url: url);

  List<dynamic> advData = await networkHelper.getData();

  if (advLinks.isNotEmpty) {
    advLinks.clear();
    advImages.clear();
    advimgs.clear();
  }
  int i = 0;
  //print('adv data = ${advData}');
  for (var item in advData) {
    advCounter[i] = i;
    //print('item = ${item}');
    advImages.add(item['AdvImage']);
    advLinks.add(item['Webpage']);
    advimgs.add(
      Image.memory(base64.decode(item['AdvImage'])),
    );
    i++;
  }
}

const String versionText = 'Version 5.5';
const String versionRights = '1994-2019, All Rights Reserved.';
const String versionDetail = '©Autogard Advantage';
const Color appRed = Color(0xffAF2125);

const KTextfiledTopStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: Color(0xff424242),
);

const KInputTextfieldsStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const KTextfieldCounterStyle = TextStyle(
  color: Colors.red,
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
);

TextStyle KLabeslStyles = TextStyle(
  color: Colors.grey[800],
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
);

TextStyle KButtonLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

TextStyle KHeaderTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.0,
  wordSpacing: 3.0,
);

TextStyle frequencyTextStyle = TextStyle(
  color: Colors.grey[700],
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

TextStyle resultBoxFirstLabelStyle = new TextStyle(
  color: Colors.grey[600],
  fontWeight: FontWeight.w500,
);

TextStyle resultBoxSecondLabelStyle = new TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w700,
  fontSize: 15.0,
);

TextStyle KHeadLabelsStyle = TextStyle(
  color: Colors.grey[800],
);

Color textDefaultBorder = Colors.grey;

const KActiveColor = Color(0xff727376);

const KGreenColor = Color(0xff78AE1D);

const KRedColor = Color(0xff983330);

Color bgGreen = Colors.green;

class CitiesService {
  static List<String> cities = [];

  void loadCity(List<String> citie) {
    cities = citie;
  }

  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

Widget LandingWidget(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Center(
        child: Image.asset('images/logonew.png'),
      ),
      Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ColorizeAnimatedTextKit(
              duration: Duration(seconds: 3),
              isRepeatingAnimation: false,
              onTap: () {
                print("Tap Event");
              },
              text: [
                "",
                "Your Car. Our Coverage.",
              ],
              textStyle: TextStyle(fontSize: 22.0, fontFamily: "Agne"),
              colors: [
                Colors.black,
                Colors.black,
                KRedColor,
                KRedColor,
                KRedColor,
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
              child: ColorizeAnimatedTextKit(
                duration: Duration(seconds: 3),
                isRepeatingAnimation: false,
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  "",
                  "TM",
                ],
                textStyle: TextStyle(fontSize: 12.0, fontFamily: "Agne"),
                colors: [
                  KRedColor,
                  Colors.black,
                  Colors.black,
                  Colors.black,
                ],
              ),
            ),
//                TypewriterAnimatedTextKit(
//                  isRepeatingAnimation: false,
//                  duration: Duration(seconds: 3),
//                  onTap: () {
//                    print("Tap Event");
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => PYMT(),
//                      ),
//                    );
//                  },
//                  text: [
//                    "Your Car. Our Coverage.",
//                  ],
//                  textStyle: TextStyle(fontSize: 17.0, fontFamily: "Agne"),
//                ),
          ],
        ),
      ),
    ],
  );
}

Widget advWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 0.0,
      ),
      Container(
        height: advHeight,
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: GestureDetector(
            onTap: () {
              //print('Link = ${Index}');
              _launchURL(advLinks[Index]);
            },
            child: CarouselSlider(
              viewportFraction: 1.0,
              aspectRatio: 5.0,
              autoPlay: true,
              items: advimgs,
              onPageChanged: (index) {
                Index = index;
                //print('index = ${advLinks[index]}');
              },
            ),
          ),
        ),
      ),
    ],
  );
}

List<String> advImages = [
  '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'
];
List<String> advLinks = [];
Map<int, int> advCounter = {};

List<Widget> advimgs = [];

double advHeight = 0.0;

int Index = 0;

String reversePaymentAmount = '0';

String reverseFrequency = '';

bool reverseResetPressed = false;

bool appFirstLoad = true;

bool fromHistory = false;

History historyData;

bool fromReverseIntro = false;

bool onceReverse = false;

bool standardReversePressed = false;
String frequencySt = 'All';
bool firstCalcSt = false;

oldData StdData;
oldData RvsData;

TextEditingController myControllerFrequencySt = TextEditingController();
final myControllerNetVehicleSt = TextEditingController();
final myControllerDownPaymentSt = TextEditingController();
final myControllerNetWarrantySt = TextEditingController();
final myControllerSalesTaxSt = TextEditingController();
final myControllerNetLoanSt = TextEditingController();
final myControllerExpectedIntersetSt = TextEditingController();
final myControllerTradeInSt = TextEditingController();
final myControllerExistingLoanSt = TextEditingController();
final myControllerLoanTermSt = TextEditingController();

final myControllerFrequencyRv = TextEditingController();
final myControllerNetVehicleRv = TextEditingController();
final myControllerDownPaymentRv = TextEditingController();
final myControllerNetWarrantyRv = TextEditingController();
final myControllerSalesTaxRv = TextEditingController();
final myControllerNetLoanRv = TextEditingController();
final myControllerExpectedIntersetRv = TextEditingController();
final myControllerTradeInRv = TextEditingController();
final myControllerExistingLoanRv = TextEditingController();
final myControllerLoanTermRv = TextEditingController();

ThemeData scrollTheme(BuildContext context) {
  return Theme.of(context);
}

String switchAm(String hour) {
  if (int.parse(hour) > 12) {
    return 'PM';
  } else {
    return 'AM';
  }
}

const String androidVersion = '4.0.1';
const String iosVersion = '4.0.1';

final myControllerFrequencyReverse = TextEditingController();
final myControllerAmountReverse = TextEditingController();

List<String> frequencies = ['All', 'Monthly', 'Bi Weekly', 'Weekly'];

//const String BaseUrl = "https://tsoftwaresolutions.com/calc";

const String BaseUrl = "https://autogardadvantageadmin.com:4789/";

String advertiseUrl = '${BaseUrl}api/Advertisement/GetAdvImages';
