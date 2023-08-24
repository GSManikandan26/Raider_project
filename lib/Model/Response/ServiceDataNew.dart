class ServiceDataNew {
  int? status;
  String? message;
  List<LstService>? lstService;

  ServiceDataNew({this.status, this.message, this.lstService});

  ServiceDataNew.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['lstService'] != null) {
      lstService = <LstService>[];
      json['lstService'].forEach((v) {
        lstService!.add(LstService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (lstService != null) {
      data['lstService'] = lstService!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstService {
  int? rowno;
  int? testNo;
  String? testCode;
  String? testName;
  String? testType;
  double ? amount;
  bool ? isMyCart;



  LstService(
      {this.rowno, this.testNo, this.testCode, this.testName, this.testType,this.isMyCart});

  LstService.fromJson(Map<String, dynamic> json) {
    rowno = json['row_Num'];
    //testNo = json['testNo'];
    testNo = json['serviceNo'];
    testCode = json['testCode'];
    testName = json['testName'];
    testType = json['testType'];
    amount = json['amount'];
    isMyCart = json['isFasting']; // isMyCart
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['row_Num'] = rowno;
    //data['rowno'] = rowno;
    data['serviceNo'] = testNo;
    //data['testNo'] = testNo;
    data['testCode'] = testCode;
    data['testName'] = testName;
    data['testType'] = testType;
    data['amount'] = amount;
    return data;
  }
}