class CashTaskBean {
  CashTaskBean({
    this.cashType,
    this.amount,
    this.account,
    this.cashTask,
    this.currentPro,
    this.totalPro,
    this.currentPro2,
    this.totalPro2,
  });

  CashTaskBean.fromJson(dynamic json) {
    cashType = json['cashType'];
    amount = json['amount'];
    account = json['account'];
    cashTask = json['cashTask'];
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
    currentPro2 = json['currentPro2'];
    totalPro2 = json['totalPro2'];
  }
  int? cashType;
  int? amount;
  String? account;
  String? cashTask;
  int? currentPro;
  int? totalPro;
  int? currentPro2;
  int? totalPro2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashType'] = cashType;
    map['amount'] = amount;
    map['account'] = account;
    map['cashTask'] = cashTask;
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    map['currentPro2'] = currentPro2;
    map['totalPro2'] = totalPro2;
    return map;
  }

}