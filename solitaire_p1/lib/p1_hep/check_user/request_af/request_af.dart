import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';
import 'package:solitaire_p1/p1_hep/check_user/flutter_check_af.dart';
import 'package:solitaire_p1/p1_hep/check_user/request_af/request_af_callback.dart';

StorageData<String> p2AfResult=StorageData<String>(key: "check_af_result_key", defaultValue: "");


class RequestAf{
  String afKey;
  String afAppId;
  String distinctId;
  RequestAfCallback requestAfCallback;

  AppsflyerSdk? _appsflyerSdk;
  Function()? aPackageAfCall;

  bool afIsB=false;

  RequestAf({
    required this.afKey,
    required this.afAppId,
    required this.distinctId,
    required this.requestAfCallback,
  });

  init()async{
    _appsflyerSdk=AppsflyerSdk(AppsFlyerOptions(
      afDevKey: "qxH3wE6Gtt55drYjXkCLDC",
      appId: "6740134727",
      timeToWaitForATTUserAuthorization: 8,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
      manualStart: true,
    ));
    await _appsflyerSdk?.initSdk(registerConversionDataCallback: true);
    _appsflyerSdk?.setCustomerUserId(distinctId);
    _appsflyerSdk?.onInstallConversionData((res){
      FlutterCheckAf.instance.log("check user---> request af result-->$res");
      try{
        if(res["status"]=="success"){
          var status = res["payload"]["af_status"].toString();
          var isB = !status.contains("Organic");
          requestAfCallback.requestSuccess.call(isB);
          if(isB){
            afIsB=true;
            if(p2AfResult.getData().isEmpty){
              requestAfCallback.firstRequestAfB.call();
              p2AfResult.saveData(status);
            }
            aPackageAfCall?.call();
          }
        }
      }catch(e){

      }
    });

    requestAfCallback.startRequestAf.call();
    _startAf();
  }

  _startAf(){
    FlutterCheckAf.instance.log("check user---> start request af");
    _appsflyerSdk?.startSDK(
        onSuccess: (){
          FlutterCheckAf.instance.log("check user---> initAppsflyer success");
          requestAfCallback.startAfSuccess.call();
        },
        onError: (code,msg){
          FlutterCheckAf.instance.log("check user---> initAppsflyer fail--->$code---->$msg");
          requestAfCallback.startAfFail.call(code,msg);
          Future.delayed(const Duration(milliseconds: 1000),(){
            _startAf();
          });
        }
    );
  }

  setAPackageAfCall(Function() call){
    aPackageAfCall=call;
  }

  uploadAdRevenue(String networkName,double revenue,String adId,String pointName){
    FlutterCheckAf.instance.log("check user---> logAdRevenue--->networkName:$networkName--revenue:$revenue--adId:$adId--pointName:$pointName");
    _appsflyerSdk?.logAdRevenue(
        AdRevenueData(
            monetizationNetwork: networkName,
            mediationNetwork: AFMediationNetwork.applovinMax.value,
            currencyIso4217Code: "USD",
            revenue: revenue,
            additionalParameters: {
              "adRevenueUnit": adId,
              "adRevenuePlacement": pointName,
            }
        )
    );
  }
}