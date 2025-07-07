class RankTaskBean {
  RankTaskBean({
    this.cashType,
    this.amount,
    this.account,
    this.currentPro,
    this.totalPro,
  });

  RankTaskBean.fromJson(dynamic json) {
    cashType = json['cashType'];
    amount = json['amount'];
    account = json['account'];
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
  }
  int? cashType;
  int? amount;
  String? account;
  int? currentPro;
  int? totalPro;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashType'] = cashType;
    map['amount'] = amount;
    map['account'] = account;
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    return map;
  }
}