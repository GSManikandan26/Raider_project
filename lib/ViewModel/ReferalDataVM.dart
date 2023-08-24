import 'package:flutter/material.dart';
import '../../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/ReferalDataList.dart';

class ReferalDataVM extends ChangeNotifier{

  final _myRepo = ApiInterface();

  ApiResponse<ReferalData> listCart = ApiResponse.loading();

  ApiResponse<ReferalData> get getHistoryList => listCart;

  setHistoryData(ApiResponse<ReferalData> response) {
    print("Response :: $response");
    print(response.data);
    listCart = response;
    notifyListeners();
  }

  Future<void> fetchHistoryDetails(Map<String,dynamic> params) async {
    setHistoryData( ApiResponse.loading());
    _myRepo.getReferal(params)
        .then((value) {
      return setHistoryData( ApiResponse.completed(value));
    })
        .onError((error, stackTrace) {
      return setHistoryData(ApiResponse.error(error.toString()));
    });
  }
}

