import 'dart:convert';

import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';

class P1AD{
  static final P1AD _instance = P1AD();
  static P1AD get instance => _instance;

  initAdInfo(){
    try{
      var json = jsonDecode(adStr.base64());
      var data = ConfigAdData(
        maxShowNum: json["wbpryjrf"],
        maxClickNum: json["gelxuwdg"],
        oneRewardList: _getAdList(json["vvslt_arv_one"]),
        oneInterList: [],
        twoRewardList: [],
        twoInterList: [],
      );
      FlutterIosAdHep.instance.initMax(maxKey: maxKey.base64(), data: data);
    }catch(e){
    }
  }

  List<AdInfoData> _getAdList(List list){
    List<AdInfoData> resultList=[];
    for (var value in list) {
      resultList.add(
          AdInfoData(
            adId: value["idirgkyd"],
            adPlat: value["lurwymeq"],
            adType: value["ehpdicim"]=="reward"?AdType.reward:AdType.interstitial,
            expireTime: value["guxxklrg"],
            sort: value["lugbfdap"],
          )
      );
    }
    return resultList;
  }

  showAd({
    required Function() closeAd,
}){
    var hasCache = FlutterIosAdHep.instance.getCacheResultData(AdType.reward);
    if(null==hasCache){
      showToast("Ad loading failed, please try again later");
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: AdType.reward,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){},
        showFail: (ad){},
        closeAd: (){
          closeAd.call();
        },
        onAdRevenuePaidCallback: (ad,info){},
      ),
    );
  }
}