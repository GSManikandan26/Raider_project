class SampleWiseServiceData {
  int? status;
  String? message;
  List<LstSampleWiseService>? lstSampleWiseService;

  SampleWiseServiceData({this.status, this.message, this.lstSampleWiseService});

  SampleWiseServiceData.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['lstSampleWiseService'] != null) {
      lstSampleWiseService = <LstSampleWiseService>[];
      json['lstSampleWiseService'].forEach((v) {
        lstSampleWiseService!.add(new LstSampleWiseService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.lstSampleWiseService != null) {
      data['lstSampleWiseService'] =
          this.lstSampleWiseService!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstSampleWiseService {
  String? serviceID;
  String? serviceCode;
  String? sampleName;
  int? sampleNo;
  String? sampleID;
  String? containerName;
  int? containerNo;
  String? containerID;
  String? serviceName;
  String? serviceType;
  String? priceListID;

  LstSampleWiseService(
      {this.serviceID,
        this.serviceCode,
        this.sampleName,
        this.sampleNo,
        this.sampleID,
        this.containerName,
        this.containerNo,
        this.containerID,
        this.serviceName,
        this.serviceType,
        this.priceListID});

  LstSampleWiseService.fromJson(Map<String, dynamic> json) {
    serviceID = json['ServiceID'];
    serviceCode = json['ServiceCode'];
    sampleName = json['SampleName'];
    sampleNo = json['SampleNo'];
    sampleID = json['SampleID'];
    containerName = json['ContainerName'];
    containerNo = json['ContainerNo'];
    containerID = json['ContainerID'];
    serviceName = json['ServiceName'];
    serviceType = json['ServiceType'];
    priceListID = json['PriceListID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServiceID'] = this.serviceID;
    data['ServiceCode'] = this.serviceCode;
    data['SampleName'] = this.sampleName;
    data['SampleNo'] = this.sampleNo;
    data['SampleID'] = this.sampleID;
    data['ContainerName'] = this.containerName;
    data['ContainerNo'] = this.containerNo;
    data['ContainerID'] = this.containerID;
    data['ServiceName'] = this.serviceName;
    data['ServiceType'] = this.serviceType;
    data['PriceListID'] = this.priceListID;
    return data;
  }
}