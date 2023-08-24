import 'package:flutter/material.dart';

import '../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/AppoitmentAndRequestData.dart';
import '../Model/Response/PatientDetails.dart';


class PatientDetailsVM extends ChangeNotifier{

  final _myRepo = ApiInterface();

  ApiResponse<AppointmentAndRequestData> listCart = ApiResponse.loading();

  ApiResponse<AppointmentAndRequestData> get getPatientDetails => listCart;

  setPatientDetailsMain(ApiResponse<AppointmentAndRequestData> response) {
    print("Response :: $response");
    print(response.data);
    listCart = response;
    notifyListeners();
  }

  Future<void> fetchPatientDetails(Map<String,dynamic> params) async {
    setPatientDetailsMain( ApiResponse.loading());
    _myRepo.getPatientDetails(params)
        .then((value) {
      return setPatientDetailsMain( ApiResponse.completed(value));
    })
        .onError((error, stackTrace) {
      return setPatientDetailsMain(ApiResponse.error(error.toString()));
    });
  }

}

