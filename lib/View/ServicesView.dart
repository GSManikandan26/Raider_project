import 'package:botbridge_green/Model/Response/ServiceDataNew.dart';
import 'package:botbridge_green/Model/ServerURL.dart';
import 'package:botbridge_green/Utils/LocalDB.dart';
import 'package:botbridge_green/Utils/NavigateController.dart';
import 'package:botbridge_green/View/Helper/ThemeCard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Model/ApiClient.dart';
import '../Model/ApiResponse.dart';
import '../Model/Response/AppoitmentAndRequestData.dart';
import '../Model/Status.dart';
import '../ViewModel/BookedServiceVM.dart';
import '../ViewModel/ServiceDetailsVM.dart';
import 'Helper/LoadingIndicator.dart';

class ServicesListView extends StatefulWidget {
  final String BookingID;
  final String serviceType;
  final String bookingType;
  final String refID;
  final String searchkey;
  const ServicesListView({Key? key, required this.serviceType, required this.BookingID, required this.refID, required this.bookingType,required this.searchkey}) : super(key: key);

  @override
  _ServicesListViewState createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  final ServiceDetailsVM _api = ServiceDetailsVM();

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  bool value = false;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    // Map<String, dynamic> params = {
    //   "SearchType": widget.serviceType,
    //   "ServiceNameSearch": widget.searchkey,
    //   "venueNo": 1,
    //   "venueBranchNo": 1,
    //   "clientNo": 1,
    //   "physicianNo": 0,
    //   "serviceName": "",
    //   "pageIndex": 1
    // };
    // if(widget.refID.isNotEmpty) {
    //   params["CustomerID"] =widget.refID;
    // }
    // _api.fetchServiceDetails(params);

