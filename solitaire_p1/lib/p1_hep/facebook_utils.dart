import 'dart:convert';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter_custom_facebook/flutter_custom_facebook.dart';
import 'package:solitaire_p1/p1_hep/firebase_hep.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';

class FacebookUtils{
  static final FacebookUtils _facebookUtils=FacebookUtils();
  static FacebookUtils get instance => _facebookUtils;

  initFacebook(){
    try{
      var data = p3FacebookConfig.getData();
      if(data.isEmpty){
        data=facebookLocalConfig.base64();
      }

      var json = jsonDecode(data);
      FlutterCustomFacebook.instance.initFaceBook(
        facebookId: json["app_id"],
        facebookToken: json["client_token"],
        facebookAppName: json["app_name"],
      );
    }catch(e){
      print("kk===initFacebook error==${e}");
    }
  }

  logPurchase(MaxAd? ad){
    FlutterCustomFacebook.instance.logPurchase(amount: ad?.revenue??0, currency: "USD");
  }
}