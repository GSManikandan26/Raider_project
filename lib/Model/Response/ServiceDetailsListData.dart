class ServiceDetailsListData {
  int? status;
  String? message;
  Null? latitude;
  Null? longitude;
  List<LstTestsAndServices>? lstTestsAndServices;
  ClientCreditLimits? clientCreditLimits;

  ServiceDetailsListData(
      {this.status,
        this.message,
        this.latitude,
        this.longitude,
        this.lstTestsAndServices,
        this.clientCreditLimits});

  ServiceDetailsListData.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    if (json['lstTestsAndServices'] != null) {
      lstTestsAndServices = <LstTestsAndServices>[];
      json['lstTestsAndServices'].forEach((v) {
        lstTestsAndServices!.add(new LstTestsAndServices.fromJson(v));
      });
    }
    clientCreditLimits = json['ClientCreditLimits'] != null
        ? ClientCreditLimits.fromJson(json['ClientCreditLimits'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    if (this.lstTestsAndServices != null) {
      data['lstTestsAndServices'] =
          this.lstTestsAndServices!.map((v) => v.toJson()).toList();
    }
    if (this.clientCreditLimits != null) {
      data['ClientCreditLimits'] = this.clientCreditLimits!.toJson();
    }
    return data;
  }
}

class LstTestsAndServices {
  String? serviceID;
  int? serviceNo;
  String? serviceCode;
  String? serviceName;
  double? serviceAmount;
  String? serviceType;
  String? priceListID;
  int? priceListNo;
  String? serviceContents;
  bool? isFasting;
  String? remarks;
  String? serviceCategory;
  int? serviceCount;
  bool? isMyCart;
  String? currencyID;
  String? currencyCode;
  String? currencySymbol;

  LstTestsAndServices(
      {this.serviceID,
        this.serviceNo,
        this.serviceCode,
        this.serviceName,
        this.serviceAmount,
        this.serviceType,
        this.priceListID,
        this.priceListNo,
        this.serviceContents,
        this.isFasting,
        this.remarks,
        this.serviceCategory,
        this.serviceCount,
        this.isMyCart,
        this.currencyID,
        this.currencyCode,
        this.currencySymbol});

  LstTestsAndServices.fromJson(Map<String, dynamic> json) {
    serviceID = json['ServiceID'];
    serviceNo = json['ServiceNo'];
    serviceCode = json['ServiceCode'];
    serviceName = json['ServiceName'];
    serviceAmount = json['ServiceAmount'];
    serviceType = json['ServiceType'];
    priceListID = json['PriceListID'];
    priceListNo = json['PriceListNo'];
    serviceContents = json['ServiceContents'];
    isFasting = json['IsFasting'];
    remarks = json['Remarks'];
    serviceCategory = json['ServiceCategory'];
    serviceCount = json['ServiceCount'];
    isMyCart = json['isFasting'];  //IsMyCart
    currencyID = json['CurrencyID'];
    currencyCode = json['CurrencyCode'];
    currencySymbol = json['CurrencySymbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServiceID'] = this.serviceID;
    data['ServiceNo'] = this.serviceNo;
    data['ServiceCode'] = this.serviceCode;
    data['ServiceName'] = this.serviceName;
    data['ServiceAmount'] = this.serviceAmount;
    data['ServiceType'] = this.serviceType;
    data['PriceListID'] = this.priceListID;
    data['PriceListNo'] = this.priceListNo;
    data['ServiceContents'] = this.serviceContents;
    data['IsFasting'] = this.isFasting;
    data['Remarks'] = this.remarks;
    data['ServiceCategory'] = this.serviceCategory;
    data['ServiceCount'] = this.serviceCount;
    data['isFasting'] = this.isMyCart; // IsMyCart
    data['CurrencyID'] = this.currencyID;
    data['CurrencyCode'] = this.currencyCode;
    data['CurrencySymbol'] = this.currencySymbol;
    return data;
  }
}

class ClientCreditLimits {
  double? billAmount;
  double? discountAmount;
  double? netBilledAmount;
  double? billPaidAmount;
  double? billPaidRefundAmount;
  double? billCanceledValue;
  double? totalInvoicedAmount;
  String? lastInvoiceGenerationDate;
  double? invoicePaidAmount;
  String? lastInvoicePaymentDate;
  double? invoiceAdvance;
  double? invoiceDiscount;
  double? creditLimit;
  double? additionalLimit;
  double? actualCreditLimt;
  double? actualAdditionalLimit;
  double? totalPaid;
  double? cashInHand;
  String? customerType;
  int? blockingStatus;
  bool? allowBilling;
  bool? allowDispatch;
  int? creditPeriod;
  bool? iscashclient;
  String? custype;
  bool? isFranchise;

  ClientCreditLimits(
      {this.billAmount,
        this.discountAmount,
        this.netBilledAmount,
        this.billPaidAmount,
        this.billPaidRefundAmount,
        this.billCanceledValue,
        this.totalInvoicedAmount,
        this.lastInvoiceGenerationDate,
        this.invoicePaidAmount,
        this.lastInvoicePaymentDate,
        this.invoiceAdvance,
        this.invoiceDiscount,
        this.creditLimit,
        this.additionalLimit,
        this.actualCreditLimt,
        this.actualAdditionalLimit,
        this.totalPaid,
        this.cashInHand,
        this.customerType,
        this.blockingStatus,
        this.allowBilling,
        this.allowDispatch,
        this.creditPeriod,
        this.iscashclient,
        this.custype,
        this.isFranchise});

  ClientCreditLimits.fromJson(Map<String, dynamic> json) {
    billAmount = json['BillAmount'];
    discountAmount = json['DiscountAmount'];
    netBilledAmount = json['NetBilledAmount'];
    billPaidAmount = json['BillPaidAmount'];
    billPaidRefundAmount = json['BillPaidRefundAmount'];
    billCanceledValue = json['BillCanceledValue'];
    totalInvoicedAmount = json['TotalInvoicedAmount'];
    lastInvoiceGenerationDate = json['LastInvoiceGenerationDate'];
    invoicePaidAmount = json['InvoicePaidAmount'];
    lastInvoicePaymentDate = json['LastInvoicePaymentDate'];
    invoiceAdvance = json['InvoiceAdvance'];
    invoiceDiscount = json['InvoiceDiscount'];
    creditLimit = json['CreditLimit'];
    additionalLimit = json['AdditionalLimit'];
    actualCreditLimt = json['ActualCreditLimt'];
    actualAdditionalLimit = json['ActualAdditionalLimit'];
    totalPaid = json['TotalPaid'];
    cashInHand = json['CashInHand'];
    customerType = json['CustomerType'];
    blockingStatus = json['BlockingStatus'];
    allowBilling = json['AllowBilling'];
    allowDispatch = json['AllowDispatch'];
    creditPeriod = json['CreditPeriod'];
    iscashclient = json['Iscashclient'];
    custype = json['Custype'];
    isFranchise = json['IsFranchise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BillAmount'] = this.billAmount;
    data['DiscountAmount'] = this.discountAmount;
    data['NetBilledAmount'] = this.netBilledAmount;
    data['BillPaidAmount'] = this.billPaidAmount;
    data['BillPaidRefundAmount'] = this.billPaidRefundAmount;
    data['BillCanceledValue'] = this.billCanceledValue;
    data['TotalInvoicedAmount'] = this.totalInvoicedAmount;
    data['LastInvoiceGenerationDate'] = this.lastInvoiceGenerationDate;
    data['InvoicePaidAmount'] = this.invoicePaidAmount;
    data['LastInvoicePaymentDate'] = this.lastInvoicePaymentDate;
    data['InvoiceAdvance'] = this.invoiceAdvance;
    data['InvoiceDiscount'] = this.invoiceDiscount;
    data['CreditLimit'] = this.creditLimit;
    data['AdditionalLimit'] = this.additionalLimit;
    data['ActualCreditLimt'] = this.actualCreditLimt;
    data['ActualAdditionalLimit'] = this.actualAdditionalLimit;
    data['TotalPaid'] = this.totalPaid;
    data['CashInHand'] = this.cashInHand;
    data['CustomerType'] = this.customerType;
    data['BlockingStatus'] = this.blockingStatus;
    data['AllowBilling'] = this.allowBilling;
    data['AllowDispatch'] = this.allowDispatch;
    data['CreditPeriod'] = this.creditPeriod;
    data['Iscashclient'] = this.iscashclient;
    data['Custype'] = this.custype;
    data['IsFranchise'] = this.isFranchise;
    return data;
  }
}