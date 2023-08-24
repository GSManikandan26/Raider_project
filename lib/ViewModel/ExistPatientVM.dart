import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/ExistingPatientData.dart';


class ExistingPatientVM extends ChangeNotifier{

  final _myRepo = ApiInterface();

  ApiResponse<ExistsPatientsData> listPatient = ApiResponse.loading();

  ApiResponse<ExistsPatientsData> get getExistedPatient => listPatient;

  setAppointmentData(ApiResponse<ExistsPatientsData> response) {
    print("Response :: $response");
    print(response.data);
    listPatient = response;
    notifyListeners();
  }

  Future<void> fetchExistedPatientDetails(Map<String,dynamic> params) async {
    setAppointmentData( ApiResponse.loading());
    _myRepo.getExistedPatient(params)
        .then((value) {
      return setAppointmentData( ApiResponse.completed(value));
    })
        .onError((error, stackTrace) {
      return setAppointmentData(ApiResponse.error(error.toString()));
    });
  }
}

