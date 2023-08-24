import 'package:flutter/material.dart';
import '../../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/AppoitmentAndRequestData.dart';


class CollectedSampleVM extends ChangeNotifier{
  final _myRepo = ApiInterface();

  ApiResponse<AppointmentAndRequestData> listCart = ApiResponse.loading();

  ApiResponse<AppointmentAndRequestData> get getCollectedSamples => listCart;

  setCollectedSamplesData(ApiResponse<AppointmentAndRequestData> response) {
    print("Response :: $response");
    print(response.data);
    listCart = response;
    notifyListeners();
  }

  Future<void> fetchCollectedSamplesDetails(Map<String,dynamic> params,CollectedSampleVM model) async {
    model.setCollectedSamplesData( ApiResponse.loading());
    _myRepo.getAppointmentAndRequest(params)
        .then((value) {
      return model.setCollectedSamplesData( ApiResponse.completed(value));
    })
        .onError((error, stackTrace) {
      return model.setCollectedSamplesData(ApiResponse.error(error.toString()));
    });
  }
}

