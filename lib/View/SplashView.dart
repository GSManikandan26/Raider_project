import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MainData.dart';
import '../Utils/NavigateController.dart';
import 'Helper/ThemeCard.dart';
import 'HomeView.dart';
import 'LoginView.dart';
import '../ViewModel/SignInVM.dart';



class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  getData(){
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      check(pref);
    });
  }
  check(SharedPreferences pref){
    if(pref.getString('userID') == null){
      NavigateController.pagePush(context, const LoginView());
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    }else{
      // Map<String,dynamic> data = {
      //   "UserName":pref.getString("username"),
      //   "Password":pref.getString("password"),
      //   "DeviceID": "ANDROID",
      //   "RequestType":MainData.requestType,
      //   "FCMToken": "",
      //   "Latitude": "",
      //   "Longitude": ""
      // };
      // SignInVM foodNotifier = Provider.of<SignInVM>(context, listen: false);
      // loginMain( context, data,foodNotifier,false);
      NavigateController.pagePush(context, const HomeView());
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomTheme.background_green,
      body:  Stack(
        children: [
          Positioned(
              top: -height * 0.12,
              right: - width * 0.12,
              child: Container(
                height: height * 0.4,
                width:height * 0.4 ,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomTheme.circle_green
                ),
              )),
          Positioned(
              bottom: -height * 0.12,
              left: - width * 0.12,
              child: Container(
                height: height * 0.3,
                width:height * 0.3 ,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomTheme.circle_green
                ),
              )),
           Align(
            alignment: Alignment.center,
            child:Image.asset('assets/images/bot_logo.jpg',height:height*0.22,),),

        ],
      ),
    );
  }
}
