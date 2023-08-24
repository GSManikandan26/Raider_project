import 'package:botbridge_green/Utils/NavigateController.dart';
import 'package:botbridge_green/View/HomeView.dart';
import 'package:flutter/material.dart';
import '../Model/ApiClient.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/SignData.dart';
import '../Model/ServerURL.dart';
import '../Model/Status.dart';
import '../Utils/LocalDB.dart';
import '../View/Helper/ErrorPopUp.dart';
import '../View/Helper/LoadingIndicator.dart';




class SignInVM extends ChangeNotifier{

  SignData loginData = SignData();

  Status status = Status.Loading;
  // late SignData _display= {} as SignData;

  SignData get getLoginData => loginData;


  set setStatus(Status data) {
    status = data;
    notifyListeners();
  }

  set setLoginData(data){
        loginData = SignData.fromJson(data);
        print(getLoginData.userName);
        status = Status.Completed;
        notifyListeners();
  }

}

loginMain(BuildContext context,Map<String,dynamic> params,SignInVM model,bool isNewLog) async {

  isNewLog ? loadingIndicator(context) : null ;
  ApiClient initHit = ApiClient();
  String tokenUSER = "grant_type=password&UserName=${params["UserName"]}&Password=${params["Password"]}";

  initHit.fetchData(ServerURL().getUrl(RequestType.Login),params).then((data){
    print("data url");
    print("login url $data");
    model.setLoginData =data;
    if(model.getLoginData.status == 1 ){
      print("response sucess");
      LocalDB.setLDB("AccountName", model.getLoginData.userName.toString());
      LocalDB.setLDB("userID", model.getLoginData.userNo.toString());
      LocalDB.setLDB("userNo", model.getLoginData.userNo.toString());
      LocalDB.setLDB("isOffline", model.getLoginData.isOffline.toString());
      LocalDB.setLDB("venueNo", model.getLoginData.venueNo.toString());
      LocalDB.setLDB("venueBranchNo", model.getLoginData.venueBranchNo.toString());

      // LocalDB.setLDB("password", params["Password"]);
      // LocalDB.setLDB("username", params["UserName"]);
      NavigateController.pagePush(context, const HomeView());
    }else{
      model.status = Status.Error;
      isNewLog ? Navigator.pop(context) : null ;
      errorPopUp(context);
    }
  });
  //     .onError((error, stackTrace) {
  //   isNewLog ? Navigator.pop(context) : null ;
  //   errorPopUp(context);
  //   model.status = Status.Error;
  //   print( ApiResponse.error(error.toString()));
  // }
  // );

  // initHit.getToken(tokenUSER, ServerURL().getUrl(RequestType.token)).then((value){
  //
  //
  // }).catchError((er){
  //   print(er);
  //   isNewLog ? Navigator.pop(context) : null ;
  //   // errorPopUp(context);
  //   model.status = Status.Error;
  // });
}