import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pymt_calc/utilities/constants.dart';
import 'dart:async';
import 'package:pymt_calc/Models/History.dart';
import 'package:pymt_calc/utilities/database_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pymt_calc/View/standardView.dart';
import 'package:pymt_calc/View/reverseMainView.dart';

class historyVieww extends StatefulWidget {
  @override
  _historyViewwState createState() => _historyViewwState();
}

class _historyViewwState extends State<historyVieww> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<History> historyList;
  int count = 0;

  void loadAdvs() async {
    await doAdvThings(advertiseUrl);
    setState(() {
      advHeight = 100.0;
    });
  }

  void _showSnackBar(BuildContext context, String message) async {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      backgroundColor: KGreenColor,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListview() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    dbFuture.then((database) {
      Future<List<History>> historyListFuture = databaseHelper.getHistoryList();

      historyListFuture.then((historyList) {
        for (var item in historyList) {
          print('type1 = ${item.type}');
        }
        historyList.sort(
            (a, b) => DateTime.parse(b.time).compareTo(DateTime.parse(a.time)));
        this.historyList = historyList;

        this.count = historyList.length;
        //this.historyList.reversed;

        //this.historyList;

        print('count = $count');
        for (var item in historyList) {
          print('history = ${item.type}');
        }
        setState(() {});
      });
    });
  }

  void _delete(BuildContext context, History history) async {
    int result = await databaseHelper.deleteHistory(
        history.type,
        history.weekly,
        history.netVehiclePrice,
        history.downPayment,
        history.netWarrantyCost,
        history.salesTax,
        history.netLoanCost,
        history.expectedrate,
        history.tradeInValue,
        history.existingLoan,
        history.loanTerm,
        history.frequency,
        history.total,
        history.reverseAmount,
        history.time);

    historyList.remove(history);
    if (result != 0) {
      _showSnackBar(context, 'Record Deleted Successfully');

      updateListview();
    }
  }

  void showDeleteAllAlert() async {
    final bool res = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure to delete all records?"),
          actions: <Widget>[
            Card(
              elevation: 4.0,
              color: Colors.green,
              child: DialogButton(
                width: 60.0,
                color: Colors.green,
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("CANCEL",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
            Card(
              elevation: 4.0,
              color: Colors.red,
              child: DialogButton(
                  width: 60.0,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    databaseHelper.clearTable();
                    updateListview();
                  },
                  child: const Text(
                    "DELETE",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
            ),
          ],
        );
      },
    );
  }

  Color historyColor(String warrantyCost, String netLoanCost) {
    if (warrantyCost == '') warrantyCost = '0';
    if (netLoanCost == '') netLoanCost = '0';
    print('netw = ${warrantyCost ?? '0'} netLoan = $netLoanCost');
    double wc = double.parse(warrantyCost);
    double nc = double.parse(netLoanCost);
    if (wc == 0.0 && nc == 0.0) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  @override
  void initState() {
    loadAdvs();
    super.initState();

    updateListview();
  }

  @override
  void dispose() {
    super.dispose();

    //fromHistory = false;
  }

  @override
  Widget build(BuildContext context) {
    if (historyList == null) {
      historyList = List<History>();
      updateListview();
    }

    Size screenSize = MediaQuery.of(context).size;

    Future<bool> confDismiss(int Index) async {
      this.historyList.removeAt(Index);

      return true;
    }

    _deleteRecordWidget(BuildContext context, int index) {}

    Widget MainWidget() {
      return Expanded(
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: KGreenColor),
          child: historyList.length > 0
              ? ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 0.0, left: 8.0, right: 8.0, bottom: 8.0),
                  physics: ClampingScrollPhysics(),
                  itemCount: historyList.length,
                  //reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(historyList[index].time),
                      confirmDismiss: (DismissDirection direction) async {
                        final bool res = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm"),
                              content: const Text(
                                  "Are you sure you wish to delete this Record?"),
                              actions: <Widget>[
                                Card(
                                  elevation: 4.0,
                                  color: Colors.green,
                                  child: DialogButton(
                                    width: 60.0,
                                    color: Colors.green,
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                Card(
                                  elevation: 4.0,
                                  color: Colors.red,
                                  child: DialogButton(
                                      width: 60.0,
                                      color: Colors.red,
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                        _delete(context, historyList[index]);
                                        updateListview();
                                        historyList.removeAt(index);
                                      },
                                      child: const Text(
                                        "DELETE",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) {
//                setState(() {});
//                _showSnackBar(context, 'Record Deleted Successfully');
                      },
                      child: GestureDetector(
                        onTap: () {
                          fromHistory = true;
                          historyData = historyList[index];
                          if (historyList[index].type == 'STD') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => standardVieww(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => reverseMainVieww(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 8.0),
                          height: 100.0,
                          child: Card(
                            elevation: 8.0,
                            color: Colors.white,
                            child: Stack(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
                              alignment: Alignment.topLeft,
                              children: <Widget>[
                                Container(
                                  width: screenSize.width * 0.065,
                                  height: double.infinity,
                                  decoration: new BoxDecoration(
                                      color: historyColor(
                                          historyList[index].netWarrantyCost,
                                          historyList[index]
                                              .netLoanCost), //new Color.fromRGBO(255, 0, 0, 0.0),
                                      borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(4.0),
                                          bottomLeft:
                                              const Radius.circular(4.0))),
                                  child: Center(
                                      child: RotatedBox(
                                    quarterTurns: -1,
                                    child: Text(
                                      '${historyList[index].type == 'RVS' ? 'REVERSE' : 'STANDARD'}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ),
                                Positioned(
                                  left: 30.0,
                                  top: 8.0,
                                  child: Text(
                                    '${DateTime.parse(historyList[index].time).year}-${DateTime.parse(historyList[index].time).month}-${DateTime.parse(historyList[index].time).day} | ${DateTime.parse(historyList[index].time).hour}:${DateTime.parse(historyList[index].time).minute} ${switchAm(DateTime.parse(historyList[index].time).hour.toString())}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Positioned(
                                  left: 30.0,
                                  top: 35.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(0.0),
                                        width: screenSize.width * 0.4175,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent

                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    textBaseline: TextBaseline
                                                        .ideographic),
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text: 'Vehicle Price:'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: new TextSpan(
                                                    // Note: Styles for TextSpans must be explicitly defined.
                                                    // Child text spans will inherit styles from parent

                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                        textBaseline:
                                                            TextBaseline
                                                                .ideographic),
                                                    children: <TextSpan>[
                                                      new TextSpan(
                                                        text:
                                                            ' \$${double.parse(historyList[index].netVehiclePrice).toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 0.0,
                                  top: 35.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(0.0),
                                        width: screenSize.width * 0.45,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent

                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    textBaseline: TextBaseline
                                                        .ideographic),
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text: 'Total Financed:'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: new TextSpan(
                                                    // Note: Styles for TextSpans must be explicitly defined.
                                                    // Child text spans will inherit styles from parent

                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        textBaseline:
                                                            TextBaseline
                                                                .ideographic),
                                                    children: <TextSpan>[
                                                      new TextSpan(
                                                        text:
                                                            ' \$${double.parse(historyList[index].total).toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 30.0,
                                  bottom: 12,
                                  width: screenSize.width * 0.28,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(0.0),
                                        width: screenSize.width * 0.28,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent

                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                    textBaseline: TextBaseline
                                                        .ideographic),
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text: 'Monthly:'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: new TextSpan(
                                                    // Note: Styles for TextSpans must be explicitly defined.
                                                    // Child text spans will inherit styles from parent

                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        textBaseline:
                                                            TextBaseline
                                                                .ideographic),
                                                    children: <TextSpan>[
                                                      new TextSpan(
                                                        text:
                                                            ' \$${double.parse(historyList[index].monthly).toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: historyColor(
                                                              historyList[index]
                                                                  .netWarrantyCost,
                                                              historyList[index]
                                                                  .netLoanCost),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  width: screenSize.width * 0.28,
                                  left: screenSize.width * 0.38,
                                  bottom: 12,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(0.0),
                                        width: screenSize.width * 0.28,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent

                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                    textBaseline: TextBaseline
                                                        .ideographic),
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                      text: 'Bi-Weekly:'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: new TextSpan(
                                                    // Note: Styles for TextSpans must be explicitly defined.
                                                    // Child text spans will inherit styles from parent

                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        textBaseline:
                                                            TextBaseline
                                                                .ideographic),
                                                    children: <TextSpan>[
                                                      new TextSpan(
                                                        text:
                                                            ' \$${double.parse(historyList[index].biweekly).toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: historyColor(
                                                              historyList[index]
                                                                  .netWarrantyCost,
                                                              historyList[index]
                                                                  .netLoanCost),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: screenSize.width * 0.68,
                                  width: screenSize.width * 0.27,
                                  bottom: 12,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(0.0),
                                        width: screenSize.width * 0.27,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              text: new TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent

                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                    textBaseline: TextBaseline
                                                        .ideographic),
                                                children: <TextSpan>[
                                                  new TextSpan(text: 'Weekly:'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: RichText(
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: new TextSpan(
                                                    // Note: Styles for TextSpans must be explicitly defined.
                                                    // Child text spans will inherit styles from parent

                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        textBaseline:
                                                            TextBaseline
                                                                .ideographic),
                                                    children: <TextSpan>[
                                                      new TextSpan(
                                                        text:
                                                            ' \$${double.parse(historyList[index].weekly).toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: historyColor(
                                                              historyList[index]
                                                                  .netWarrantyCost,
                                                              historyList[index]
                                                                  .netLoanCost),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'There is no calculation in your history.',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                  ),
                ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: KGreenColor,
          title: Text('Calculation History'),
          actions: <Widget>[
            historyList.length > 0
                ? IconButton(
                    onPressed: () {
                      showDeleteAllAlert();
                    },
                    icon: Icon(FontAwesomeIcons.trash),
                  )
                : Container(
                    height: 0.0,
                  )
          ],
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            advWidget(),
            MainWidget(),
          ],
        ),
      ),
    );
  }
}
