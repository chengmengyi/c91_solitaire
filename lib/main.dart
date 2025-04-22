import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solitaire/launch/launch_page.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p2/hep/p2_routers_name.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';

void main() async{
  await init();
  await initP1P2();
  await initP3();
  runApp(const MyApp());
}

init()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      )
  );
}

initP1P2()async{
  await GetStorage.init();
  P1AD.instance.initAdInfo();
}

initP3()async{

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize(),
      builder: (c,child)=>GetMaterialApp(
        title: title(),
        enableLog: true,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: initialRoute(),
        debugShowCheckedModeBanner: false,
        getPages: getPages(),
        defaultTransition: Transition.rightToLeft,
        builder: (context,widget)=>builder(context,widget),
      ),
    );
  }

  designSize()=>const Size(375, 812);

  title()=>'VentureVault Solitaire';

  initialRoute()=>"/p1/launch";

  getPages(){
    var list = P2RoutersList.p2RoutersList+P3RoutersList.p3RoutersList;
    list.add(
      GetPage(
          name: initialRoute(),
          page: ()=> LaunchPage(),
          transition: Transition.fadeIn
      )
    );
    return list;
  }

  builder(context,widget)=>MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    child: widget!,
  );
}