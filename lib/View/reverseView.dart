import 'package:flutter/material.dart';
import 'package:pymt_calc/utilities/constants.dart';
import 'package:pymt_calc/utilities/header-text.dart';
import 'package:pymt_calc/View/reverseMainView.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ndialog/ndialog.dart';
import 'dart:async';
import 'package:pymt_calc/Models/History.dart';
import 'package:pymt_calc/utilities/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class reverseVieww extends StatefulWidget {
  @override
  _reverseViewwState createState() => _reverseViewwState();
}

class _reverseViewwState extends State<reverseVieww> {
  double frequencyHeight = 0.0;
  String frequency = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Alignment childAlignment = Alignment.center;
  DatabaseHelper databaseHelper = DatabaseHelper();

  Widget decideField(
      BuildContext context,
      TextEditingController control,
      List<String> data,
      String hint,
      Color backColor,
      GlobalKey<ScaffoldState> scaffoldKey) {
    String p = returnPlatform();

    print('data = $data');
    if (p == 'ios') {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
              color: backColor,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: TextField(
            style: TextStyle(fontSize: 20.0),
            controller: control,

            textInputAction: TextInputAction.next,
            //autofocus: true,
            cursorColor: Colors.red,
            //controller: myControllerUsername,
            textDirection: TextDirection.ltr,
            autocorrect: false,
            //style: KInputTextfieldsStyle,
            onTap: () {
              print('tapped');
              FocusScope.of(context).requestFocus(FocusNode());
              Picker picker = Picker(
                  backgroundColor: Colors.transparent,
                  headercolor: Colors.transparent,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        hint,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  confirmText: 'Select',
                  confirmTextStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                  ),
                  cancelTextStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                  ),
                  adapter: PickerDataAdapter<String>(pickerdata: data),
                  changeToFirst: true,
                  textAlign: TextAlign.left,
                  textStyle:
                      const TextStyle(color: Colors.grey, fontSize: 15.0),
                  selectedTextStyle:
                      TextStyle(color: Colors.blue, fontSize: 22.0),
                  columnPadding: const EdgeInsets.all(8.0),
                  onConfirm: (Picker picker, List value) {
                    //print(value.toString());
                    print(picker.getSelectedValues());
                    //callDepartment = picker.getSelectedValues()[0];
                    control.text = picker.getSelectedValues()[0];
                    reverseFrequency = picker.getSelectedValues()[0];
                    myControllerFrequencyReverse.text = reverseFrequency;
                    scaffoldKey.currentState.setState(() {});
                  });
              if (data.length > 0) {
                picker.show(scaffoldKey.currentState);
              }
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(8.0),
              suffixIcon: GestureDetector(
                onTap: () {
                  //print('tapped');
                },
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              counterStyle: KTextfieldCounterStyle,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              hintText: hint,
            ),
          ),
        ),
      );
    } else if (p == 'android') {
      String val = 'Select One';
      if (control.text == '') {
        val = 'Select One';
      } else {
        val = control.text;
      }

      return Container(
        //height: 45.0,
        //margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
        decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: DropdownButtonHideUnderline(
          child: Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[600]),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: DropdownButton<String>(
              //value: val,
              hint: Text(
                val,
                style: TextStyle(color: Colors.black),
              ),
              items: data.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              isExpanded: true,
              onChanged: (_) {
                print('selected = ${_}');
                control.text = _;

                reverseFrequency = _;
                myControllerFrequencyReverse.text = reverseFrequency;

                setState(() {});
              },
            ),
          ),
        ),
      );
    }
  }

  Widget topWidget() {
    return Column(
      children: <Widget>[
        Container(
          height: 50.0,
          color: KGreenColor,
        ),
        Container(
          margin:
              EdgeInsets.only(top: 16.0, left: 0.0, right: 0.0, bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 20,
                child: Container(
                  width: double.infinity,
                  child: HeaderTitle(),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60.0,
          width: double.infinity,
          color: KGreenColor,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 18.0,
                left: 12.0,
                child: Text(
                  'Reverse Calculator',
                  style: KHeaderTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget DropdownWidget(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: frequencyHeight,
      margin: EdgeInsets.only(
        left: 18.0,
        right: 18.0,
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: frequencies.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print('tapped Index = $index');
              frequency = frequencies[index];
              myControllerFrequencyReverse.text = frequency;
              print('frequency = ${frequency}');

              if (frequencyHeight == 0.0) {
                frequencyHeight = 210.0;
              } else {
                frequencyHeight = 0.0;
              }
              setState(() {
                //resultBoxesList.clear();
              });
            },
            child: Container(
              height: 50.0,
              child: Card(
                elevation: 8.0,
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 8.0,
                      top: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            margin: EdgeInsets.all(0.0),
                            child: Text(
                              '${frequencies[index]}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle frequencyTextStyle2 = TextStyle(
    color: Colors.grey[700],
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  void loadAdvs() async {
    await doAdvThings(advertiseUrl);
    setState(() {
      advHeight = 100.0;
    });
  }

  @override
  void initState() {
    loadAdvs();
    print('init');
    if (fromReverseIntro == false) {
      myControllerFrequencyReverse.text = 'Select One';
      myControllerAmountReverse.text = '';
    }

    super.initState();
  }

  @override
  void dispose() {
    //advHeight = 100.0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mainContext = context;

    Widget mainWidget() {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          //height: 1300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //ContentWidget(context),
              Container(
                margin: EdgeInsets.only(left: 18.0, top: 12.0),
                child: Text(
                  'Payment Frequency:',
                  textAlign: TextAlign.left,
                  style: frequencyTextStyle2,
                ),
              ),
              Container(
                height: 40.0,
                margin: EdgeInsets.only(left: 18.0, right: 18.0, top: 8.0),
                //alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onDoubleTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: decideField(context, myControllerFrequencyReverse,
                      frequencies, '', Colors.white, _scaffoldKey),
                ),
              ),
              DropdownWidget(context),
              Container(
                margin: EdgeInsets.only(left: 18.0, top: 12.0),
                child: Text(
                  'Payment Amount:',
                  textAlign: TextAlign.left,
                  style: frequencyTextStyle2,
                ),
              ),
              Container(
                height: 43.0,
                margin: EdgeInsets.only(left: 18.0, right: 18.0, top: 8.0),
                //alignment: Alignment.centerLeft,
                child: TextField(
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                  controller: myControllerAmountReverse,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  //autofocus: true,
                  cursorColor: Colors.red,
                  //controller: myControllerUsername,
                  textDirection: TextDirection.ltr,
                  autocorrect: false,

                  //style: KInputTextfieldsStyle,
                  onTap: () {
                    print('tapped');

                    setState(() {});
                  },
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('images/dollar_icon_green.png'),
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(8.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: textDefaultBorder,
                      ),
                    ),
                    counterStyle: KTextfieldCounterStyle,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: textDefaultBorder,
                      ),
                    ),
                    hintText: '0.00',
                  ),
                ),
              ),
              Container(
                height: 50.0,
                margin: EdgeInsets.only(left: 18.0, top: 12.0, right: 18.0),
                child: GestureDetector(
                  onTap: () {
                    print('calc');
                    if (myControllerFrequencyReverse.text != 'Select One' &&
                        myControllerAmountReverse.text != '') {
                      reversePaymentAmount = myControllerAmountReverse.text;
                      reverseFrequency = myControllerFrequencyReverse.text;

                      print(
                          '${double.parse(reversePaymentAmount)} reverseFreq = ${reverseFrequency}');

                      onceReverse = true;
                      fromReverseIntro = true;

//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => reverseMainVieww(),
//                        ),
//                      );
                      setState(() {});
                    } else if (myControllerFrequencyReverse.text ==
                        'Select One') {
//                      showAlert('Alert!', 'Please Select Payment Frequency',
//                          'Ok', AlertType.error, context);
                      showAlert2(context, 'Please Select Payment Frequency.',
                          'Alert!');
                    } else if (myControllerAmountReverse.text == '') {
                      showAlert2(
                          context, 'Please Enter Payment Amount.', 'Alert!');
                    }
                  },
                  child: Card(
                    elevation: 4.0,
                    color: appRed,
                    child: Center(
                      child: Text(
                        'CALCULATE',
                        style: KHeaderTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final bottom = MediaQuery.of(context).viewInsets.bottom;

    if (fromReverseIntro == false) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: KGreenColor,
            title: Text('Reverse Calculator'),
          ),
          resizeToAvoidBottomPadding: false,
          key: _scaffoldKey,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              advWidget(),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: KGreenColor),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: mainWidget(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return reverseMainVieww();
    }
  }
}
