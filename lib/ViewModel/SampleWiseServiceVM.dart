import 'package:flutter/material.dart';
import '../../Model/Apiclient.dart';
import '../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/AppoitmentAndRequestData.dart';
import '../Model/Response/SampleWiseService.dart';
import '../Model/ServerURL.dart';
import '../Model/Status.dart';


class SampleWiseServiceDataVM extends ChangeNotifier{

  final _myRepo = ApiInterface();

  ApiResponse<AppointmentAndRequestData> listCart = ApiResponse.loading();

  ApiResponse<AppointmentAndRequestData> get getAddToCart => listCart;

  setSampleWiseService(ApiResponse<AppointmentAndRequestData> response) {
    print("Response :: $response");
    print(response.data);
    listCart = response;
    notifyListeners();
  }

  Future<void> fetchSampleWiseTest(Map<String,dynamic> params) async {
    setSampleWiseService( ApiResponse.loading());
    _myRepo.getSampleWiseTest(params)  //getSampleWiseTest
        .then((value) {
      return setSampleWiseService( ApiResponse.completed(value));
    })
        .onError((error, stackTrace) {
      return setSampleWiseService(ApiResponse.error(error.toString()));
    });
  }
}

