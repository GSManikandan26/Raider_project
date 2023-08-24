// class PatientDetailsData {
//   List<LstPhileBotomyAppointmentAndRequest>?
//   lstPhileBotomyAppointmentAndRequest;
//   int? status;
//   String? message;
//   String? totalCountTest;
//
//   PatientDetailsData(
//       {this.lstPhileBotomyAppointmentAndRequest,
//         this.status,
//         this.message,
//         this.totalCountTest});
//
//   PatientDetailsData.fromJson(Map<String, dynamic> json) {
//     if (json['lstPhileBotomyAppointmentAndRequest'] != null) {
//       lstPhileBotomyAppointmentAndRequest =
//       <LstPhileBotomyAppointmentAndRequest>[];
//       json['lstPhileBotomyAppointmentAndRequest'].forEach((v) {
//         lstPhileBotomyAppointmentAndRequest!
//             .add(LstPhileBotomyAppointmentAndRequest.fromJson(v));
//       });
//     }
//     status = json['Status'];
//     message = json['Message'];
//     totalCountTest = json['TotalCountTest'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (lstPhileBotomyAppointmentAndRequest != null) {
//       data['lstPhileBotomyAppointmentAndRequest'] = lstPhileBotomyAppointmentAndRequest!
//           .map((v) => v.toJson())
//           .toList();
//     }
//     data['Status'] = status;
//     data['Message'] = message;
//     data['TotalCountTest'] = totalCountTest;
//     return data;
//   }
// }
//
// class LstPhileBotomyAppointmentAndRequest {
//   String? tittle;
//   String? patientName;
//   String? age;
//   String? gendercode;
//   String? servicesName;
//   String? visitDate;
//   String? countTest;
//   String? phlebotomistID;
//   int? bookingNo;
//   String? bookingID;
//   String? bookingNumber;
//   String? visitID;
//   String? patientID;
//   String? currentStatusID;
//   String? currentStatusName;
//   String? latitude;
//   String? longitude;
//   String? address;
//   String? area;
//   String? mobileNumber;
//   String? slotFromTime;
//   String? slotToTime;
//   String? pincode;
//   String? userImage;
//   String? currencyID;
//   String? currencyCode;
//   String? currencySymbol;
//   double? totalServicesAmount;
//   String? clientID;
//   String? primaryRefferralType;
//   String? doctorId;
//   bool? isStart;
//   bool? isPatientPaid;
//   int? subjectEncounterNo;
//   List<LstTestDetails>? lstTestDetails;
//   List<LstTestSampleWise>? lstTestSampleWise;
//
//   LstPhileBotomyAppointmentAndRequest(
//       {this.tittle,
//         this.patientName,
//         this.age,
//         this.gendercode,
//         this.servicesName,
//         this.visitDate,
//         this.countTest,
//         this.phlebotomistID,
//         this.bookingNo,
//         this.bookingID,
//         this.bookingNumber,
//         this.visitID,
//         this.patientID,
//         this.currentStatusID,
//         this.currentStatusName,
//         this.latitude,
//         this.longitude,
//         this.address,
//         this.area,
//         this.mobileNumber,
//         this.slotFromTime,
//         this.slotToTime,
//         this.pincode,
//         this.userImage,
//         this.currencyID,
//         this.currencyCode,
//         this.currencySymbol,
//         this.totalServicesAmount,
//         this.clientID,
//         this.primaryRefferralType,
//         this.doctorId,
//         this.isStart,
//         this.isPatientPaid,
//         this.subjectEncounterNo,
//         this.lstTestDetails,
//         this.lstTestSampleWise});
//
//   LstPhileBotomyAppointmentAndRequest.fromJson(Map<String, dynamic> json) {
//     tittle = json['Tittle'];
//     patientName = json['PatientName'];
//     age = json['Age'];
//     gendercode = json['Gendercode'];
//     servicesName = json['ServicesName'];
//     visitDate = json['VisitDate'];
//     countTest = json['CountTest'];
//     phlebotomistID = json['PhlebotomistID'];
//     bookingNo = json['BookingNo'];
//     bookingID = json['BookingID'];
//     bookingNumber = json['BookingNumber'];
//     visitID = json['VisitID'];
//     patientID = json['PatientID'];
//     currentStatusID = json['CurrentStatusID'];
//     currentStatusName = json['CurrentStatusName'];
//     latitude = json['Latitude'];
//     longitude = json['Longitude'];
//     address = json['Address'];
//     area = json['Area'];
//     mobileNumber = json['MobileNumber'];
//     slotFromTime = json['SlotFromTime'];
//     slotToTime = json['SlotToTime'];
//     pincode = json['Pincode'];
//     userImage = json['UserImage'];
//     currencyID = json['CurrencyID'];
//     currencyCode = json['CurrencyCode'];
//     currencySymbol = json['CurrencySymbol'];
//     totalServicesAmount = json['TotalServicesAmount'];
//     clientID = json['ClientID'];
//     primaryRefferralType = json['PrimaryRefferralType'];
//     doctorId = json['DoctorId'];
//     isStart = json['IsStart'];
//     isPatientPaid = json['IsPatientPaid'];
//     subjectEncounterNo = json['SubjectEncounterNo'];
//     if (json['lstTestDetails'] != null) {
//       lstTestDetails = <LstTestDetails>[];
//       json['lstTestDetails'].forEach((v) {
//         lstTestDetails!.add(LstTestDetails.fromJson(v));
//       });
//     }
//     if (json['lstTestSampleWise'] != null) {
//       lstTestSampleWise = <LstTestSampleWise>[];
//       json['lstTestSampleWise'].forEach((v) {
//         lstTestSampleWise!.add(LstTestSampleWise.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['Tittle'] = tittle;
//     data['PatientName'] = patientName;
//     data['Age'] = age;
//     data['Gendercode'] = gendercode;
//     data['ServicesName'] = servicesName;
//     data['VisitDate'] = visitDate;
//     data['CountTest'] = countTest;
//     data['PhlebotomistID'] = phlebotomistID;
//     data['BookingNo'] = bookingNo;
//     data['BookingID'] = bookingID;
//     data['BookingNumber'] = bookingNumber;
//     data['VisitID'] = visitID;
//     data['PatientID'] = patientID;
//     data['CurrentStatusID'] = currentStatusID;
//     data['CurrentStatusName'] = currentStatusName;
//     data['Latitude'] = latitude;
//     data['Longitude'] = longitude;
//     data['Address'] = address;
//     data['Area'] = area;
//     data['MobileNumber'] = mobileNumber;
//     data['SlotFromTime'] = slotFromTime;
//     data['SlotToTime'] = slotToTime;
//     data['Pincode'] = pincode;
//     data['UserImage'] = userImage;
//     data['CurrencyID'] = currencyID;
//     data['CurrencyCode'] = currencyCode;
//     data['CurrencySymbol'] = currencySymbol;
//     data['TotalServicesAmount'] = totalServicesAmount;
//     data['ClientID'] = clientID;
//     data['PrimaryRefferralType'] = primaryRefferralType;
//     data['DoctorId'] = doctorId;
//     data['IsStart'] = isStart;
//     data['IsPatientPaid'] = isPatientPaid;
//     data['SubjectEncounterNo'] = subjectEncounterNo;
//     if (lstTestDetails != null) {
//       data['lstTestDetails'] =
//           lstTestDetails!.map((v) => v.toJson()).toList();
//     }
//     if (lstTestSampleWise != null) {
//       data['lstTestSampleWise'] =
//           lstTestSampleWise!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class LstTestDetails {
//   int? bookingNo;
//   String? bookingID;
//   String? bookingNumber;
//   int? bookingServicesNo;
//   int? serviceNo;
//   String? serviceType;
//   String? testName;
//   Null? sample;
//   Null? container;
//   double? amount;
//   String? currencyID;
//   String? currencyCode;
//   String? currencySymbol;
//   String? phileBotomyID;
//   bool? isPatientPaid;
//
//   LstTestDetails(
//       {this.bookingNo,
//         this.bookingID,
//         this.bookingNumber,
//         this.bookingServicesNo,
//         this.serviceNo,
//         this.serviceType,
//         this.testName,
//         this.sample,
//         this.container,
//         this.amount,
//         this.currencyID,
//         this.currencyCode,
//         this.currencySymbol,
//         this.phileBotomyID,
//         this.isPatientPaid});
//
//   LstTestDetails.fromJson(Map<String, dynamic> json) {
//     bookingNo = json['BookingNo'];
//     bookingID = json['BookingID'];
//     bookingNumber = json['BookingNumber'];
//     bookingServicesNo = json['BookingServicesNo'];
//     serviceNo = json['ServiceNo'];
//     serviceType = json['ServiceType'];
//     testName = json['TestName'];
//     sample = json['Sample'];
//     container = json['Container'];
//     amount = json['Amount'];
//     currencyID = json['CurrencyID'];
//     currencyCode = json['CurrencyCode'];
//     currencySymbol = json['CurrencySymbol'];
//     phileBotomyID = json['PhileBotomyID'];
//     isPatientPaid = json['IsPatientPaid'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['BookingNo'] = bookingNo;
//     data['BookingID'] = bookingID;
//     data['BookingNumber'] = bookingNumber;
//     data['BookingServicesNo'] = bookingServicesNo;
//     data['ServiceNo'] = serviceNo;
//     data['ServiceType'] = serviceType;
//     data['TestName'] = testName;
//     data['Sample'] = sample;
//     data['Container'] = container;
//     data['Amount'] = amount;
//     data['CurrencyID'] = currencyID;
//     data['CurrencyCode'] = currencyCode;
//     data['CurrencySymbol'] = currencySymbol;
//     data['PhileBotomyID'] = phileBotomyID;
//     data['IsPatientPaid'] = isPatientPaid;
//     return data;
//   }
// }
//
// class LstTestSampleWise {
//   int? bookingNo;
//   String? bookingID;
//   String? bookingNumber;
//   int? bookingServicesNo;
//   int? serviceNo;
//   String? serviceType;
//   String? testName;
//   String? sample;
//   String? container;
//   double? amount;
//   Null? currencyID;
//   Null? currencyCode;
//   Null? currencySymbol;
//   Null? phileBotomyID;
//   bool? isPatientPaid;
//
//   LstTestSampleWise(
//       {this.bookingNo,
//         this.bookingID,
//         this.bookingNumber,
//         this.bookingServicesNo,
//         this.serviceNo,
//         this.serviceType,
//         this.testName,
//         this.sample,
//         this.container,
//         this.amount,
//         this.currencyID,
//         this.currencyCode,
//         this.currencySymbol,
//         this.phileBotomyID,
//         this.isPatientPaid});
//
//   LstTestSampleWise.fromJson(Map<String, dynamic> json) {
//     bookingNo = json['BookingNo'];
//     bookingID = json['BookingID'];
//     bookingNumber = json['BookingNumber'];
//     bookingServicesNo = json['BookingServicesNo'];
//     serviceNo = json['ServiceNo'];
//     serviceType = json['ServiceType'];
//     testName = json['TestName'];
//     sample = json['Sample'];
//     container = json['Container'];
//     amount = json['Amount'];
//     currencyID = json['CurrencyID'];
//     currencyCode = json['CurrencyCode'];
//     currencySymbol = json['CurrencySymbol'];
//     phileBotomyID = json['PhileBotomyID'];
//     isPatientPaid = json['IsPatientPaid'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['BookingNo'] = bookingNo;
//     data['BookingID'] = bookingID;
//     data['BookingNumber'] = bookingNumber;
//     data['BookingServicesNo'] = bookingServicesNo;
//     data['ServiceNo'] = serviceNo;
//     data['ServiceType'] = serviceType;
//     data['TestName'] = testName;
//     data['Sample'] = sample;
//     data['Container'] = container;
//     data['Amount'] = amount;
//     data['CurrencyID'] = currencyID;
//     data['CurrencyCode'] = currencyCode;
//     data['CurrencySymbol'] = currencySymbol;
//     data['PhileBotomyID'] = phileBotomyID;
//     data['IsPatientPaid'] = isPatientPaid;
//     return data;
//   }
// }