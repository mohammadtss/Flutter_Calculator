import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pymt_calc/utilities/constants.dart';
import 'package:pymt_calc/utilities/constants.dart' as prefix0;
import 'package:pymt_calc/utilities/header-text.dart';
import 'package:pymt_calc/utilities/resultBoxesWidget.dart';
import 'dart:math';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:device_info/device_info.dart';
import 'dart:async';
import 'package:pymt_calc/Models/History.dart';
import 'package:pymt_calc/utilities/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pymt_calc/Models/oldData.dart';

class standardVieww extends StatefulWidget {
  @override
  _standardViewwState createState() => _standardViewwState();
}

class _standardViewwState extends State<standardVieww> {
  double resultHeight;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double frequencyHeight = 0.0;
  double vp = 0.0;
  double wa = 0.0;
  double cl = 0.0;
  double vt = 0.0;
  double lb = 0.0;
  double dp = 0.0;
  double dl = 0.0;
  double tax = 0.0;
  double wMonthly = 0.0;
  double Monthly = 0.0;
  double totalAmountFinanced = 0.0;
  double wBiweekly = 0.0;
  double wWeekly = 0.0;
  double withWarranty = 0.0;
  double factor = 0.0;
  double PAw = 0.0;
  double TTw = 0.0;
  double FBw = 0.0;
  double IPw = 0.0;
  double PA = 0.0;
  double TT = 0.0;
  double FB = 0.0;
  double IP = 0.0;
  double total = 0.0;
  double Biweekly = 0.0;
  double Weekly = 0.0;
  double rate = 0.0;
  bool openKeyboard = false;
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
                    if (myControllerNetVehicleSt.text != '' &&
                        myControllerLoanTermSt.text != '') {
                      setState(() {});
                    }
                    frequencySt = picker.getSelectedValues()[0];
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

                if (myControllerNetVehicleSt.text != '' &&
                    myControllerLoanTermSt.text != '') {
                  setState(() {});
                }
                frequencySt = _;

