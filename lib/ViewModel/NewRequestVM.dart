import 'package:flutter/material.dart';
import '../../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/AppoitmentAndRequestData.dart';


class NewRequestVM extends ChangeNotifier{
  final _myRepo = ApiInterface();

  ApiResponse<AppointmentAndRequestData> listCart = ApiResponse.loading();

  ApiResponse<AppointmentAndRequestData> get getNewRequest => listCart;

  setRequestData(ApiResponse<AppointmentAndRequestData> response) {
    print("Response :: $response");
    print(response.data);
    listCart = response;
    notifyListeners();
  }

  Future<void> fetchRequestDetails(Map<String,dynamic> params) async {
    setRequestData( ApiResponse.loading());
    _myRepo.getAppointmentAndRequest(params)
        .then((value) {
      return setRequestData( ApiResponse.completed(value));
    })
        .onError((error, stackTrace) {
      return setRequestData(ApiResponse.error(error.toString()));
    });
  }

}

