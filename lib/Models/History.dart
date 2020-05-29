class History {
  String _type;
  String _Weekly;
  String _Monthly;
  String _Biweekly;
  String _netVehiclePrice;
  String _downPayment;
  String _netWarrantyCost;
  String _salesTax;
  String _netLoanCost;
  String _expectedRate;
  String _tradeInValue;
  String _existingLoan;
  String _loanTerm;
  String _total;
  String _frequency;
  String _reverseAmount;
  String _time;

  History(
    this._type,
    this._Weekly,
    this._Monthly,
    this._Biweekly,
    this._netVehiclePrice,
    this._downPayment,
    this._netWarrantyCost,
    this._salesTax,
    this._netLoanCost,
    this._expectedRate,
    this._tradeInValue,
    this._existingLoan,
    this._loanTerm,
    this._frequency,
    this._total,
    this._reverseAmount,
    this._time,
  );

  String get type => _type;
  String get weekly => _Weekly;
  String get monthly => _Monthly;
  String get biweekly => _Biweekly;
  String get netVehiclePrice => _netVehiclePrice;
  String get downPayment => _downPayment;
  String get netWarrantyCost => _netWarrantyCost;
  String get salesTax => _salesTax;
  String get netLoanCost => _netLoanCost;
  String get expectedrate => _expectedRate;
  String get tradeInValue => _tradeInValue;
  String get existingLoan => _existingLoan;
  String get loanTerm => _loanTerm;
  String get frequency => _frequency;
  String get total => _total;
  String get reverseAmount => _reverseAmount;
  String get time => _time;

  set type(String newType) {
    this._type = newType;
  }

  set weekly(String newWeekly) {
    this._Weekly = newWeekly;
  }

  set monthly(String newMonthly) {
    this._Monthly = newMonthly;
  }

  set biweekly(String newBiweekly) {
    this._Biweekly = newBiweekly;
  }

  set netVehiclePrice(String newVehiclePrice) {
    this._netVehiclePrice = newVehiclePrice;
  }

  set downPayment(String newDownPayment) {
    this._downPayment = newDownPayment;
  }

  set netWarrantyCost(String newWarrantyCost) {
    this._netWarrantyCost = newWarrantyCost;
  }

  set salesTax(String newSalesTax) {
    this._salesTax = newSalesTax;
  }

  set netLoanCost(String newLoanCost) {
    this._netLoanCost = newLoanCost;
  }

  set expectedRate(String newExpectedRate) {
    this._expectedRate = newExpectedRate;
  }

  set tradeInValue(String newTradeInValue) {
    this._tradeInValue = newTradeInValue;
  }

  set existingLoan(String newExistingLoan) {
    this._existingLoan = newExistingLoan;
  }

  set loanTerm(String newLoanTerm) {
    this._loanTerm = newLoanTerm;
  }

  set frequency(String newFrequency) {
    this._frequency = newFrequency;
  }

  set total(String newTotal) {
    this._total = newTotal;
  }

  set reverseAmount(String newAmount) {
    this._reverseAmount = newAmount;
  }

  set time(String newTime) {
    this._time = newTime;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['type'] = _type;
    map['weekly'] = _Weekly;
    map['monthly'] = _Monthly;
    map['biweekly'] = _Biweekly;
    map['netVehiclePrice'] = _netVehiclePrice;
    map['downPayment'] = _downPayment;
    map['warrantyCost'] = _netWarrantyCost;
    map['salesTax'] = _salesTax;
    map['netLoanCost'] = _netLoanCost;
    map['expectedrate'] = _expectedRate;
    map['tradeInValue'] = _tradeInValue;
    map['existingLoan'] = _existingLoan;
    map['loanTerm'] = _loanTerm;
    map['frequency'] = _frequency;
    map['total'] = _total;
    map['amount'] = _reverseAmount;
    map['time'] = _time;

    return map;
  }

  History.fromMapObject(Map<String, dynamic> map) {
    this._type = map['type'];
    this._Weekly = map['weekly'];
    this._Monthly = map['monthly'];
    this._Biweekly = map['biweekly'];
    this._netVehiclePrice = map['netVehiclePrice'];
    this._downPayment = map['downPayment'];
    this._netWarrantyCost = map['warrantyCost'];
    this._salesTax = map['salesTax'];
    this._netLoanCost = map['netLoanCost'];
    this._expectedRate = map['expectedrate'];
    this._tradeInValue = map['tradeInValue'];
    this._existingLoan = map['existingLoan'];
    this._loanTerm = map['loanTerm'];
    this._frequency = map['frequency'];
    this._total = map['total'];
    this._reverseAmount = map['amount'];
    this._time = map['time'];
  }
}