                setState(() {});
              },
            ),
          ),
        ),
      );
    }
  }

  Widget frequencyWidget(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Wrap(
      children: <Widget>[
        Container(
          height: 40.0,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: 20.0,
            top: 8.0,
            right: 28.0,
            bottom: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenSize.width * 0.41,
                child: Center(
                  child: Text(
                    'Payment Frequency:'.toUpperCase(),
                    style: frequencyTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 40.0,
                  margin: EdgeInsets.only(left: 4.0),
                  //alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onDoubleTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: decideField(context, myControllerFrequencySt,
                        frequencies, '', Colors.white, _scaffoldKey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget LabelsWidget(String firstLabel, String secondLabel) {
    Size screenSize = MediaQuery.of(context).size;
    return Wrap(
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: screenSize.width * 0.47,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 12.0),
            child: Text(
              firstLabel,
              textAlign: TextAlign.left,
              style: KHeadLabelsStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        SizedBox(
          width: screenSize.width * 0.478,
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0, top: 12.0),
            child: Text(
              secondLabel,
              textAlign: TextAlign.left,
              style: KHeadLabelsStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  void loadAdvs() async {
    await doAdvThings(advertiseUrl);
    setState(() {
      advHeight = 100.0;
    });
  }

  bool firstTime = false;

  @override
  void initState() {
    super.initState();

    //openKeyboard = false;

    setState(() {
      //loadAdvs();
      if (standardReversePressed == true || firstCalcSt == false) {
        myControllerFrequencySt.text = 'All';
        myControllerSalesTaxSt.text = '13';
      }

      if (myControllerFrequencySt.text == '') {
        myControllerFrequencySt.text = 'All';
        resultHeight = 0.0;
      }

      print('resultHeight = $resultHeight');

      if (fromHistory == true) {
        //firstCalcSt = false;
        resultHeight = 18.0;
        myControllerNetVehicleSt.text = historyData.netVehiclePrice;
        myControllerDownPaymentSt.text = historyData.downPayment;
        myControllerNetWarrantySt.text = historyData.netWarrantyCost;
        myControllerSalesTaxSt.text = historyData.salesTax;
        myControllerNetLoanSt.text = historyData.netLoanCost;
        myControllerTradeInSt.text = historyData.tradeInValue;
        myControllerExistingLoanSt.text = historyData.existingLoan;
        myControllerLoanTermSt.text = historyData.loanTerm;
        frequencySt = historyData.frequency;
        myControllerFrequencySt.text = frequencySt;
        //fromHistory = false;
      } else {
        if (StdData != null) {
          myControllerNetVehicleSt.text = StdData.netVehiclePrice;
          myControllerDownPaymentSt.text = StdData.downPayment;
          myControllerNetWarrantySt.text = StdData.netWarrantyCost;
          myControllerSalesTaxSt.text = StdData.salesTax;
          myControllerNetLoanSt.text = StdData.netLoanCost;
          myControllerTradeInSt.text = StdData.tradeInValue;
          myControllerExistingLoanSt.text = StdData.existingLoan;
          myControllerLoanTermSt.text = StdData.loanTerm;
          frequencySt = StdData.frequency;
          myControllerFrequencySt.text = frequencySt;
          //firstCalcSt = false;
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    //advHeight = 100.0;

    //openKeyboard = false;
    //setState(() {});
    myControllerNetVehicleSt.text = '';
    myControllerDownPaymentSt.text = '';
    myControllerNetWarrantySt.text = '';
    myControllerSalesTaxSt.text = '';
    myControllerNetLoanSt.text = '';
    myControllerExpectedIntersetSt.text = '';
    myControllerTradeInSt.text = '';
    myControllerExistingLoanSt.text = '';
    myControllerLoanTermSt.text = '';
    myControllerFrequencySt.text = 'All';
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ScrollController scList;

    print('firstCalc = $firstCalcSt');

    if (standardReversePressed == true) {
      resultHeight = 0.0;
    }

    setState(() {});

    List<Widget> resultBoxesList = [];

    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';

    if (myControllerNetVehicleSt.text != '' &&
        myControllerLoanTermSt.text != '' &&
        firstCalcSt == true) {
      switch (frequencySt) {
        case 'All':
          if (wa != 0.0 || cl != 0.0) {
            resultBoxesList = [
              resultBoxes(
                      titleLabel: 'MONTHLY:',
                      withoutLabel:
                          ' \$${Monthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wMonthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'BI WEEKLY:',
                      withoutLabel:
                          ' \$${Biweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wBiweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'WEEKLY:',
                      withoutLabel:
                          ' \$${Weekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wWeekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'Total Financed Amount:',
                      withoutLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .totalBox(context),
            ];
          } else {
            resultBoxesList = [
              resultBoxes(
                      titleLabel: 'MONTHLY:',
                      withoutLabel:
                          ' \$${Monthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wMonthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: false)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'BI WEEKLY:',
                      withoutLabel:
                          ' \$${Biweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wBiweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: false)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'WEEKLY:',
                      withoutLabel:
                          ' \$${Weekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wWeekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: false)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'Total Financed Amount:',
                      withoutLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .totalBox(context),
            ];
          }

          break;
        case 'Monthly':
          if (wa != 0.0 || cl != 0.0) {
            resultBoxesList = [
              resultBoxes(
                      titleLabel: 'MONTHLY:',
                      withoutLabel:
                          ' \$${Monthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wMonthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'Total Financed Amount:',
                      withoutLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .totalBox(context),
            ];
          } else {
            resultBoxesList = [
              resultBoxes(
                      titleLabel: 'MONTHLY:',
                      withoutLabel:
                          ' \$${Monthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wMonthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: false)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'Total Financed Amount:',
                      withoutLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: false)
                  .totalBox(context),
            ];
          }

          break;
        case 'Bi Weekly':
          if (wa != 0.0 || cl != 0.0) {
            resultBoxesList = [
              resultBoxes(
                      titleLabel: 'BI WEEKLY:',
                      withoutLabel:
                          ' \$${Biweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wBiweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'Total Financed Amount:',
                      withoutLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .totalBox(context),
            ];
          } else {
            resultBoxesList = [
              resultBoxes(
                      titleLabel: 'BI WEEKLY:',
                      withoutLabel:
                          ' \$${Biweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wBiweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: false)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'Total Financed Amount:',
                      withoutLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: false)
                  .totalBox(context),
            ];
          }

          break;
        case 'Weekly':
          if (wa != 0.0 || cl != 0.0) {
            resultBoxesList = [
              resultBoxes(
                      titleLabel: 'WEEKLY:',
                      withoutLabel:
                          ' \$${Weekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wWeekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'Total Financed Amount:',
                      withoutLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: true)
                  .totalBox(context),
            ];
          } else {
            resultBoxesList = [
              resultBoxes(
                      titleLabel: 'WEEKLY:',
                      withoutLabel:
                          ' \$${Weekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${wWeekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: false)
                  .ResultBox(context),
              resultBoxes(
                      titleLabel: 'Total Financed Amount:',
                      withoutLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      includingLabel:
                          ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                      backColor: Colors.grey[200],
                      borderColor: Colors.black,
                      showIncluding: false)
                  .totalBox(context),
            ];
          }

          break;
        default:
          resultBoxesList = [];
          break;
      }
    } else {
      resultHeight = 0.0;
      if (fromHistory == true) {
        resultHeight = 18.0;
      }
    }

    if (!firstTime && standardReversePressed == true) {
      resultBoxesList = [
        resultBoxes(
                titleLabel: 'MONTHLY:',
                withoutLabel: ' \$147.98',
                includingLabel: ' \$146.98',
                backColor: Colors.grey[200],
                borderColor: Colors.black,
                showIncluding: true)
            .ResultBox(context),
        resultBoxes(
                titleLabel: 'BI WEEKLY:',
                withoutLabel: ' \$147.98',
                includingLabel: ' \$148.98',
                backColor: Colors.grey[200],
                borderColor: Colors.black,
                showIncluding: true)
            .ResultBox(context),
        resultBoxes(
                titleLabel: 'WEEKLY:',
                withoutLabel: ' \$147.98',
                includingLabel: ' \$150.98',
                backColor: Colors.grey[200],
                borderColor: Colors.black,
                showIncluding: true)
            .ResultBox(context),
        resultBoxes(
                titleLabel: 'Total Financed Amount:',
                withoutLabel: ' \$147.98',
                includingLabel: ' \$150.98',
                backColor: Colors.grey[200],
                borderColor: Colors.black,
                showIncluding: true)
            .totalBox(context),
      ];

      firstTime = true;
    }

    Widget DropdownWidget(BuildContext context) {
      Size screenSize = MediaQuery.of(context).size;
      return Container(
        height: frequencyHeight,
        margin: EdgeInsets.only(
          left: screenSize.width * 0.42,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: frequencies.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print('tapped Index = $index');
                frequencySt = frequencies[index];
                myControllerFrequencySt.text = frequencySt;
                print('frequency = ${frequencySt}');

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

    void calcFunction() {
//      myControllerNetVehicleSt.text =
//          double.parse(myControllerNetVehicleSt.text)
//              .toStringAsFixed(2)
//              .replaceAllMapped(reg, mathFunc);
      //print(
      //  'v = ${double.parse(myControllerNetVehicleSt.text).toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}');
      openKeyboard = true;
      if (frequencySt == '') {
        frequencySt = 'All';
      }

      if (frequencySt == 'All') {
        resultHeight = 18.0;
      }

      if (myControllerExpectedIntersetSt.text != '') {
        rate = (double.parse(myControllerExpectedIntersetSt.text) / 12) / 100;
      } else {
        rate = (0.000000001 / 12) / 100;
      }

      if (myControllerNetVehicleSt.text.replaceAll(',', '') != '') {
        vp = double.parse(myControllerNetVehicleSt.text.replaceAll(',', ''));
      } else {
        vp = 0.0;
      }

      if (myControllerNetWarrantySt.text != '') {
        wa = double.parse(myControllerNetWarrantySt.text);
      } else {
        wa = 0.0;
      }

      if (myControllerNetLoanSt.text != '') {
        cl = double.parse(myControllerNetLoanSt.text);
      } else {
        cl = 0.0;
      }

      if (myControllerTradeInSt.text != '') {
        vt = double.parse(myControllerTradeInSt.text);
      } else {
        vt = 0.0;
      }

      if (myControllerExistingLoanSt.text != '') {
        lb = double.parse(myControllerExistingLoanSt.text);
      } else {
        lb = 0.0;
      }

      if (myControllerDownPaymentSt.text != '') {
        dp = double.parse(myControllerDownPaymentSt.text);
      } else {
        dp = 0.0;
      }

      if (myControllerLoanTermSt.text != '') {
        dl = double.parse(myControllerLoanTermSt.text);
      } else {
        dl = 0.0;
      }

      if (myControllerSalesTaxSt.text != '') {
        tax = double.parse(myControllerSalesTaxSt.text) / 100;
      } else {
        tax = 0.13;
      }

      if (vp != 0.0 && dl != 0.0) {
        var factor = (((pow((1 + rate), dl)) - 1) /
            (rate == 0 ? 1 : (rate * pow((1 + rate), dl))));
        withWarranty = 0.0;
        if (wa != 0.0 || cl != 0.0) {
          PAw = (((vp + lb) + (wa + cl)) - (vt + dp));
          TTw = ((vp - vt) + (wa + cl)) * tax;
          FBw = PAw + TTw;
          withWarranty = FBw;
          print('fbw = ${FBw}');
          IPw = FBw / (factor == 0 ? 1 : factor);
          wMonthly = ((IPw));
          wBiweekly = (((IPw * 12) / 26.0293));
          wWeekly = (((IPw * 12) / 52.083));
        }
        PA = (vp + lb) - (vt + dp);
        TT = ((vp - vt) * tax);
        FB = PA + TT;
        if (withWarranty == 0.0) {
          withWarranty = FB;
        }
        IP = FB / (factor == 0 ? 1 : factor);
        print('fb = ${FB}');
        total = (withWarranty == 0 ? 1 : withWarranty);
        Monthly = (IP);
        Biweekly = (((IP * 12) / 26.0293));
        Weekly = (((IP * 12) / 52.083));
      }

      setState(() {
        if (myControllerNetVehicleSt.text.replaceAll(',', '') != '' &&
            myControllerLoanTermSt.text != '') {
          // myControllerNetVehicleSt.text =
          //   vp.toStringAsFixed(2).replaceAllMapped(reg, mathFunc);
          switch (frequencySt) {
            case 'All':
              if (wa != 0.0 || cl != 0.0) {
                resultBoxesList = [
                  resultBoxes(
                          titleLabel: 'MONTHLY:',
                          withoutLabel:
                              ' \$${Monthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wMonthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'BI WEEKLY:',
                          withoutLabel:
                              ' \$${Biweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wBiweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'WEEKLY:',
                          withoutLabel:
                              ' \$${Weekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wWeekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'Total Financed Amount:',
                          withoutLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .totalBox(context),
                ];
              } else {
                resultBoxesList = [
                  resultBoxes(
                          titleLabel: 'MONTHLY:',
                          withoutLabel:
                              ' \$${Monthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wMonthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: false)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'BI WEEKLY:',
                          withoutLabel:
                              ' \$${Biweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wBiweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: false)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'WEEKLY:',
                          withoutLabel:
                              ' \$${Weekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wWeekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: false)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'Total Financed Amount:',
                          withoutLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .totalBox(context),
                ];
              }

              break;
            case 'Monthly':
              if (wa != 0.0 || cl != 0.0) {
                resultBoxesList = [
                  resultBoxes(
                          titleLabel: 'MONTHLY:',
                          withoutLabel:
                              ' \$${Monthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wMonthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'Total Financed Amount:',
                          withoutLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .totalBox(context),
                ];
              } else {
                resultBoxesList = [
                  resultBoxes(
                          titleLabel: 'MONTHLY:',
                          withoutLabel:
                              ' \$${Monthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wMonthly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: false)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'Total Financed Amount:',
                          withoutLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: false)
                      .totalBox(context),
                ];
              }

              break;
            case 'Bi Weekly':
              if (wa != 0.0 || cl != 0.0) {
                resultBoxesList = [
                  resultBoxes(
                          titleLabel: 'BI WEEKLY:',
                          withoutLabel:
                              ' \$${Biweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wBiweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'Total Financed Amount:',
                          withoutLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .totalBox(context),
                ];
              } else {
                resultBoxesList = [
                  resultBoxes(
                          titleLabel: 'BI WEEKLY:',
                          withoutLabel:
                              ' \$${Biweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wBiweekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: false)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'Total Financed Amount:',
                          withoutLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: false)
                      .totalBox(context),
                ];
              }

              break;
            case 'Weekly':
              if (wa != 0.0 || cl != 0.0) {
                resultBoxesList = [
                  resultBoxes(
                          titleLabel: 'WEEKLY:',
                          withoutLabel:
                              ' \$${Weekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wWeekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'Total Financed Amount:',
                          withoutLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: true)
                      .totalBox(context),
                ];
              } else {
                resultBoxesList = [
                  resultBoxes(
                          titleLabel: 'WEEKLY:',
                          withoutLabel:
                              ' \$${Weekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${wWeekly.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: false)
                      .ResultBox(context),
                  resultBoxes(
                          titleLabel: 'Total Financed Amount:',
                          withoutLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          includingLabel:
                              ' \$${total.toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                          backColor: Colors.grey[200],
                          borderColor: Colors.black,
                          showIncluding: false)
                      .totalBox(context),
                ];
              }

              break;
            default:
              resultBoxesList = [];
              break;
          }
        } else {
          resultHeight = 0.0;
        }
      });

      setState(() {});
      print('Total = ${total}');
    }

    Widget backWidget(BuildContext context) {
      if (fromHistory == true && historyData.reverseAmount == '') {
        print('History STD');

        //firstCalcSt = false;

        calcFunction();

        return Container(
          margin: EdgeInsets.only(top: 0.0, left: 8.0, right: 0.0, bottom: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  fromHistory = false;
                  Navigator.pop(context);
                },
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          //margin:
          //  EdgeInsets.only(top: 16.0, left: 0.0, right: 0.0, bottom: 16.0),
          height: 0.0,
          width: 0.0,
        );
      }
    }

    Widget TextfieldsWidget(
        String firstHint,
        String secondHint,
        TextEditingController controller1,
        TextEditingController controller2,
        Color textColor,
        Image prefixIcon1,
        Image prefixIcon2) {
      Size screenSize = MediaQuery.of(context).size;
      if (prefixIcon1 != null && prefixIcon2 != null) {
        return Wrap(
          alignment: WrapAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0.0, left: screenSize.width * 0.06),
              height: 35.0,
              width: screenSize.width * 0.42,
              child: TextField(
                controller: controller1,
                style: TextStyle(
                  color: textColor,
                ),
                keyboardAppearance: Brightness.light,
                textInputAction: TextInputAction.next,
                //autofocus: true,
                cursorColor: Colors.red,
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text1');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text1');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onTap: () {
                  print('tap1');
                },
                decoration: InputDecoration(
                  prefixIcon: prefixIcon1,
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
                  //hintText: firstHint,
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 0.0, right: screenSize.width * 0.072),
              height: 35.0,
              width: screenSize.width * 0.42,
              child: TextField(
                controller: controller2,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                keyboardAppearance: Brightness.light,
                //autofocus: true,
                cursorColor: Colors.red,
                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text2');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text2');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onTap: () {},
                decoration: InputDecoration(
                  prefixIcon: prefixIcon2,
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
                  //hintText: secondHint,
                ),
              ),
            ),
          ],
        );
      } else if (prefixIcon1 != null && prefixIcon2 == null) {
        return Wrap(
          alignment: WrapAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0.0, left: screenSize.width * 0.06),
              height: 35.0,
              width: screenSize.width * 0.42,
              child: TextField(
                controller: controller1,
                style: TextStyle(
                  color: textColor,
                ),
                keyboardAppearance: Brightness.light,
                textInputAction: TextInputAction.next,
                autofocus: true,
                cursorColor: Colors.red,
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text1');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text1');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onTap: () {
                  print('tap1');
                },
                decoration: InputDecoration(
                  prefixIcon: prefixIcon1,
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
                  // hintText: firstHint,
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 0.0, right: screenSize.width * 0.072),
              height: 35.0,
              width: screenSize.width * 0.42,
              child: TextField(
                controller: controller2,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                keyboardAppearance: Brightness.light,
                autofocus: true,
                cursorColor: Colors.red,
                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text2');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text2');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onTap: () {},
                decoration: InputDecoration(
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
                  // hintText: secondHint,
                ),
              ),
            ),
          ],
        );
      } else if (prefixIcon2 != null && prefixIcon1 == null) {
        return Wrap(
          alignment: WrapAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0.0, left: screenSize.width * 0.06),
              height: 35.0,
              width: screenSize.width * 0.42,
              child: TextField(
                controller: controller1,
                style: TextStyle(
                  color: textColor,
                ),
                keyboardAppearance: Brightness.light,
                textInputAction: TextInputAction.next,
                //autofocus: true,
                cursorColor: Colors.red,
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text1');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text1');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onTap: () {
                  print('tap1');
                },
                decoration: InputDecoration(
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
                  //hintText: firstHint,
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 0.0, right: screenSize.width * 0.072),
              height: 35.0,
              width: screenSize.width * 0.42,
              child: TextField(
                controller: controller2,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                keyboardAppearance: Brightness.light,
                //autofocus: true,
                cursorColor: Colors.red,
                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text2');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text2');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onTap: () {},
                decoration: InputDecoration(
                  prefixIcon: prefixIcon2,
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
                  //hintText: secondHint,
                ),
              ),
            ),
          ],
        );
      } else {
        return Wrap(
          alignment: WrapAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0.0, left: screenSize.width * 0.06),
              height: 35.0,
              width: screenSize.width * 0.42,
              child: TextField(
                controller: controller1,
                style: TextStyle(
                  color: textColor,
                ),
                keyboardAppearance: Brightness.light,
                textInputAction: TextInputAction.next,
                //autofocus: true,
                cursorColor: Colors.red,
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text1');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text1');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onTap: () {
                  print('tap1');
                },
                decoration: InputDecoration(
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
                  //hintText: firstHint,
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 0.0, right: screenSize.width * 0.072),
              height: 35.0,
              width: screenSize.width * 0.42,
              child: TextField(
                controller: controller2,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                keyboardAppearance: Brightness.light,
                //autofocus: true,
                cursorColor: Colors.red,
                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text2');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text2');
                  if (myControllerNetVehicleSt.text != '' &&
                      myControllerLoanTermSt.text != '') {
                    //calcFunction();
                  }
                },
                onTap: () {},
                decoration: InputDecoration(
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
                  //hintText: secondHint,
                ),
              ),
            ),
          ],
        );
      }
    }

    Widget CalculateWidget(BuildContext context) {
      Size screenSize = MediaQuery.of(context).size;
      return Wrap(
        alignment: WrapAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 3.0, left: screenSize.width * 0.065),
            height: 35.0,
            width: screenSize.width * 0.42,
            child: TextField(
              keyboardAppearance: Brightness.light,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: myControllerLoanTermSt,
              textInputAction: TextInputAction.next,
              //autofocus: true,
              cursorColor: appRed,
              //controller: myControllerUsername,
              textDirection: TextDirection.ltr,
              autocorrect: false,
              //style: KInputTextfieldsStyle,
              onChanged: (text) {
                print('text1');
                if (myControllerNetVehicleSt.text != '' &&
                    myControllerLoanTermSt.text != '') {
                  //calcFunction();
                }
              },
              onEditingComplete: () {
                print('text1');
                if (myControllerNetVehicleSt.text != '' &&
                    myControllerLoanTermSt.text != '') {
                  //calcFunction();
                }
              },
              onTap: () {},
              decoration: InputDecoration(
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
                //hintText: 'Months',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 24.0),
            height: 38.0,
            width: screenSize.width * 0.435,
            child: GestureDetector(
              onTap: () {
                if (myControllerNetVehicleSt.text != '' &&
                    myControllerLoanTermSt.text != '') {
                  print('pressed');
                  FocusScope.of(context).requestFocus(FocusNode());
                  // advHeight = 0.0;
                  calcFunction();
                } else if (myControllerNetVehicleSt.text == '') {
                  showAlert2(
                      context, 'Please Enter Net Vehicle Price.', 'Alert!');
                } else if (myControllerLoanTermSt.text == '') {
                  showAlert2(context, 'Please Enter Loan Term.', 'Alert!');
                }

                //print('std Old Data = ${StdData.netVehiclePrice}');

                if (fromHistory == false) {
                  StdData = oldData(
                      netVehiclePrice: myControllerNetVehicleSt.text,
                      downPayment: myControllerDownPaymentSt.text,
                      netWarrantyCost: myControllerNetWarrantySt.text,
                      salesTax: myControllerSalesTaxSt.text,
                      netLoanCost: myControllerNetLoanSt.text,
                      expectedRate: myControllerExpectedIntersetSt.text,
                      tradeInValue: myControllerTradeInSt.text,
                      existingLoan: myControllerExistingLoanSt.text,
                      loanTerm: myControllerLoanTermSt.text,
                      frequency: frequencySt);
                } else {}

                if (myControllerNetVehicleSt.text != '' &&
                    myControllerLoanTermSt.text != '') {
                  if (wa != 0.0 ||
                      cl != 0.0 &&
                          myControllerNetWarrantySt.text != '0' &&
                          myControllerNetLoanSt.text != '0') {
                    databaseHelper.insertHistory(History(
                        'STD',
                        '$wWeekly',
                        '$wMonthly',
                        '$wBiweekly',
                        '${myControllerNetVehicleSt.text.replaceAll(',', '')}',
                        '${myControllerDownPaymentSt.text.replaceAll(',', '')}',
                        '${myControllerNetWarrantySt.text.replaceAll(',', '')}',
                        '${myControllerSalesTaxSt.text.replaceAll(',', '')}',
                        '${myControllerNetLoanSt.text.replaceAll(',', '')}',
                        '${myControllerExpectedIntersetSt.text.replaceAll(',', '')}',
                        '${myControllerTradeInSt.text.replaceAll(',', '')}',
                        '${myControllerExistingLoanSt.text.replaceAll(',', '')}',
                        '${myControllerLoanTermSt.text.replaceAll(',', '')}',
                        '${myControllerFrequencySt.text.replaceAll(',', '')}',
                        '${total}',
                        '',
                        '${DateTime.now()}'));
                  } else {
                    databaseHelper.insertHistory(History(
                        'STD',
                        '$Weekly',
                        '$Monthly',
                        '$Biweekly',
                        '${myControllerNetVehicleSt.text.replaceAll(',', '')}',
                        '${myControllerDownPaymentSt.text.replaceAll(',', '')}',
                        '${myControllerNetWarrantySt.text.replaceAll(',', '')}',
                        '${myControllerSalesTaxSt.text.replaceAll(',', '')}',
                        '${myControllerNetLoanSt.text.replaceAll(',', '')}',
                        '${myControllerExpectedIntersetSt.text.replaceAll(',', '')}',
                        '${myControllerTradeInSt.text.replaceAll(',', '')}',
                        '${myControllerExistingLoanSt.text.replaceAll(',', '')}',
                        '${myControllerLoanTermSt.text.replaceAll(',', '')}',
                        '${myControllerFrequencySt.text.replaceAll(',', '')}',
                        '${total}',
                        '',
                        '${DateTime.now()}'));
                  }
                }
              },
              child: Card(
                color: appRed,
                child: Center(
                  child: Text(
                    'CALCULATE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget ContentWidget(BuildContext context) {
      Size screenSize = MediaQuery.of(context).size;
      double topConstraint = 0.0;

      if (frequencyHeight == 210.0) {
        topConstraint = 0.0;
      } else {
//      topConstraint = 0.008;
        topConstraint = 0.0;
      }

      if (frequencySt != '') {
//        resultHeight = 18.0;
      } else {
        resultHeight = 0.0;
        resultBoxesList = [];
      }

      if (myControllerNetVehicleSt.text != '' &&
          myControllerLoanTermSt.text != '' &&
          firstCalcSt == true) {
        resultHeight = 18.0;
      }

      print('height = ${resultHeight} list = ${resultBoxesList}');

      if (wa != 0.0 || cl != 0.0) {
        return Container(
          margin: EdgeInsets.only(top: 0.0),
//          height: 1370.0,
          //height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: resultHeight,
                margin: EdgeInsets.only(top: 0.0, left: 0.0),
                padding: EdgeInsets.all(0.0),
                color: Colors.transparent,
                child: Wrap(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Without Warranty',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Including Warranty' + ' ✓',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: resultBoxesList,
              ),
              LabelsWidget(' Net Vehicle Price*', '  Your Down Payment'),
              TextfieldsWidget(
                '',
                '',
                myControllerNetVehicleSt,
                myControllerDownPaymentSt,
                Colors.black,
                Image.asset(
                  'images/dollar_icon.png',
                  scale: 1.2,
                ),
                Image.asset(
                  'images/dollar_icon.png',
                  scale: 1.2,
                ),
              ),
              LabelsWidget(' Net Warranty Plan Cost', '   Sales Tax'),
              TextfieldsWidget(
                '',
                '',
                myControllerNetWarrantySt,
                myControllerSalesTaxSt,
                Colors.green,
                Image.asset(
                  'images/dollar_icon_green.png',
                  scale: 1.2,
                ),
                Image.asset(
                  'images/percent_icon.png',
                  scale: 1.2,
                ),
              ),
              LabelsWidget(
                  ' Net Loan Protection Cost', '   Expected Interest Rate'),
              TextfieldsWidget(
                '',
                '',
                myControllerNetLoanSt,
                myControllerExpectedIntersetSt,
                Colors.green,
                Image.asset(
                  'images/dollar_icon_green.png',
                  scale: 1.2,
                ),
                Image.asset(
                  'images/percent_icon.png',
                  scale: 1.2,
                ),
              ),
              LabelsWidget(' Trade-in Value', '   Existing Loan Balance'),
              TextfieldsWidget(
                '',
                '',
                myControllerTradeInSt,
                myControllerExistingLoanSt,
                Colors.black,
                Image.asset(
                  'images/dollar_icon.png',
                  scale: 1.2,
                ),
                Image.asset(
                  'images/dollar_icon.png',
                  scale: 1.2,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.47,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                      child: Text(
                        '       Loan Term (in months)*',
                        textAlign: TextAlign.left,
                        style: KHeadLabelsStyle,
                      ),
                    ),
                  ),
                ],
              ),
              CalculateWidget(context),
            ],
          ),
        );
      } else {
        return Container(
//            height: 1300.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: resultHeight,
                margin: EdgeInsets.only(top: 0.0, left: 0.0),
                color: Colors.transparent,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Without Warranty',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: resultBoxesList,
              ),
              LabelsWidget(' Net Vehicle Price*', '  Your Down Payment'),
              TextfieldsWidget(
                '',
                '',
                myControllerNetVehicleSt,
                myControllerDownPaymentSt,
                Colors.black,
                Image.asset(
                  'images/dollar_icon.png',
                  scale: 1.2,
                ),
                Image.asset(
                  'images/dollar_icon.png',
                  scale: 1.2,
                ),
              ),
              LabelsWidget(' Net Warranty Plan Cost', '   Sales Tax'),
              TextfieldsWidget(
                '',
                '',
                myControllerNetWarrantySt,
                myControllerSalesTaxSt,
                Colors.green,
                Image.asset(
                  'images/dollar_icon_green.png',
                  scale: 1.2,
                ),
                Image.asset(
                  'images/percent_icon.png',
                  scale: 1.2,
                ),
              ),
              LabelsWidget(
                  ' Net Loan Protection Cost', '   Expected Interest Rate'),
              TextfieldsWidget(
                '',
                '',
                myControllerNetLoanSt,
                myControllerExpectedIntersetSt,
                Colors.green,
                Image.asset(
                  'images/dollar_icon_green.png',
                  scale: 1.2,
                ),
                Image.asset(
                  'images/percent_icon.png',
                  scale: 1.2,
                ),
              ),
              LabelsWidget(' Trade-in Value', '   Existing Loan Balance'),
              TextfieldsWidget(
                '',
                '',
                myControllerTradeInSt,
                myControllerExistingLoanSt,
                Colors.black,
                Image.asset(
                  'images/dollar_icon.png',
                  scale: 1.2,
                ),
                Image.asset(
                  'images/dollar_icon.png',
                  scale: 1.2,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: screenSize.width * 0.47,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                      child: Text(
                        '     Loan Term (in months)',
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: KHeadLabelsStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              CalculateWidget(context),
            ],
          ),
        );
      }
    }

//    Timer(Duration(seconds: 0), () {
//      print('done');
//      calcFunction();
//    });

    //calcFunction();
    if (firstCalcSt == true) {
      calcFunction();
    }

    if (StdData != null) {
      calcFunction();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: fromHistory == true && historyData.reverseAmount == ''
            ? AppBar(
                backgroundColor: KGreenColor,
                title: Text(
                  myControllerNetVehicleSt.text != ''
                      ? 'Standard Calculation Result'
                      : 'Standard Calculator',
                ),
                leading: backWidget(context),
                actions: <Widget>[
                  myControllerNetVehicleSt.text != '' && fromHistory == false
                      ? GestureDetector(
                          onTap: () {},
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.undo),
                            onPressed: () {
                              resultBoxesList =
                                  _Reset(resultBoxesList, context);
                            },
                          ),
                        )
                      : Container(
                          height: 0.0,
                          width: 0.0,
                        ),
                ],
              )
            : AppBar(
                backgroundColor: KGreenColor,
                title: Text(
                  myControllerNetVehicleSt.text != ''
                      ? 'Standard Calculation Result'
                      : 'Standard Calculator',
                ),
                actions: <Widget>[
                  myControllerNetVehicleSt.text != '' && fromHistory == false
                      ? IconButton(
                          onPressed: () {
                            resultBoxesList = _Reset(resultBoxesList, context);
                          },
                          icon: Icon(FontAwesomeIcons.undo),
                        )
                      : Container(
                          height: 0.0,
                          width: 0.0,
                        ),
                ],
              ),
        resizeToAvoidBottomPadding: false,
        //resizeToAvoidBottomInset: true,
        key: _scaffoldKey,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
//          alignment: WrapAlignment.start,
//          direction: Axis.vertical,

          children: <Widget>[
            advWidget(),
            frequencyWidget(context),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Theme(
                  data: Theme.of(context).copyWith(accentColor: KGreenColor),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 0.0, top: 0.0),
                        //height: 500.0,
                        child: ContentWidget(context),
                      ),
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

  List<Widget> _Reset(List<Widget> resultBoxesList, BuildContext context) {
    print('resett');
    advHeight = 100.0;
    if (StdData != null && fromHistory == false) {
      StdData = null;
    }

    openKeyboard = false;

    setState(() {
      frequencySt = 'All';
      resultHeight = 0.0;
      wa = 0.0;
      cl = 0.0;
      myControllerNetVehicleSt.text = '';
      myControllerDownPaymentSt.text = '';
      myControllerNetWarrantySt.text = '';
      myControllerSalesTaxSt.text = '';
      myControllerNetLoanSt.text = '';
      myControllerExpectedIntersetSt.text = '';
      myControllerTradeInSt.text = '';
      myControllerExistingLoanSt.text = '';
      myControllerLoanTermSt.text = '';
      resultBoxesList = [];
      //advHeight = 100.0;
      myControllerFrequencySt.text = frequencySt;

      if (fromHistory == true) {
        Navigator.pop(context);
      }
    });
    return resultBoxesList;
  }

  void onItemSelected(String color) {
    print(color);
  }
}
