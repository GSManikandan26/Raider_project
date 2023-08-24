
import 'package:botbridge_green/Utils/LocalDB.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import '../MainData.dart';
import '../View/Helper/ListApiHit.dart';
import 'ApiException.dart';

class ApiClient{


  authentication(String url,Map<String, dynamic> params) async {

    var urlData = Uri.parse(url);
    var body = json.encode(params);

    if (kDebugMode) print('\x1B[33m$urlData\x1B[0m');
    if (kDebugMode) print('\x1B[33m$body\x1B[0m');


    try{
      http.Response response = await http.post(
          urlData,
          headers: <String, String>{
            "Content-Type": "application/json",
          },
          body: body
      );
      print(response.statusCode);
      if (kDebugMode) print('\x1B[32m${response.body}\x1B[0m');
      Map<String,dynamic> ddt = {
        "url":url,
        "params":params,
        "body":response.body,
        "time":DateTime.now()
      };
      listHitData.add(ddt);
      return returnResponse(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }

  }

  Future<dynamic> getToken(String params,String url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(url);
    print('\x1B[33m$params\x1B[0m');
    var urlData = Uri.parse(url);
    var response = await http.post(
        urlData,
        headers: <String, String>{
          'loginType': 'LIS',
        },
        body: params
    );
    print(response.body);
    Map<String,dynamic> ddt = {
      "url":url,
      "params":params,
      "body":response.body,
      "time":DateTime.now()
    };
    listHitData.add(ddt);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      pref.setString("token", data["access_token"]);
      print(pref.getString("token") ?? "");
      return jsonDecode(response.body);
    } else {
      print("fail");
      return response;
    }
  }



  Future<dynamic> fetchData(String url,Map<String, dynamic> params) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";
    var urlData = Uri.parse(url);
    print(url);
    print("mydear $params");
    // params["venueNo"] = MainData.tenantNo;
    // params["venueBranchNo"] = MainData.tenantBranchNo;
    var venueNo = await LocalDB.getLDB("venueNo") ?? "";
    var venueBranchNo = await LocalDB.getLDB("venueBranchNo") ?? "";
    print("dear $venueNo");
    print("dear $venueBranchNo");
    params["venueNo"] = venueNo; //MainData.tenantNo;
    params["venueBranchNo"] = venueBranchNo; //MainData.tenantBranchNo;
    var body = json.encode(params);
    print('\x1B[33m$body\x1B[0m');
    try{
      var response = await http.post(
          urlData,
          headers: <String, String>{
            'loginType': 'application/json',
            "Content-Type": "application/json",
            // 'Authorization': '${"Bearer"} $token'
          },
          body:  body
      );
      print('\x1B[32m${response.body}\x1B[0m');
      Map<String,dynamic> ddt = {
        "url":url,
        "params":params,
        "body":response.body,
        "time":DateTime.now()
      };
      listHitData.add(ddt);
      // final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      // pattern.allMatches(response.body).forEach((match) => print('\x1B[32m${match.group(0)}\x1B[0m'));
      return returnResponse(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }

  }

  Future<dynamic> getData(String url) async {
    var urlData = Uri.parse(url);
    print(url);
    try{
      var response = await http.get(
          urlData,
          headers: <String, String>{
            'loginType': 'application/json',
            "Content-Type": "application/json",
            // 'Authorization': '${"Bearer"} $token'
          },
      );
      Map<String,dynamic> ddt = {
        "url":url,
        "params":"Get API",
        "body":response.body,
        "time":DateTime.now()
      };
      listHitData.add(ddt);
      print('\x1B[32m${response.body}\x1B[0m');
      // final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      // pattern.allMatches(response.body).forEach((match) => print('\x1B[32m${match.group(0)}\x1B[0m'));
      return returnResponse(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }

  }


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
          return {"message":"404 error"};
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}