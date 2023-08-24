import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Model/Apiclient.dart';
import '../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/AppoitmentAndRequestData.dart';
import '../Model/Response/BookedServiceData.dart';
import '../Model/ServerURL.dart';
import '../Model/Status.dart';


class BookedServiceVM extends ChangeNotifier{
  final _myRepo = ApiInterface();

  ApiResponse<AppointmentAndRequestData> listBookedService= ApiResponse.loading();

  String cartCount = "0";
  List<Map<String,dynamic>> NewBookData= [];
  List<Map<String,dynamic>> get getNewBookData => NewBookData;

  set setCartCount(data){
    cartCount = data;
    notifyListeners();
  }
  get getCartCount=>cartCount;


  ApiResponse<AppointmentAndRequestData> get getBookedService => listBookedService;

  setBookedService(ApiResponse<AppointmentAndRequestData> response) {
    print("Response :: $response");
    print(response.data);
    listBookedService = response;
    notifyListeners();
  }

  set addTestForNewBook(data){
    NewBookData.add(data);
  }

  Future<void> fetchBookedService(Map<String,dynamic> params,BookedServiceVM model,bool isNewBook) async {
    if(isNewBook){
      model.setBookedService( ApiResponse.loading());
      final jsonData = AppointmentAndRequestData.fromJson({
        "lstPatientResponse": [
          {
            "bookingNo": 3,
            "bookingId": "HC300",
            "patientName": "Mr.Senthil  ",
            "age": "12",
            "gender": "Male",
            "mobileNumber": "9878766667",
            "address": "",
            "area": "",
            "pincode": "",
            "latitude": null,
            "longitude": null,
            "testNames": "",
            "noofTest": 3,
            "registeredDateTime":  DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
            "patientNo": 0,
            "patientVisitNo": 0,
            "currentStatusNo": 1,
            "currentStatusName": "Phlebotomist Assigned",
            "fromSlot": null,
            "toSlot": null,
            "userImage": "",
            "totalTestAmount": 200.00,
            "physicianNo": 0,
            "isStart": true,
            "isPaid": false,
            "userNo": 2,
            "venueNo": 1,
            "venueBranchNo": 1,
            "lstTestDetails": [

            ],
            "lstTestSampleWise": [

            ]
          },
        ],
        "status": 1,
        "message": "Data Fetched Successfully",
        "totalCountTest": 92
      });
      model.setBookedService( ApiResponse.completed(jsonData));

    }else{
      model.setBookedService( ApiResponse.loading());
      _myRepo.getBookedService(params)
          .then((value) {
        print(value!.totalCountTest.toString());
        model.setCartCount = value.totalCountTest.toString();
        return model.setBookedService( ApiResponse.completed(value));
      })
          .onError((error, stackTrace) {
        return model.setBookedService(ApiResponse.error(error.toString()));
      });
    }

  }

}