    fetchData(false);
    super.initState();
  }

  fetchData(isNewPage) async{
    ServiceDetailsVM model =
    Provider.of<ServiceDetailsVM>(context, listen: false);

    Map<String, dynamic> params = {
      "SearchType": model.getsearchkey,//widget.serviceType,
      "serviceName": widget.serviceType,//widget.searchkey,
      "clientNo": 0,
      "physicianNo": 0,
      "pageIndex": model.getNextPage //model.nextPage
    };
    print("pageIndex");
    print(model.getNextPage);
    if (widget.refID.isNotEmpty) {
      params["CustomerID"] = widget.refID;
    }
    if (isNewPage) {
      _api.fetchServiceDetailsNext(params, model);
    } else {
      _api.fetchServiceDetails(params, model,"");
    }
  }


  @override
  Widget build(BuildContext context) {
    BookedServiceVM testCount = Provider.of<BookedServiceVM>(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor:const Color(0xffEFEFEF),
      body: Consumer<ServiceDetailsVM>(builder: (context, viewModel, _) {
        switch (viewModel.getAddToCart.status) {
          case Status.Loading:
            print("load Open");
            return  const Center(child: CircularProgressIndicator(color: Colors.orange,));
          case Status.Error:
            return  const Center(child: Center(child: Text("No Record Found",style: TextStyle(fontWeight: FontWeight.bold),),));
          case Status.Completed:
            print("View Open");
          // updateData();
          //   List<LstTestsAndServices> tests = widget.serviceType == "" ?viewModel.getAddToCart.data!.lstTestsAndServices!.toList() : viewModel.getAddToCart.data!.lstTestsAndServices!.where((element) => element.serviceType==widget.serviceType).toList();
            List<LstService> tests = viewModel.getListData.toList();
            return  Scaffold(
              body: SmartRefresher(
                controller: _refreshController,
                enablePullDown: false,
                enablePullUp: true,
                onRefresh: () {},
                onLoading: () {
                  setState(() {
                    value = false;
                    page = viewModel.nextPage;
                  });
                  fetchData(true).then((value) {
                    print("load completed");
                    _refreshController.loadComplete();
                  });
                },
                child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tests.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {
                           addService(tests,index,height,width );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height * 0.1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(17)),
                            child: Stack(
                              children: [
                                Positioned(
                                    right: width * 0.0,
                                    bottom: height * 0.0,
                                    child: Image.asset(
                                      'assets/images/side_illustrate.png',
                                      height: height * 0.05,
                                      color:
                                      const Color(0xff182893),
                                    )),
                                Positioned(
                                  left: width * 0.03,
                                  top: height * 0.026,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                        Colors.white,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              4.0),
                                          child: Image.asset(
                                            'assets/images/testube.png',
                                            height: height * 0.06,
                                            color: const Color(
                                                0xff182893),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.175,
                                  top: height * 0.016,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width * 0.65,
                                        child:
                                        //Text(tests[index].testName.toString(),style:  TextStyle(color: tests[index].isMyCart == true ? const Color(0xff203298) :Colors.grey,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,maxLines: 1,),
                                        Text(
                                          tests[index]
                                              .testName
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight:
                                              FontWeight.w600),
                                          overflow:
                                          TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.004,
                                      ),
                                      Text(
                                        tests[index]
                                            .testCode
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.175,
                                  bottom: height * 0.003,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tests[index]
                                            .testType
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: height * 0.066,
                                  right: width * 0.05,
                                  child:  Text(
                                    tests[index]
                                        .amount
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ),
                                Positioned(
                                  top: height * 0.02,
                                  right: width * 0.05,
                                  child: tests[index].isMyCart == true ? Text(
                                    "Added",
                                    style: const TextStyle(
                                        fontSize: 12),
                                  ) : Icon(
                                    Icons.add,
                                    color: Color(0xff203298),
                                    size: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
        // viewModel.getAddToCart.data!.lstCartDetailsGet!.isEmpty ? Center(child: Image.asset("assets/images/empty_box.png",height: 170,),) :

          default:
        }
        print("my service return");
        return Container();
      }),



    ));
  }

  //addCertificatePOPUP
  Widget successStatusPOPUP(BuildContext context,height,width){

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height:height * 0.25,
          width: width * 0.89,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0)
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CircleAvatar(
                radius: 20,
                backgroundColor: CustomTheme.circle_green,
                child: const Center(
                  child: Icon(Icons.done,color: Colors.white,),
                ),
              ),
              const SizedBox(height: 10),
              const Text("New Service Added Successfully",style: TextStyle(color:Colors.black54,fontSize: 18),),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      NavigateController.pagePOP(context);
                    },
                    child: const Center(
                      child: Text( "Add another service",style: TextStyle(color:Color(0xff2454FF),fontSize: 15,fontWeight: FontWeight.w600),),
                    ),
                  ),
                  SizedBox(width: width * 0.03),
                  InkWell(
                    onTap: (){
                      NavigateController.pagePOP(context);
                      NavigateController.pagePOP(context);
                    },
                    child: const Center(
                      child: Text( "Back",style: TextStyle(color: Colors.black54,fontSize: 15),),
                    ),
                  ),
                  SizedBox(width: width * 0.12),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  //addCertificatePOPUP
  Widget addServicesPOPUP(BuildContext context,height,width){
    Color textBorder = const Color(0xff0272B1);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height:height * 0.22,
          width: width * 0.89,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0)
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 10),
              const Text("New Service Added Successfully",style: TextStyle(color:Colors.black54,fontSize: 18),),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      NavigateController.pagePOP(context);
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => successStatusPOPUP(context,height,width)
                      );
                      NavigateController.pagePOP(context);
                    },
                    child: const Center(
                      child: Text( "yes",style: TextStyle(color:Color(0xff2454FF),fontSize: 15,fontWeight: FontWeight.w600),),
                    ),
                  ),
                  SizedBox(width: width * 0.03),
                  InkWell(
                    onTap: (){
                      NavigateController.pagePOP(context);
                      NavigateController.pagePOP(context);
                    },
                    child: const Center(
                      child: Text( "No",style: TextStyle(color: Colors.black54,fontSize: 15),),
                    ),
                  ),
                  SizedBox(width: width * 0.12),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  addService(List<LstService> data,index,height,width ) async {

    print("start --------------");
    print(data[index].testNo);
    scrollIndicator( context, height, width);
    var venueNo = await LocalDB.getLDB("venueNo") ?? "";
    var venueBranchNo = await LocalDB.getLDB("venueBranchNo") ?? "";
    // params["venueNo"] = venueNo; //MainData.tenantNo;
    // params["venueBranchNo"] = venueBranchNo;
    LocalDB.getLDB('userID').then((value) {
      print("my booking ${widget.bookingType} --------------");

      if(widget.bookingType == "NewBooking"){

        BookedServiceVM model = Provider.of<BookedServiceVM>(context, listen: false);

        // try{
        Navigator.pop(context);

          var data1 = data[index].toJson();
        model.addTestForNewBook = {
          //"serviceNo": data[index].testNo,
          "testNo": data[index].testNo,
          "testCode": data[index].testCode,
          "testName": data[index].testName,
          "testType": data[index].testType,
          "isFasting": true, // // isMyCart
          "remarks": ""
        };
          var ModelData = model.getBookedService.data!.toJson();
          print(ModelData);
          var addTotal = ModelData;
        addTotal["lstPatientResponse"][0]["lstTestDetails"].add(data1);
        print(addTotal);
          print("new Book --------------");
        print(addTotal);
          print(addTotal["lstPatientResponse"][0]["lstTestDetails"]);
          final jsonData = AppointmentAndRequestData.fromJson(addTotal);
          model.setBookedService( ApiResponse.completed(jsonData));
        // }catch(e){
        //   Navigator.pop(context);
        //   print(e)
        // }
        Fluttertoast.showToast(
            msg: "Added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 14.0
        );

      }else{

          Map<String,dynamic> params1 =
          {
            "bookingID": widget.BookingID,
            "userNo": value,
            "venueNo": venueNo,
            "venueBranchNo": venueBranchNo,
            "lstCartList": [
              {
                //"serviceNo": data[index].testNo,
                "testNo": data[index].testNo,
                "testCode": data[index].testCode,
                "testName": data[index].testName,
                "testType": data[index].testType,
                "isFasting": true, // // isMyCart
                "remarks": ""
              }
            ]
          };
          // {
          //   "PhileBotomyID": value,
          //   "BookingID": widget.BookingID,
          //   "lstCartList": [
          //     {
          //       "ServiceNo": data[index].serviceNo,
          //       "ServiceCode": data[index].serviceCode,
          //       "ServiceType": data[index].serviceType,
          //       "IsFasting": data[index].isFasting,
          //       "Remarks": "NIL"
          //     }
          //   ]
          // };


        print(data);


        ApiClient().fetchData(ServerURL().getUrl(RequestType.AddNewTest), params1).then((value){
          print("newtest response $value");
          if (value["status"] == 1 ) {
            Fluttertoast.showToast(
                msg: "Added",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 14.0
            );

            BookedServiceVM model = Provider.of<BookedServiceVM>(context, listen: false);
            LocalDB.getLDB('userID').then((value) {
              Map<String,dynamic> params = {
                "userNo":value,
                "bookingID":widget.BookingID,
                "type":widget.serviceType,
                "Latitude": "37.4219983",
                "Longitude": "-122.084"
              };
              model.fetchBookedService(params, model,false).then((value){
                Navigator.pop(context);
                // showAddTest(context, width,widget.BookingID,testList.getBookedService.status!.toInt(),widget.BookingType);
              });

            });
          }


        });
      }


    });
  }
}
