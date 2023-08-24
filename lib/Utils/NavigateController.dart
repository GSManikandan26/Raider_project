import 'package:flutter/material.dart';

class NavigateController{

  // Page Push to next Screen
  static pagePush(BuildContext context,Widget widget){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> widget));
  }


  // Page Push to next Screen
  static pagePOP(BuildContext context){
    Navigator.pop(context);
  }

  static Future<bool> disableBackBt(){
    return Future.value(false);
  }


  // Page Replace to next Screen
  static pageReplace(BuildContext context,Widget widget){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> widget));
  }


  // Page Push to next Screen Like Back(POP) Navigate
  static pagePushLikePop(BuildContext context,Widget widget){
    Navigator.of(context).push(PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(seconds: 1),
        pageBuilder: (BuildContext context, _, __) {
          return  widget;
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {

          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
    ));
  }


  static createRoute(Widget widget,BuildContext context) {
    return Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>  widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        )
    );

  }


  static Future<bool> willScopeBt(){
    return Future.value(false);
  }

}