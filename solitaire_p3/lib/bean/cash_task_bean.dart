class CashTaskBean {
  CashTaskBean({
      this.cashType, 
      this.amount, 
      this.account, 
      this.cashTask, 
      this.currentPro, 
      this.totalPro,});

  CashTaskBean.fromJson(dynamic json) {
    cashType = json['cashType'];
    amount = json['amount'];
    account = json['account'];
    cashTask = json['cashTask'];
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
  }
  int? cashType;
  int? amount;
  String? account;
  String? cashTask;
  int? currentPro;
  int? totalPro;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashType'] = cashType;
    map['amount'] = amount;
    map['account'] = account;
    map['cashTask'] = cashTask;
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    return map;
  }

}