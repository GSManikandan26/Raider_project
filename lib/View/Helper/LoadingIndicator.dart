import 'package:botbridge_green/Utils/NavigateController.dart';
import 'package:botbridge_green/View/Helper/ThemeCard.dart';
import 'package:flutter/material.dart';


loadingIndicator(BuildContext context){
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          height: 70,
          width:400,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CircularProgressIndicator(color: CustomTheme.background_green,),
              const SizedBox(width: 25,),
              const Text("Loading....",style: TextStyle(fontSize: 14),),
            ],
          ),
        ),
      );
    },
  );

}

scrollIndicator(BuildContext context,double height,double width){
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: ()=>NavigateController.disableBackBt(),
        child: Dialog(
          child: SizedBox(
            height: 70,
            width:400,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:const  [
                 CircularProgressIndicator(),
                SizedBox(width: 25,),
                 Text("Loading....",style: TextStyle(fontSize: 14),),
              ],
            ),
          ),
        ),
      );
    },
  );
}