import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pymt_calc/utilities/constants.dart';
import 'package:pymt_calc/utilities/constants.dart' as prefix0;
import 'package:pymt_calc/utilities/header-text.dart';
import 'package:pymt_calc/utilities/resultBoxesWidget.dart';
import 'dart:math';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:pymt_calc/View/reverseView.dart';
import 'package:pymt_calc/main.dart';
import 'dart:async';
import 'package:pymt_calc/Models/History.dart';
import 'package:pymt_calc/utilities/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pymt_calc/Models/oldData.dart';

class reverseMainVieww extends StatefulWidget {
  @override
  _reverseMainViewwState createState() => _reverseMainViewwState();
}

class _reverseMainViewwState extends State<reverseMainVieww> {
  String frequency = '';
  bool firstTimeReverse = true;
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
  bool firstCalc = true;
  DatabaseHelper databaseHelper = DatabaseHelper();

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
      print('donne');
    });
  }

  bool firstTime = false;

  @override
  void dispose() {
    super.dispose();
    //setState(() {});
  }

  @override
  void initState() {
    super.initState();

    print('init reverse');

    frequency = reverseFrequency;
    //myControllerFrequency.text = 'All';

    myControllerFrequencyRv.text = frequency;

    if (reverseResetPressed == true || onceReverse == true) {
      myControllerSalesTaxRv.text = '13';
      myControllerExpectedIntersetRv.text = '5.9';
      myControllerNetWarrantyRv.text = '1999.0';
      myControllerNetLoanRv.text = '1499.0';
      myControllerLoanTermRv.text = '84';
    }

    if (fromHistory == true) {
      myControllerNetVehicleRv.text = historyData.netVehiclePrice;
      myControllerDownPaymentRv.text = historyData.downPayment;
      myControllerNetWarrantyRv.text = historyData.netWarrantyCost;
      myControllerSalesTaxRv.text = historyData.salesTax;
      myControllerNetLoanRv.text = historyData.netLoanCost;
      myControllerExpectedIntersetRv.text = historyData.expectedrate;
      myControllerTradeInRv.text = historyData.tradeInValue;
      myControllerExistingLoanRv.text = historyData.existingLoan;
      myControllerLoanTermRv.text = historyData.loanTerm;
      frequency = historyData.frequency;
      myControllerFrequencyRv.text = frequency;
      firstCalc = false;
      //fromHistory = false;
    } else {
      if (RvsData != null) {
        myControllerNetVehicleRv.text = RvsData.netVehiclePrice;
        myControllerDownPaymentRv.text = RvsData.downPayment;
        myControllerNetWarrantyRv.text = RvsData.netWarrantyCost;
        myControllerSalesTaxRv.text = RvsData.salesTax;
        myControllerNetLoanRv.text = RvsData.netLoanCost;
        myControllerExpectedIntersetRv.text = RvsData.expectedRate;
        myControllerTradeInRv.text = RvsData.tradeInValue;
        myControllerExistingLoanRv.text = RvsData.existingLoan;
        myControllerLoanTermRv.text = RvsData.loanTerm;
        frequency = RvsData.frequency;
        myControllerFrequencyRv.text = frequency;
        //firstCalcSt = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ScrollController scList;
    double resultHeight = 0.0;

    List<Widget> resultBoxesList = [];

    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';

    switch (frequency) {
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

    if (!firstTime) {
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

    _backWidget(BuildContext context) {
      return GestureDetector(
        onTap: () {
          if (fromHistory == false) {
            frequency = '';
            resultHeight = 0.0;
            wa = 0.0;
            cl = 0.0;
            myControllerNetVehicleRv.text = '';
            myControllerDownPaymentRv.text = '';
            myControllerNetWarrantyRv.text = '';
            myControllerSalesTaxRv.text = '';
            myControllerNetLoanRv.text = '';
            myControllerExpectedIntersetRv.text = '';
            myControllerTradeInRv.text = '';
            myControllerExistingLoanRv.text = '';
            myControllerLoanTermRv.text = '';
            resultBoxesList = [];
            //advHeight = 100.0;

            myControllerFrequencyReverse.text = 'Select One';
            myControllerAmountReverse.text = '';

            if (fromHistory == false) {
              fromReverseIntro = false;
              reverseResetPressed = true;
            }
          }

          if (fromHistory == true) {
            Navigator.pop(context);
          } else {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PYMT(),
                ),
              );
            });
          }
        },
        child: Container(
          child: Icon(
            Icons.arrow_back_ios,
            size: 25.0,
          ),
          margin: EdgeInsets.only(top: 0.0, left: 8.0),
        ),
      );
    }

    _reset() {
      if (RvsData != null && fromHistory == false) {
        RvsData = null;
      }

      frequency = '';
      resultHeight = 0.0;
      wa = 0.0;
      cl = 0.0;
      myControllerNetVehicleRv.text = '';
      myControllerDownPaymentRv.text = '';
      myControllerNetWarrantyRv.text = '';
      myControllerSalesTaxRv.text = '';
      myControllerNetLoanRv.text = '';
      myControllerExpectedIntersetRv.text = '';
      myControllerTradeInRv.text = '';
      myControllerExistingLoanRv.text = '';
      myControllerLoanTermRv.text = '';
      resultBoxesList = [];
      //advHeight = 100.0;

      myControllerFrequencyReverse.text = 'Select One';
      myControllerAmountReverse.text = '';
      if (fromHistory == false) {
        fromReverseIntro = false;
        reverseResetPressed = true;
      }

      if (fromHistory == true) {
        Navigator.pop(context);
      } else {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PYMT(),
            ),
          );
        });
      }
    }

    void calcFunction() {
      //reverseFrequency = 'Se'
      //advHeight = 100.0;
      var pm = 0.0;

      print('calc');

      if (frequency == '') {
        frequency = 'All';
      }

//      if (reverseFrequency != '') {
//        frequency = reverseFrequency;
//      }

      if (frequency == 'All') {
        resultHeight = 18.0;
      }

      if (reverseFrequency != '') {
        frequency = reverseFrequency;
      }

      if (fromHistory == true) {
        frequency = historyData.frequency;
      }

      switch (frequency) {
        case 'All':
          if (fromHistory == false) {
            pm = double.parse(reversePaymentAmount);
          } else {
            pm = double.parse(historyData.reverseAmount);
          }

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
          if (fromHistory == false) {
            pm = double.parse(reversePaymentAmount);
          } else {
            pm = double.parse(historyData.reverseAmount);
          }

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
          if (fromHistory == false) {
            pm = double.parse(reversePaymentAmount) * 26.0293 / 12;
          } else {
            pm = double.parse(historyData.reverseAmount) * 26.0293 / 12;
          }

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
          if (fromHistory == false) {
            pm = double.parse(reversePaymentAmount) * 52.083 / 12;
          } else {
            pm = double.parse(historyData.reverseAmount) * 52.083 / 12;
          }

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

      if (myControllerExpectedIntersetRv.text != '') {
        rate = (double.parse(myControllerExpectedIntersetRv.text) / 12) / 100;
      } else {
        rate = (0.000000001 / 12) / 100;
      }

      print('vp = ${myControllerNetVehicleRv.text.replaceAll(',', '')}');
      if (myControllerNetVehicleRv.text.replaceAll(',', '') != '') {
        vp = double.parse(myControllerNetVehicleRv.text.replaceAll(',', ''));
      } else {
        vp = 0.0;
      }

      if (myControllerNetWarrantyRv.text != '') {
        wa = double.parse(myControllerNetWarrantyRv.text);
      } else {
        wa = 0.0;
      }

      if (myControllerNetLoanRv.text != '') {
        cl = double.parse(myControllerNetLoanRv.text);
      } else {
        cl = 0.0;
      }

      if (myControllerTradeInRv.text != '') {
        vt = double.parse(myControllerTradeInRv.text);
      } else {
        vt = 0.0;
      }

      if (myControllerExistingLoanRv.text != '') {
        lb = double.parse(myControllerExistingLoanRv.text);
      } else {
        lb = 0.0;
      }

      if (myControllerDownPaymentRv.text != '') {
        dp = double.parse(myControllerDownPaymentRv.text);
      } else {
        dp = 0.0;
      }

      if (myControllerLoanTermRv.text != '') {
        dl = double.parse(myControllerLoanTermRv.text);
      } else {
        dl = 0.0;
      }

      if (myControllerSalesTaxRv.text != '') {
        tax = double.parse(myControllerSalesTaxRv.text) / 100;
      } else {
        tax = 0.13;
      }

      vp = (((pm * (pow((1 + rate), 84) - 1)) / (rate * pow((1 + rate), 84))));
      vp = ((vp * 100 / 113));
      vp -= wa;
      vp -= cl;

      myControllerNetVehicleRv.text =
          vp.toStringAsFixed(2).replaceAllMapped(reg, mathFunc);

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

      setState(() {});
      print('Total = ${total}');

      if (fromReverseIntro == true && onceReverse == true) {
        if (wa != 0.0 ||
            cl != 0.0 &&
                myControllerNetWarrantyRv.text != '0' &&
                myControllerNetLoanRv.text != '0') {
          print('data = ${myControllerNetVehicleRv.text.replaceAll(',', '')}');
          if (reversePaymentAmount == '') {
            databaseHelper.insertHistory(History(
                'RVS',
                '$wWeekly',
                '$wMonthly',
                '$wBiweekly',
                '${myControllerNetVehicleRv.text.replaceAll(',', '')}',
                '${myControllerDownPaymentRv.text.replaceAll(',', '')}',
                '${myControllerNetWarrantyRv.text.replaceAll(',', '')}',
                '${myControllerSalesTaxRv.text.replaceAll(',', '')}',
                '${myControllerNetLoanRv.text.replaceAll(',', '')}',
                '${myControllerExpectedIntersetRv.text.replaceAll(',', '')}',
                '${myControllerTradeInRv.text.replaceAll(',', '')}',
                '${myControllerExistingLoanRv.text.replaceAll(',', '')}',
                '${myControllerLoanTermRv.text.replaceAll(',', '')}',
                '${myControllerFrequencyRv.text.replaceAll(',', '')}',
                '${total}',
                '${historyData.reverseAmount}',
                '${DateTime.now()}'));
          } else {
            databaseHelper.insertHistory(History(
                'RVS',
                '$wWeekly',
                '$wMonthly',
                '$wBiweekly',
                '${myControllerNetVehicleRv.text.replaceAll(',', '')}',
                '${myControllerDownPaymentRv.text.replaceAll(',', '')}',
                '${myControllerNetWarrantyRv.text.replaceAll(',', '')}',
                '${myControllerSalesTaxRv.text.replaceAll(',', '')}',
                '${myControllerNetLoanRv.text.replaceAll(',', '')}',
                '${myControllerExpectedIntersetRv.text.replaceAll(',', '')}',
                '${myControllerTradeInRv.text.replaceAll(',', '')}',
                '${myControllerExistingLoanRv.text.replaceAll(',', '')}',
                '${myControllerLoanTermRv.text.replaceAll(',', '')}',
                '${myControllerFrequencyRv.text.replaceAll(',', '')}',
                '${total}',
                '${reversePaymentAmount}',
                '${DateTime.now()}'));
          }
        } else {
          if (reversePaymentAmount == '') {
            databaseHelper.insertHistory(History(
                'RVS',
                '$Weekly',
                '$Monthly',
                '$Biweekly',
                '${myControllerNetVehicleRv.text.replaceAll(',', '')}',
                '${myControllerDownPaymentRv.text.replaceAll(',', '')}',
                '${myControllerNetWarrantyRv.text.replaceAll(',', '')}',
                '${myControllerSalesTaxRv.text.replaceAll(',', '')}',
                '${myControllerNetLoanRv.text.replaceAll(',', '')}',
                '${myControllerExpectedIntersetRv.text.replaceAll(',', '')}',
                '${myControllerTradeInRv.text.replaceAll(',', '')}',
                '${myControllerExistingLoanRv.text.replaceAll(',', '')}',
                '${myControllerLoanTermRv.text.replaceAll(',', '')}',
                '${myControllerFrequencyRv.text.replaceAll(',', '')}',
                '${total}',
                '${historyData.reverseAmount}',
                '${DateTime.now()}'));
          } else {
            databaseHelper.insertHistory(History(
                'RVS',
                '$Weekly',
                '$Monthly',
                '$Biweekly',
                '${myControllerNetVehicleRv.text.replaceAll(',', '')}',
                '${myControllerDownPaymentRv.text.replaceAll(',', '')}',
                '${myControllerNetWarrantyRv.text.replaceAll(',', '')}',
                '${myControllerSalesTaxRv.text.replaceAll(',', '')}',
                '${myControllerNetLoanRv.text.replaceAll(',', '')}',
                '${myControllerExpectedIntersetRv.text.replaceAll(',', '')}',
                '${myControllerTradeInRv.text.replaceAll(',', '')}',
                '${myControllerExistingLoanRv.text.replaceAll(',', '')}',
                '${myControllerLoanTermRv.text.replaceAll(',', '')}',
                '${myControllerFrequencyRv.text.replaceAll(',', '')}',
                '${total}',
                '${reversePaymentAmount}',
                '${DateTime.now()}'));
          }
        }

        //fromReverseIntro = false;
        onceReverse = false;
      }
    }

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
                      frequency = picker.getSelectedValues()[0];
                      myControllerFrequencyRv.text = frequency;
                      reverseFrequency = frequency;

                      calcFunction();
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

                  frequency = _;
                  myControllerFrequencyRv.text = frequency;
                  reverseFrequency = frequency;

                  calcFunction();

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
                      onDoubleTap: () =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      child: decideField(context, myControllerFrequencyRv,
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

    if (firstTimeReverse == true) {
      Timer(Duration(seconds: 0), () {
        print('done');
        calcFunction();
      });

      firstTimeReverse = false;
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
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text1');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
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
                // autofocus: true,
                cursorColor: Colors.red,
                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text2');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text2');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
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
                //autofocus: true,
                cursorColor: Colors.red,
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text1');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text1');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
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
                //autofocus: true,
                cursorColor: Colors.red,
                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text2');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text2');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
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
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text1');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
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
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text2');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
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
                // autofocus: true,
                cursorColor: Colors.red,
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                //controller: myControllerUsername,
                textDirection: TextDirection.ltr,
                autocorrect: false,
                //style: KInputTextfieldsStyle,
                onChanged: (text) {
                  print('text1');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text1');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
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
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
                    //calcFunction();
                  }
                },
                onEditingComplete: () {
                  print('text2');
                  if (myControllerNetVehicleRv.text != '' &&
                      myControllerLoanTermRv.text != '') {
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
              controller: myControllerLoanTermRv,
              textInputAction: TextInputAction.next,
              //autofocus: true,
              cursorColor: Colors.red,
              //controller: myControllerUsername,
              textDirection: TextDirection.ltr,
              autocorrect: false,
              //style: KInputTextfieldsStyle,
              onChanged: (text) {
                print('text1');
                if (myControllerNetVehicleRv.text != '' &&
                    myControllerLoanTermRv.text != '') {
                  //calcFunction();
                }
              },
              onEditingComplete: () {
                print('text1');
                if (myControllerNetVehicleRv.text != '' &&
                    myControllerLoanTermRv.text != '') {
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
                hintText: 'Months',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 24.0),
            height: 38.0,
            width: screenSize.width * 0.435,
            child: GestureDetector(
              onTap: () {
                print('pressed');
                FocusScope.of(context).requestFocus(FocusNode());
                advHeight = 0.0;

                if (fromHistory == false) {
                  RvsData = oldData(
                      netVehiclePrice: myControllerNetVehicleRv.text,
                      downPayment: myControllerDownPaymentRv.text,
                      netWarrantyCost: myControllerNetWarrantyRv.text,
                      salesTax: myControllerSalesTaxRv.text,
                      netLoanCost: myControllerNetLoanRv.text,
                      expectedRate: myControllerExpectedIntersetRv.text,
                      tradeInValue: myControllerTradeInRv.text,
                      existingLoan: myControllerExistingLoanRv.text,
                      loanTerm: myControllerLoanTermRv.text,
                      frequency: frequency);
                }

                if (wa != 0.0 ||
                    cl != 0.0 &&
                        myControllerNetWarrantyRv.text != '0' &&
                        myControllerNetLoanRv.text != '0') {
                  print(
                      'data = ${myControllerNetVehicleRv.text.replaceAll(',', '')}');
                  if (reversePaymentAmount == '') {
                    databaseHelper.insertHistory(History(
                        'RVS',
                        '$wWeekly',
                        '$wMonthly',
                        '$wBiweekly',
                        '${myControllerNetVehicleRv.text.replaceAll(',', '')}',
                        '${myControllerDownPaymentRv.text.replaceAll(',', '')}',
                        '${myControllerNetWarrantyRv.text.replaceAll(',', '')}',
                        '${myControllerSalesTaxRv.text.replaceAll(',', '')}',
                        '${myControllerNetLoanRv.text.replaceAll(',', '')}',
                        '${myControllerExpectedIntersetRv.text.replaceAll(',', '')}',
                        '${myControllerTradeInRv.text.replaceAll(',', '')}',
                        '${myControllerExistingLoanRv.text.replaceAll(',', '')}',
                        '${myControllerLoanTermRv.text.replaceAll(',', '')}',
                        '${myControllerFrequencyRv.text.replaceAll(',', '')}',
                        '${total}',
                        '${historyData.reverseAmount}',
                        '${DateTime.now()}'));
                  } else {
                    databaseHelper.insertHistory(History(
                        'RVS',
                        '$wWeekly',
                        '$wMonthly',
                        '$wBiweekly',
                        '${myControllerNetVehicleRv.text.replaceAll(',', '')}',
                        '${myControllerDownPaymentRv.text.replaceAll(',', '')}',
                        '${myControllerNetWarrantyRv.text.replaceAll(',', '')}',
                        '${myControllerSalesTaxRv.text.replaceAll(',', '')}',
                        '${myControllerNetLoanRv.text.replaceAll(',', '')}',
                        '${myControllerExpectedIntersetRv.text.replaceAll(',', '')}',
                        '${myControllerTradeInRv.text.replaceAll(',', '')}',
                        '${myControllerExistingLoanRv.text.replaceAll(',', '')}',
                        '${myControllerLoanTermRv.text.replaceAll(',', '')}',
                        '${myControllerFrequencyRv.text.replaceAll(',', '')}',
                        '${total}',
                        '${reversePaymentAmount}',
                        '${DateTime.now()}'));
                  }
                } else {
                  if (reversePaymentAmount == '') {
                    databaseHelper.insertHistory(History(
                        'RVS',
                        '$Weekly',
                        '$Monthly',
                        '$Biweekly',
                        '${myControllerNetVehicleRv.text.replaceAll(',', '')}',
                        '${myControllerDownPaymentRv.text.replaceAll(',', '')}',
                        '${myControllerNetWarrantyRv.text.replaceAll(',', '')}',
                        '${myControllerSalesTaxRv.text.replaceAll(',', '')}',
                        '${myControllerNetLoanRv.text.replaceAll(',', '')}',
                        '${myControllerExpectedIntersetRv.text.replaceAll(',', '')}',
                        '${myControllerTradeInRv.text.replaceAll(',', '')}',
                        '${myControllerExistingLoanRv.text.replaceAll(',', '')}',
                        '${myControllerLoanTermRv.text.replaceAll(',', '')}',
                        '${myControllerFrequencyRv.text.replaceAll(',', '')}',
                        '${total}',
                        '${historyData.reverseAmount}',
                        '${DateTime.now()}'));
                  } else {
                    databaseHelper.insertHistory(History(
                        'RVS',
                        '$Weekly',
                        '$Monthly',
                        '$Biweekly',
                        '${myControllerNetVehicleRv.text.replaceAll(',', '')}',
                        '${myControllerDownPaymentRv.text.replaceAll(',', '')}',
                        '${myControllerNetWarrantyRv.text.replaceAll(',', '')}',
                        '${myControllerSalesTaxRv.text.replaceAll(',', '')}',
                        '${myControllerNetLoanRv.text.replaceAll(',', '')}',
                        '${myControllerExpectedIntersetRv.text.replaceAll(',', '')}',
                        '${myControllerTradeInRv.text.replaceAll(',', '')}',
                        '${myControllerExistingLoanRv.text.replaceAll(',', '')}',
                        '${myControllerLoanTermRv.text.replaceAll(',', '')}',
                        '${myControllerFrequencyRv.text.replaceAll(',', '')}',
                        '${total}',
                        '${reversePaymentAmount}',
                        '${DateTime.now()}'));
                  }
                }

                calcFunction();
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

      if (frequency != '') {
        resultHeight = 18.0;
      } else {
        resultHeight = 0.0;
        resultBoxesList = [];
      }

      print('height = ${resultHeight} list = ${resultBoxesList}');

      if (wa != 0.0 || cl != 0.0) {
        return Container(
//          height: 1400.0,
          //height: 1200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: resultHeight,
                margin: EdgeInsets.only(
                    top: screenSize.height * topConstraint, left: 0.0),
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
                'Net Vehicle Price',
                'Your Down Payment',
                myControllerNetVehicleRv,
                myControllerDownPaymentRv,
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
              LabelsWidget(' Net Warranty Plan Cost', '   Sales Tax *'),
              TextfieldsWidget(
                'Net Warranty Plan Cost',
                'Sales Tax',
                myControllerNetWarrantyRv,
                myControllerSalesTaxRv,
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
                  ' Net Loan Protection Cost', '   Expected Interest Rate *'),
              TextfieldsWidget(
                'Net Loan Protection Cost',
                'Expected Interest Rate',
                myControllerNetLoanRv,
                myControllerExpectedIntersetRv,
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
                'Trade-in Value',
                'Existing Vehicle Loan Balance',
                myControllerTradeInRv,
                myControllerExistingLoanRv,
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
//          height: 1400.0,
          //height: 1200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: resultHeight,
                margin: EdgeInsets.only(
                    top: screenSize.height * topConstraint, left: 14.0),
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
                'Net Vehicle Price',
                'Your Down Payment',
                myControllerNetVehicleRv,
                myControllerDownPaymentRv,
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
              LabelsWidget(' Net Warranty Plan Cost', '   Sales Tax *'),
              TextfieldsWidget(
                'Net Warranty Plan Cost',
                'Sales Tax',
                myControllerNetWarrantyRv,
                myControllerSalesTaxRv,
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
                  ' Net Loan Protection Cost', '   Expected Interest Rate *'),
              TextfieldsWidget(
                'Net Loan Protection Cost',
                'Expected Interest Rate',
                myControllerNetLoanRv,
                myControllerExpectedIntersetRv,
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
                'Trade-in Value',
                'Existing Vehicle Loan Balance',
                myControllerTradeInRv,
                myControllerExistingLoanRv,
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
                        '      Loan Term (in months)*',
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
      }
    }

    calcFunction();

    Widget mainBodyWidget(BuildContext context) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
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
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 0.0, top: 0.0),
                      //height: 500.0,
                      child: ContentWidget(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        //mainAxisAlignment: MainAxisAlignment.center,
//          alignment: WrapAlignment.start,
//          direction: Axis.vertical,
      );
    }

    if (reversePaymentAmount != '') {
      return new Material(
        //debugShowCheckedModeBanner: false,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          //resizeToAvoidBottomPadding: false,
          //resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: KGreenColor,
            title: Text('Reverse Calculation Result'),
            leading: _backWidget(context),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  _reset();
                },
                icon: Icon(FontAwesomeIcons.undo),
              ),
            ],
          ),
          key: _scaffoldKey,

          body: mainBodyWidget(context),
        ),
      );
    } else {
      return new Material(
        //debugShowCheckedModeBanner: false,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: KGreenColor,
              title: Text('Reverse Calculation Result'),
              leading: _backWidget(context),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    _reset();
                  },
                  icon: Icon(FontAwesomeIcons.undo),
                ),
              ]),
          resizeToAvoidBottomPadding: false,
          //resizeToAvoidBottomInset: true,
          key: _scaffoldKey,

          body: mainBodyWidget(context),
        ),
      );
    }
  }
}
