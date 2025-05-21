import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';

class FirebaseHep{
  static final FirebaseHep _instance = FirebaseHep();
  static FirebaseHep get instance => _instance;

  FirebaseRemoteConfig? _config;

  Function(String s)? valueCallback;

  initFirebase()async{
    try{
      _config=FirebaseRemoteConfig.instance;
      await _config?.setConfigSettings(
        RemoteConfigSettings(
            fetchTimeout:  const Duration(seconds: 10),
            minimumFetchInterval: const Duration(seconds: 1)
        ),
      );
      await _config?.fetchAndActivate();
      _getString();
    }catch(e){
      await Future.delayed(const Duration(milliseconds: 2000),);
      initFirebase();
    }
  }

  _getString(){
    var s = _config?.getString("us_numbers")??"";
    if(s.isNotEmpty){
      valueCallback?.call(s);
    }
    var ad = _config?.getString("vvslt_ad_config")??"";
    if(ad.isNotEmpty){
      p3AdConfig.saveData(ad);
      P1AD.instance.setAdInfo();
    }
  }
}