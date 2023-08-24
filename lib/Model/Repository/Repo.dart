import 'package:botbridge_green/Model/Response/BookedServiceData.dart';
import 'package:botbridge_green/Model/Response/ExistingPatientData.dart';
import '../Response/AppoitmentAndRequestData.dart';
import '../Response/PatientDetails.dart';
import '../Response/ReferalDataList.dart';
import '../Response/SampleWiseService.dart';
import '../Response/ServiceDataNew.dart';
import '../Response/ServiceDetailsListData.dart';




abstract class Repo{

  // Future<BaseData?> getBase(Map<String,dynamic> params) async {}
  Future<AppointmentAndRequestData?> getAppointmentAndRequest(Map<String,dynamic> params) async {
    return null;
  }
  Future<AppointmentAndRequestData?> getPatientDetails(Map<String,dynamic> params) async {
    return null;
  }
  Future<ReferalData?> getReferal(Map<String,dynamic> params) async {
    return null;
  }

  Future<ServiceDataNew?> getServiceDetails(Map<String,dynamic> params) async {
    return null;
  }

  Future<ExistsPatientsData?> getExistedPatient(Map<String,dynamic> params) async {
    return null;
  }


  Future<AppointmentAndRequestData?> getBookedService(Map<String,dynamic> params) async {
    return null;
  }


  Future<AppointmentAndRequestData?> getSampleWiseTest(Map<String,dynamic> params) async {
    return null;
  }


}