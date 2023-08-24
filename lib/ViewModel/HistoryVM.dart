import 'package:flutter/material.dart';
import '../../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/AppoitmentAndRequestData.dart';


class HistoryVM extends ChangeNotifier{

  final _myRepo = ApiInterface();

  ApiResponse<AppointmentAndRequestData> listCart = ApiResponse.loading();

  ApiResponse<AppointmentAndRequestData> get getHistoryList => listCart;

  setHistoryData(ApiResponse<AppointmentAndRequestData> response) {
    print("Response :: $response");
    print(response.data);
    listCart = response;
    notifyListeners();
  }

  Future<void> fetchHistoryDetails(Map<String,dynamic> params) async {
    setHistoryData( ApiResponse.loading());
    _myRepo.getAppointmentAndRequest(params)
        .then((value) {
      return setHistoryData( ApiResponse.completed(value));
    })
        .onError((error, stackTrace) {
      return setHistoryData(ApiResponse.error(error.toString()));
    });
  }
}

