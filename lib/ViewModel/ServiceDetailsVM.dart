import 'dart:developer';

import 'package:flutter/material.dart';
import '../../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/ServiceDataNew.dart';
import '../Model/Response/ServiceDetailsListData.dart';
import '../Model/Status.dart';


class ServiceDetailsVM extends ChangeNotifier{

  final ApiInterface _myRepo = ApiInterface();
  List<LstService> listOfData = [];
  String searchname = "";
  String searchkey = "";
  String searchFieldController = '';

  String get getsearchname => searchname;
  String get getsearchkey => searchkey;
  String get getSearchController => searchFieldController;

  int get getNextPage => nextPage;
  ApiResponse<ServiceDataNew> listService = ApiResponse.loading();

  ApiResponse<ServiceDataNew> get getAddToCart => listService;
  List<LstService> get getListData => listOfData;
  int nextPage = 1;
  setPatientDetailsMain(ApiResponse<ServiceDataNew> response) {
    print("Response :: $response");
    log(response.data.toString());
    listService = response;
    notifyListeners();
  }

  // Future<void> fetchServiceDetails(Map<String,dynamic> params) async {
  //   setPatientDetailsMain( ApiResponse.loading());
  //   _myRepo.getServiceDetails(params)
  //       .then((value) {
  //     return setPatientDetailsMain( ApiResponse.completed(value));
  //   })
  //       .onError((error, stackTrace) {
  //     return setPatientDetailsMain(ApiResponse.error(error.toString()));
  //   });
  // }

  Future<void> fetchServiceDetails(Map<String, dynamic> params, ServiceDetailsVM model,String searchField) async {
    // model.setData(ApiResponse.loading());
     nextPage = 1;
     params['pageIndex'] = 1;
     print("Params -----------");
     notifyListeners();
     print(searchField);

     // if(searchField.isNotEmpty){
     //   searchFieldController = searchField;
     //   setSearchController( searchField);
     //   notifyListeners();
     // }
     print("params --- 10");

     print("controller" + getSearchController);
     print(searchFieldController);
    _myRepo.getServiceDetails(params).then((value) {
      print("Completed---");
      print(value);
      return model.setData(ApiResponse.completed(value),searchField);
    }).onError((error, stackTrace) {
      return model.setData(ApiResponse.error(error.toString()),searchField);
    });
  }

  setData(ApiResponse<ServiceDataNew> response,searchField) {
    print("Response :: $response");
    listOfData = [];
    listService = response;
    print("STart-----1");
    print(response.status);
    print(listService.status);
    print(response.message);
    if (response.status == Status.Completed) {
      print("STart-----2");
      if (response.data!.status.toString() == "1") {
        List<LstService>? data1 = response.data!.lstService;
        nextPage = 2;
        searchFieldController = searchField;
        listOfData = data1!;
      } else {
        listOfData = [];
      }
    }
    notifyListeners();
  }

  setsearch_key(String seaKey) {
    searchkey  = seaKey;
    notifyListeners();
  }

  setsearch_name(String seaName) {

    searchname = seaName;
    notifyListeners();
  }

   setSearchController(String seaName) {

    searchFieldController = seaName;
    notifyListeners();
  }

  setDataNext(ApiResponse<ServiceDataNew> response) {
    print("Response :: $response");
    print(response.data);
    listService = response;
    if (response.status == Status.Completed) {
      if (response.data!.status.toString() == "1") {
        print(response.data!.status);
        print(response.data!.lstService!.length);
        List<LstService>? data1 = response.data!.lstService;
        nextPage = nextPage + 1;
        listOfData.addAll(data1!);
      }
    }
    print(listOfData.length);
    notifyListeners();
  }

  Future<void> fetchServiceDetailsNext(
      Map<String, dynamic> params, ServiceDetailsVM model) async {
    print("Pageb--"+getNextPage.toString());
    print(params);
    params["serviceName"] = model.searchFieldController.isEmpty ? params["serviceName"] : model.searchFieldController;
    print(params["serviceName"]);
    _myRepo.getServiceDetails(params).then((value) {
      return model.setDataNext(ApiResponse.completed(value));
    });
  }
}

