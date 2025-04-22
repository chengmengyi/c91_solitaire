import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';

class P1BaseCon extends GetxController{
  late BuildContext context;
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    if(registerP1Event()){
      _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
        onListenP1Event(bean);
      });
    }
  }

  bool registerP1Event()=>false;

  onListenP1Event(P1EventBean bean){}

  @override
  void onClose() {
    if(registerP1Event()){
      _streamSubscription?.cancel();
      _streamSubscription=null;
    }
    super.onClose();
  }
}