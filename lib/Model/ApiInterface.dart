import 'package:botbridge_green/Model/Response/AppoitmentAndRequestData.dart';
import 'package:botbridge_green/Model/Response/BookedServiceData.dart';
import 'package:botbridge_green/Model/Response/ExistingPatientData.dart';

import 'package:botbridge_green/Model/Response/PatientDetails.dart';

import 'package:botbridge_green/Model/Response/ReferalDataList.dart';

import 'package:botbridge_green/Model/Response/ServiceDetailsListData.dart';
import 'package:botbridge_green/Model/ServerURL.dart';

import 'ApiClient.dart';
import 'Repository/Repo.dart';
import 'Response/SampleWiseService.dart';
import 'Response/ServiceDataNew.dart';

class ApiInterface implements Repo {

  final ApiClient _apiService = ApiClient();

  @override
  Future<AppointmentAndRequestData?> getPatientDetails(Map<String,dynamic> params) async {
    try {
      dynamic response = await _apiService.fetchData(ServerURL().getUrl(RequestType.LoadAppointment),params);
      print("my gender Response $response");
      final jsonData = AppointmentAndRequestData.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error $e");
      throw e;

    }
  }

  @override
  Future<ServiceDataNew?> getServiceDetails(Map<String, dynamic> params) async {
    // TODO: implement getServiceDetails
    try {
      print("dear params");
      print(params);
      dynamic response = await _apiService.fetchData(ServerURL().getUrl(RequestType.serviceData),params);
      //dynamic response = await _apiService.getData(ServerURL().getUrl(RequestType.serviceData));
      print("Response $response");
      final jsonData = ServiceDataNew.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error $e");
      throw e;


    }
  }

  @override
  Future<AppointmentAndRequestData?> getAppointmentAndRequest(Map<String, dynamic> params) async {
    try {
      dynamic response = await _apiService.fetchData(ServerURL().getUrl(RequestType.LoadAppointment),params);
      print("calling getAppointmentAndRequest $response");
      print("Response $response");
      final jsonData = AppointmentAndRequestData.fromJson(response);
      return jsonData;
    }
    catch (e) {
      print("Error $e");
      rethrow;


    }
  }

  @override
  Future<ReferalData?> getReferal(Map<String, dynamic> params) async {
    try {
      dynamic response = await _apiService.fetchData(ServerURL().getUrl(RequestType.GetReferralDetails),params);
      print("Response $response");
      final jsonData = ReferalData.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error $e");
      // rethrow;

    }
  }

  @override
  Future<ExistsPatientsData?> getExistedPatient(Map<String, dynamic> params) async {
    try {
      dynamic response = await _apiService.fetchData(ServerURL().getUrl(RequestType.ArchivePatientSearch),params);
      print("Response $response");
      final jsonData = ExistsPatientsData.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error $e");
      rethrow;

    }
  }

  @override
  Future<AppointmentAndRequestData?> getBookedService(Map<String, dynamic> params) async {
    try {
      print("before calling Bookedservice $params");
      dynamic response = await _apiService.fetchData(ServerURL().getUrl(RequestType.LoadAppointment),params);
      print("calling Bookedservice $response");
      final jsonData = AppointmentAndRequestData.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error $e");
      rethrow;

    }
  }

  @override
  Future<AppointmentAndRequestData?> getSampleWiseTest(Map<String, dynamic> params) async {
    try {
      dynamic response = await _apiService.fetchData(ServerURL().getUrl(RequestType.LoadAppointment),params); //GetSampleWiseService
      print(params);
      print("Response $response");
      final jsonData = AppointmentAndRequestData.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error $e");
      rethrow;

    }
  }



}