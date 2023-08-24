class SignData {
  int? status;
  String? message;
  int? userNo;
  String? userName;
  int? venueNo;
  int? venueBranchNo;
  int? isOffline;
  int? isPreprintedBarcode;

  SignData(
      {this.status,
        this.message,
        this.userNo,
        this.userName,
        this.venueNo,
        this.venueBranchNo,
        this.isOffline,
        this.isPreprintedBarcode});

  SignData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userNo = json['userNo'];
    userName = json['userName'];
    venueNo = json['venueNo'];
    venueBranchNo = json['venueBranchNo'];
    isOffline = json['isOffline'];
    isPreprintedBarcode = json['isPreprintedBarcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['userNo'] = this.userNo;
    data['userName'] = this.userName;
    data['venueNo'] = this.venueNo;
    data['venueBranchNo'] = this.venueBranchNo;
    data['isOffline'] = this.isOffline;
    data['isPreprintedBarcode'] = this.isPreprintedBarcode;
    return data;
  }
}