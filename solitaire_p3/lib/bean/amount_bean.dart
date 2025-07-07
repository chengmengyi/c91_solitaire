import 'package:solitaire_p3/bean/cash_task_bean.dart';
import 'package:solitaire_p3/bean/rank_task_bean.dart';

class AmountBean{
  int money;
  CashTaskBean? cashTaskBean;
  RankTaskBean? rankTaskBean;
  AmountBean({
    required this.money,
    required this.cashTaskBean,
    required this.rankTaskBean,
});
}