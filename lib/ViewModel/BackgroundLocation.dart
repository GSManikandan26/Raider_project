import 'dart:async';
import 'dart:math';
import 'package:botbridge_green/Model/ServerURL.dart';
import 'package:botbridge_green/Utils/LocalDB.dart';
import 'package:geolocator/geolocator.dart';

import '../MainData.dart';
import '../Model/ApiClient.dart';

class BackgroundLocation{

  startFetchLocation(){
    double constLat = 0.0;
    double constLong = 0.0;
    // Geolocator.getPositionStream().listen((event) {
    //   print(event);
    // });
    Timer.periodic(Duration(seconds: 10), (timer) async {
      Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // double calculateDistance(lat1, lon1, lat2, lon2){
      //   var p = 0.017453292519943295;
      //   var c = cos;
      //   var a = 0.5 - c((lat2 - lat1) * p)/2 +
      //       c(lat1 * p) * c(lat2 * p) *
      //           (1 - c((lon2 - lon1) * p))/2;
      //   return 1000 * asin(sqrt(a));
      // }
      // if(constLat != userLocation.latitude && constLong != userLocation.longitude ){
      //   constLat = userLocation.latitude;
      //   constLong = userLocation.longitude;
      //   int distance = calculateDistance(constLat, constLong, userLocation.latitude, userLocation.longitude).toInt();
      //   if(distance > 100 ){



          LocalDB.getLDB("userNo").then((value) {

            Map<String,dynamic> params = {
              "IdentityType":MainData.appName,
              "PhileBotomyNo":value,
              "TenantNo":MainData.tenantNo,
              "TenantBranchNo":MainData.tenantBranchNo,
              "DeviceID":"Android",
              "Latitude":userLocation.latitude,
              "Longitude":userLocation.longitude,
              "Location":""
            };
            print(params);
            ApiClient().fetchData(ServerURL().getUrl(RequestType.LocationUpdate), params);
          });

          // print("-------------user move more than ${distance}---");
    //
    //     }else{
    //       print("-------------user move lesser than ${distance}---");
    //     }
    //   }else{
    //     print(constLat);
    //     print(constLong);
    //     print("user not moving");
    //   }
    //
    });

  }

}