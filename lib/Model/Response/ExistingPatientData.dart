class ExistsPatientsData {
  int? tenantNo;
  int? tenantBranchNo;
  int? status;
  String? message;
  List<LstExistsPatientInfo>? lstExistsPatientInfo;

  ExistsPatientsData(
      {this.tenantNo,
        this.tenantBranchNo,
        this.status,
        this.message,
        this.lstExistsPatientInfo});

  ExistsPatientsData.fromJson(Map<String, dynamic> json) {
    tenantNo = json['TenantNo'];
    tenantBranchNo = json['TenantBranchNo'];
    status = json['Status'];
    message = json['Message'];
    if (json['lstExistsPatientInfo'] != null) {
      lstExistsPatientInfo = <LstExistsPatientInfo>[];
      json['lstExistsPatientInfo'].forEach((v) {
        lstExistsPatientInfo!.add(new LstExistsPatientInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TenantNo'] = this.tenantNo;
    data['TenantBranchNo'] = this.tenantBranchNo;
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.lstExistsPatientInfo != null) {
      data['lstExistsPatientInfo'] =
          this.lstExistsPatientInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstExistsPatientInfo {
  int? subjectNo;
  String? subjectId;
  String? primaryID;
  String? title;
  String? name;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? dOB;
  String? age;
  String? ageType;
  String? phoneNo;
  String? address;
  String? area;
  String? pincode;
  String? email;

  LstExistsPatientInfo(
      {this.subjectNo,
        this.subjectId,
        this.primaryID,
        this.title,
        this.name,
        this.firstName,
        this.middleName,
        this.lastName,
        this.gender,
        this.dOB,
        this.age,
        this.ageType,
        this.phoneNo,
        this.address,
        this.area,
        this.pincode,
        this.email});

  LstExistsPatientInfo.fromJson(Map<String, dynamic> json) {
    subjectNo = json['SubjectNo'];
    subjectId = json['SubjectId'];
    primaryID = json['PrimaryID'];
    title = json['Title'];
    name = json['Name'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    gender = json['Gender'];
    dOB = json['DOB'];
    age = json['Age'];
    ageType = json['AgeType'];
    phoneNo = json['PhoneNo'];
    address = json['Address'];
    area = json['Area'];
    pincode = json['Pincode'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubjectNo'] = this.subjectNo;
    data['SubjectId'] = this.subjectId;
    data['PrimaryID'] = this.primaryID;
    data['Title'] = this.title;
    data['Name'] = this.name;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['Gender'] = this.gender;
    data['DOB'] = this.dOB;
    data['Age'] = this.age;
    data['AgeType'] = this.ageType;
    data['PhoneNo'] = this.phoneNo;
    data['Address'] = this.address;
    data['Area'] = this.area;
    data['Pincode'] = this.pincode;
    data['Email'] = this.email;
    return data;
  }
}