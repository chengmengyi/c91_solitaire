class CashTaskBean {
  CashTaskBean({
    this.cashType,
    this.amount,
    this.account,
    this.cashTask,
    this.currentPro,
    this.totalPro,
    this.cashTaskIndex,
  });

  CashTaskBean.fromJson(dynamic json) {
    cashType = json['cashType'];
    amount = json['amount'];
    account = json['account'];
    cashTask = json['cashTask'];
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
    cashTaskIndex = json['cashTaskIndex'];
  }
  int? cashType;
  int? amount;
  String? account;
  String? cashTask;
  int? currentPro;
  int? totalPro;
  int? cashTaskIndex;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashType'] = cashType;
    map['amount'] = amount;
    map['account'] = account;
    map['cashTask'] = cashTask;
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    map['cashTaskIndex'] = cashTaskIndex;
    return map;
  }

  @override
  String toString() {
    return 'CashTaskBean{cashType: $cashType, amount: $amount, account: $account, cashTask: $cashTask, currentPro: $currentPro, totalPro: $totalPro, cashTaskIndex: $cashTaskIndex}';
  }
}