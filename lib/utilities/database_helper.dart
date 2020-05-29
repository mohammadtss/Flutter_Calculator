import 'dart:async' as prefix0;

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pymt_calc/Models/History.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String historyTable = 'history_table';
  String colType = 'type';
  String colWeekly = 'weekly';
  String colMonthly = 'monthly';
  String colBiWeekly = 'biweekly';
  String colNetVehiclePrice = 'netVehiclePrice';
  String colDownPayment = 'downPayment';
  String colWarrantyCost = 'warrantyCost';
  String colSalesTax = 'salesTax';
  String colNetLoanCost = 'netLoanCost';
  String colExpectedrate = 'expectedrate';
  String colTradeInValue = 'tradeInValue';
  String colExistingLoan = 'existingLoan';
  String colLoanTerm = 'loanTerm';
  String colFrequency = 'frequency';
  String colTotal = 'total';
  String colAmount = 'amount';
  String colTime = 'time';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = directory.path + 'history_pymt.db';

    var historyDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return historyDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $historyTable($colType TEXT, $colWeekly TEXT, $colMonthly TEXT, $colBiWeekly TEXT, $colNetVehiclePrice TEXT, '
        '$colDownPayment TEXT, $colWarrantyCost TEXT, $colSalesTax TEXT, $colNetLoanCost TEXT, $colExpectedrate TEXT ,'
        '$colTradeInValue TEXT, $colExistingLoan TEXT, $colLoanTerm TEXT, $colFrequency TEXT, $colTotal TEXT, $colAmount TEXT, $colTime TEXT)');
  }

  Future<List<Map<String, dynamic>>> getHistoryMapList() async {
    Database db = await this.database;

    //var result = await db.rawQuery('SELECT * FROM $historyTable');
    var result = await db.query(historyTable);

    return result;
  }

  Future<int> insertHistory(History history) async {
    Database db = await this.database;

    var result = await db.insert(historyTable, history.toMap());

    return result;
  }

//  Future<int> updateHistory(History history) async {
//    Database db = await this.database;
//
//    var result = await db.update(historyTable, history.toMap(), where: );
//
//    return result;
//  }

  Future<int> deleteHistory(
      String type,
      String weekly,
      String netVehiclePrice,
      String downpayment,
      String netWarrantyCost,
      String salesTax,
      String netLoan,
      String expectedRate,
      String tradeIn,
      String existingLoan,
      String loanTerm,
      String frequency,
      String total,
      String amount,
      String time) async {
    var db = await this.database;

    print('www = $weekly');

//    int result = await db
//        .rawDelete('DELETE FROM $historyTable WHERE $colWeekly = $weekly');
    int result = await db.delete(historyTable,
        where:
            '$colWeekly = ? AND $colType = ? AND $colNetVehiclePrice = ? AND $colDownPayment = ? AND $colWarrantyCost = ? AND $colSalesTax = ? AND $colNetLoanCost = ? AND $colExpectedrate = ? AND $colTradeInValue = ? AND $colExistingLoan = ? AND $colLoanTerm = ? AND $colFrequency = ? AND $colTotal = ? AND $colAmount = ? AND $colTime = ?',
        whereArgs: [
          weekly,
          type,
          netVehiclePrice,
          downpayment,
          netWarrantyCost,
          salesTax,
          netLoan,
          expectedRate,
          tradeIn,
          existingLoan,
          loanTerm,
          frequency,
          total,
          amount,
          time
        ]);

    return result;
  }

  Future<bool> clearTable() async {
    var db = await this.database;

    await db.rawQuery('DELETE  FROM $historyTable');

    return true;
  }

  Future<int> getCount() async {
    Database db = await this.database;

    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $historyTable');

    int result = Sqflite.firstIntValue(x);

    return result;
  }

  Future<List<History>> getHistoryList() async {
    var historyMapList = await getHistoryMapList();
    int count = historyMapList.length;

    List<History> historyList = List<History>();

    for (int i = 0; i < count; i++) {
      historyList.add(History.fromMapObject(historyMapList[i]));
    }

    return historyList;
  }
}
