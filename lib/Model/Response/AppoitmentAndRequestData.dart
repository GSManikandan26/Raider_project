


class AppointmentAndRequestData {
  List<LstPatientResponse>? lstPatientResponse;
  int? status;
  String? message;
  int? totalCountTest;

  AppointmentAndRequestData(
      {this.lstPatientResponse,
        this.status,
        this.message,
        this.totalCountTest});

  AppointmentAndRequestData.fromJson(Map<String, dynamic> json) {
    if (json['lstPatientResponse'] != null) {
      lstPatientResponse = <LstPatientResponse>[];
      json['lstPatientResponse'].forEach((v) {
        lstPatientResponse!.add(new LstPatientResponse.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    totalCountTest = json['totalCountTest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstPatientResponse != null) {
      data['lstPatientResponse'] =
          this.lstPatientResponse!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalCountTest'] = this.totalCountTest;
    return data;
  }
}

class LstPatientResponse {
  int? bookingNo;
  String? bookingId;
  String? patientName;
  String? age;
  String? gender;
  String? mobileNumber;
  String? address;
  String? area;
  String? pincode;
  String? latitude;
  String? longitude;
  String? testNames;
  int? noofTest;
  String? registeredDateTime;
  int? patientNo;
  int? patientVisitNo;
  int? currentStatusNo;
  String? currentStatusName;
  String? fromSlot;
  String? toSlot;
  String? userImage;
  double? totalTestAmount;
  int? physicianNo;
  bool? isStart;
  bool? isPaid;
  int? userNo;
  int? venueNo;
  int? venueBranchNo;
  List<LstTestDetails>? lstTestDetails;
  List<LstTestSampleWise>? lstTestSampleWise;

  LstPatientResponse(
      {this.bookingNo,
        this.bookingId,
        this.patientName,
        this.age,
        this.gender,
        this.mobileNumber,
        this.address,
        this.area,
        this.pincode,
        this.latitude,
        this.longitude,
        this.testNames,
        this.noofTest,
        this.registeredDateTime,
        this.patientNo,
        this.patientVisitNo,
        this.currentStatusNo,
        this.currentStatusName,
        this.fromSlot,
        this.toSlot,
        this.userImage,
        this.totalTestAmount,
        this.physicianNo,
        this.isStart,
        this.isPaid,
        this.userNo,
        this.venueNo,
        this.venueBranchNo,
        this.lstTestDetails,
        this.lstTestSampleWise});

  LstPatientResponse.fromJson(Map<String, dynamic> json) {
    bookingNo = json['bookingNo'];
    bookingId = json['bookingId'];
    patientName = json['patientName'];
    age = json['age'];
    gender = json['gender'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    area = json['area'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    testNames = json['testNames'];
    noofTest = json['noofTest'];
    registeredDateTime = json['registeredDateTime'];
    patientNo = json['patientNo'];
    patientVisitNo = json['patientVisitNo'];
    currentStatusNo = json['currentStatusNo'];
    currentStatusName = json['currentStatusName'];
    fromSlot = json['fromSlot'];
    toSlot = json['toSlot'];
    userImage = json['userImage'];
    totalTestAmount = json['totalTestAmount'];
    physicianNo = json['physicianNo'];
    isStart = json['isStart'];
    isPaid = json['isPaid'];
    userNo = json['userNo'];
    venueNo = json['venueNo'];
    venueBranchNo = json['venueBranchNo'];
    if (json['lstTestDetails'] != null) {
      lstTestDetails = <LstTestDetails>[];
      json['lstTestDetails'].forEach((v) {
        lstTestDetails!.add(new LstTestDetails.fromJson(v));
      });
    }
    if (json['lstTestSampleWise'] != null) {
      lstTestSampleWise = <LstTestSampleWise>[];
      json['lstTestSampleWise'].forEach((v) {
        lstTestSampleWise!.add(new LstTestSampleWise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingNo'] = this.bookingNo;
    data['bookingId'] = this.bookingId;
    data['patientName'] = this.patientName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['area'] = this.area;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['testNames'] = this.testNames;
    data['noofTest'] = this.noofTest;
    data['registeredDateTime'] = this.registeredDateTime;
    data['patientNo'] = this.patientNo;
    data['patientVisitNo'] = this.patientVisitNo;
    data['currentStatusNo'] = this.currentStatusNo;
    data['currentStatusName'] = this.currentStatusName;
    data['fromSlot'] = this.fromSlot;
    data['toSlot'] = this.toSlot;
    data['userImage'] = this.userImage;
    data['totalTestAmount'] = this.totalTestAmount;
    data['physicianNo'] = this.physicianNo;
    data['isStart'] = this.isStart;
    data['isPaid'] = this.isPaid;
    data['userNo'] = this.userNo;
    data['venueNo'] = this.venueNo;
    data['venueBranchNo'] = this.venueBranchNo;
    if (this.lstTestDetails != null) {
      data['lstTestDetails'] =
          this.lstTestDetails!.map((v) => v.toJson()).toList();
    }
    if (this.lstTestSampleWise != null) {
      data['lstTestSampleWise'] =
          this.lstTestSampleWise!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstTestDetails {
  int? bookingNo;
  String? bookingId;
  int? testNo;
  String? testCode;
  String? testType;
  String? testName;
  int? sampleNo;
  String? sampleName;
  String? containerName;
  double? amount;

  LstTestDetails(
      {this.bookingNo,
        this.bookingId,
        this.testNo,
        this.testCode,
        this.testType,
        this.testName,
        this.sampleNo,
        this.sampleName,
        this.containerName,
        this.amount});

  LstTestDetails.fromJson(Map<String, dynamic> json) {
    bookingNo = json['bookingNo'];
    bookingId = json['bookingId'];
    testNo = json['serviceNo'];
    testNo = json['testNo'];
    testCode = json['testCode'];
    testType = json['testType'];
    testName = json['testName'];
    sampleNo = json['sampleNo'];
    sampleName = json['sampleName'];
    containerName = json['containerName'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingNo'] = this.bookingNo;
    data['bookingId'] = this.bookingId;
    data['serviceNo'] = this.testNo;
    data['testNo'] = this.testNo;
    data['testCode'] = this.testCode;
    data['testType'] = this.testType;
    data['testName'] = this.testName;
    data['sampleNo'] = this.sampleNo;
    data['sampleName'] = this.sampleName;
    data['containerName'] = this.containerName;
    data['amount'] = this.amount;
    return data;
  }
}

class LstTestSampleWise {
  int? bookingNo;
  String? bookingId;
  int? testNo;
  String? testCode;
  String? testType;
  String? testName;
  int? sampleNo;
  String? sampleName;
  String? containerName;
  double? amount;

  LstTestSampleWise(
      {this.bookingNo,
        this.bookingId,
        this.testNo,
        this.testCode,
        this.testType,
        this.testName,
        this.sampleNo,
        this.sampleName,
        this.containerName,
        this.amount});

  LstTestSampleWise.fromJson(Map<String, dynamic> json) {
    bookingNo = json['bookingNo'];
    bookingId = json['bookingId'];
    testNo = json['testNo'];
    testCode = json['testCode'];
    testType = json['testType'];
    testName = json['testName'];
    sampleNo = json['sampleNo'];
    sampleName = json['sampleName'];
    containerName = json['containerName'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingNo'] = this.bookingNo;
    data['bookingId'] = this.bookingId;
    data['testNo'] = this.testNo;
    data['testCode'] = this.testCode;
    data['testType'] = this.testType;
    data['testName'] = this.testName;
    data['sampleNo'] = this.sampleNo;
    data['sampleName'] = this.sampleName;
    data['containerName'] = this.containerName;
    data['amount'] = this.amount;
    return data;
  }
}