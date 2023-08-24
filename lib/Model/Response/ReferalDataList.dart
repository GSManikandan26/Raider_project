class ReferalData {
  int? status;
  String? message;
  List<LstReferalDetails>? lstReferalDetails;

  ReferalData({this.status, this.message, this.lstReferalDetails});

  ReferalData.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['lstReferalDetails'] != null) {
      lstReferalDetails = <LstReferalDetails>[];
      json['lstReferalDetails'].forEach((v) {
        lstReferalDetails!.add(new LstReferalDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.lstReferalDetails != null) {
      data['lstReferalDetails'] =
          this.lstReferalDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstReferalDetails {
  String? commonID;
  String? commonCode;
  String? commonName;
  int? commonNo;
  String? commonNameCode;

  LstReferalDetails(
      {this.commonID,
        this.commonCode,
        this.commonName,
        this.commonNo,
        this.commonNameCode});

  LstReferalDetails.fromJson(Map<String, dynamic> json) {
    commonID = json['CommonID'];
    commonCode = json['CommonCode'];
    commonName = json['CommonName'];
    commonNo = json['CommonNo'];
    commonNameCode = json['CommonNameCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CommonID'] = this.commonID;
    data['CommonCode'] = this.commonCode;
    data['CommonName'] = this.commonName;
    data['CommonNo'] = this.commonNo;
    data['CommonNameCode'] = this.commonNameCode;
    return data;
  }
}