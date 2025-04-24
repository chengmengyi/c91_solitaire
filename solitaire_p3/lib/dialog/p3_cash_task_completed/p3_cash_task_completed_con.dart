import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/bean/cash_task_bean.dart';
import 'package:solitaire_p3/hep/cash/cash_task_hep.dart';

class P3CashTaskCompletedCon extends P1BaseCon{

  clickSure(CashTaskBean bean)async{
    await CashTaskHep.instance.deleteCashTaskByByCashTypeAmount(cashType: bean.cashType??0, amount: bean.amount??0);
    P1EventBean(code: P3EventCode.updateCashList).send();
    P1RouterFun.closePage();
  }
}