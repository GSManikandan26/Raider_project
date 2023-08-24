import 'package:botbridge_green/View/Helper/ThemeCard.dart';
import 'package:flutter/material.dart';


errorPopUp(BuildContext context){
  return showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10.0),
              Image.asset("assets/images/password.png", width: 45.0),
              const SizedBox(height: 20.0),
              Text('Oops!', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w800, color: Color(0xFFE04F5F))),
              const SizedBox(height: 20.0),
              Text('Something went wrong.\nPlease try again.', textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.black, )),
              const SizedBox(height: 30.0),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(CustomTheme.background_green),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ))
                ),
                child: Text('TRY AGAIN', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w800, color: Colors.white)),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      }
  );

}