// import 'package:botbridge_green/Model/Response/BookedServiceData.dart';
import 'package:botbridge_green/Model/Response/AppoitmentAndRequestData.dart';
import 'package:botbridge_green/Model/ServerURL.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/ApiClient.dart';
import '../Model/ApiResponse.dart';
import '../Model/Status.dart';
import '../Utils/LocalDB.dart';
import '../Utils/NavigateController.dart';
import '../ViewModel/BookedServiceVM.dart';
import 'Helper/ErrorPopUp.dart';
import 'Helper/ThemeCard.dart';
import 'PaymentView.dart';
import 'TabbarView.dart';




class AddToCartView extends StatefulWidget {
  final String bookingType;
  final String userID;
  const AddToCartView({Key? key, required this.bookingType, required this.userID}) : super(key: key);

  @override
  _AddToCartViewState createState() => _AddToCartViewState();
}

class _AddToCartViewState extends State<AddToCartView> {

  String? userNo;
  bool isFetching = true;
  ScrollController control = ScrollController();
  bool floatingButtonVisible = false;
  String? selectedGender;
  String? selectedReferral;
  String? screentype;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.bookingType);
    LocalDB.getLDB('userID').then((value) {
      setState(() {
        userNo = value;
      });

      Map<String,dynamic> params1 = {
        "bookingID": widget.userID,
        "userNo":value,
        "type": widget.bookingType,
        "Latitude":"37.4219983",
        "Longitude":"-122.084"
      };

      if (widget.bookingType == "NewBooking") {
          print("NEW Booking");
          setState(() {
            isFetching = false;
          });
      } else {
        BookedServiceVM model = Provider.of<BookedServiceVM>(context, listen: false);
        model.fetchBookedService(params1, model,false).then((value){
          setState(() {
            isFetching = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BookedServiceVM testCount = Provider.of<BookedServiceVM>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffEFEFEF),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.1,
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.08,
                        width: width,
                        decoration: BoxDecoration(
                            color: CustomTheme.background_green,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(height * 0.6/25))
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: width * 0.02,
                              top: height * 0.02,
                              child: GestureDetector(
                                  onTap: (){
                                    print('Start');
                                    NavigateController.pagePOP(context);
                                  },
                                  child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                            ),
                            const Align(
                              alignment: Alignment.center,
                              child: Text("Add Cart",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                            ),
                            Positioned(
                              right: width * 0.02,
                              top: height * 0.02,
                              child: GestureDetector(
                                  onTap: (){
                                    NavigateController.pagePush(context,  SearchTests(BookingID: widget.userID, referalID: '', bookingType: widget.bookingType,));
                                      // var refID = testCount.getBookedService.data!.lstPhileBotomyAppointmentAndRequest![0].primaryReffflerralType.toString();
                                      // print(refID);
                                      //
                                      // switch(refID){
                                      //   case "DR":
                                      //     NavigateController.pagePush(context,  SearchTests(BookingID: widget.userID, referalID: testCount.getBookedService.data!.lstPhileBotomyAppointmentAndRequest![0].doctorId.toString(), bookingType: widget.bookingType,));
                                      //     break;
                                      //   case "CLI":
                                      //     NavigateController.pagePush(context,  SearchTests(BookingID: widget.userID, referalID:testCount.getBookedService.data!.lstPhileBotomyAppointmentAndRequest![0].clientID.toString(), bookingType: widget.bookingType,));
                                      //     break;
                                      //   case "HMC":
                                      //     NavigateController.pagePush(context,  SearchTests(BookingID: widget.userID, referalID: '', bookingType: widget.bookingType,));
                                      //     break;
                                      //   default:
                                      //     NavigateController.pagePush(context,  SearchTests(BookingID: widget.userID, referalID: '', bookingType: widget.bookingType,));
                                      //     break;
                                      // }

                                  },
                                  child: const Icon(Icons.add,color: Colors.white,size: 28)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.86,
                  child: SizedBox(
                    width: width * 0.96,
                    child:  Consumer<BookedServiceVM>(builder: (context, viewModel, _) {
                      switch (viewModel.getBookedService.status) {
                        case Status.Loading:
                          return  const Center(child: CircularProgressIndicator());
                        case Status.Error:
                          return  const Text("No Data",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),);
                        case Status.Completed:
                        // updateData();
                          var VM = viewModel.getBookedService.data!;
                          print("Count-----${VM.totalCountTest}-----Count");
                          return
                            VM.lstPatientResponse == null  ?  const SizedBox() :
                            VM.lstPatientResponse!.isEmpty  ?  const SizedBox() :
                            VM.lstPatientResponse![0].lstTestDetails == null ?
                            const SizedBox() :
                            VM.lstPatientResponse![0].lstTestDetails!.isEmpty ?
                            const SizedBox() :
                            Column(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: SizedBox(

                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Flex(
                                            direction: Axis.vertical,
                                            children: [
                                              Scrollbar(
                                                thickness: 50,
                                                child: ListView.builder(
                                                    physics:
                                                    const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: VM.lstPatientResponse![0].lstTestDetails!.length,
                                                    itemBuilder:
                                                        (BuildContext context, index) {
                                                      return Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Stack(
                                                          children: <Widget>[
                                                            InkWell(
                                                              onTap: () {
                                                                // NavigateController.pagePush(context, const PatientDetailsView(screenType: 1,));
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Container(
                                                                  height: height * 0.1,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          17)),
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                          right:width * 0.0,
                                                                          bottom: height * 0.0,
                                                                          child: Image.asset('assets/images/side_illustrate.png',height: height*0.05,color:  const Color(0xff182893),)
                                                                      ),
                                                                      Positioned(
                                                                        left:width * 0.03,
                                                                        top: height * 0.026,
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children:   [
                                                                            CircleAvatar(
                                                                              backgroundColor: Colors.white,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(4.0),
                                                                                child: Image.asset('assets/images/testube.png',height: height*0.06,color:  const Color(0xff182893),),
                                                                              ),),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        left:width * 0.175,
                                                                        top: height * 0.016,
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children:  [
                                                                            SizedBox(
                                                                                width:width* 0.65,
                                                                                child: Text(VM.lstPatientResponse![0].lstTestDetails![index].testName.toString(),style: const TextStyle(color: Color(0xff203298),fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                                                            SizedBox(height: height * 0.001,),
                                                                             Text(VM.lstPatientResponse![0].lstTestDetails![index].testNo.toString() == "null" ? "" :VM.lstPatientResponse![0].lstTestDetails![index].testNo.toString(),style: TextStyle(fontSize: 10),),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        left:width * 0.175,
                                                                        bottom: height * 0.003,
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children:   [
                                                                            Text(VM.lstPatientResponse![0].lstTestDetails![index].testType ?? "",style: TextStyle(fontSize: 12),),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        top: height * 0.066 ,
                                                                        right:width * 0.03 ,
                                                                        child: Text(
                                                                          "₹${VM.lstPatientResponse![0].lstTestDetails![index].amount!.toInt()}",
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 14),
                                                                        ),)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            cartCount != 0 ? Positioned(
                                                              right: 10,
                                                              top: 5,
                                                              child: GestureDetector(
                                                                onTap:(){
                                                                  if(widget.bookingType == "NewBooking"){
                                                                    viewModel.getBookedService.data!.lstPatientResponse![0].lstTestDetails!.removeAt(index);
                                                                    final jsonData = AppointmentAndRequestData.fromJson(viewModel.getBookedService.data!.toJson());
                                                                    viewModel.setBookedService(ApiResponse.completed(jsonData));
                                                                  }else{
                                                                    Map<String,dynamic> data = {
                                                                      "bookingID": widget.userID,
                                                                      "bookingTestNo":VM.lstPatientResponse![0].lstTestDetails![index].testNo,
                                                                      "userNo": userNo,
                                                                    };
                                                                    ApiClient().fetchData(ServerURL().getUrl(RequestType.DeleteServiceTest), data).then((value){
                                                                      if(value["status"] == 1) {
                                                                        // BookedServiceVM model = Provider.of<BookedServiceVM>(context, listen: false);

                                                                        // AddToCartListVM model = Provider.of<AddToCartListVM>(context, listen: false);
                                                                        // model.setAddCartMain(ApiResponse.loading());
                                                                        // viewModel.getAddToCart.data!.totalServiceAmount = (viewModel.getAddToCart.data!.totalServiceAmount!.toInt() - viewModel.getAddToCart.data!.lstCartDetailsGet![index].serviceAmount!.toInt()).toDouble();
                                                                        viewModel.getBookedService.data!.lstPatientResponse![0].lstTestDetails!.removeAt(index);
                                                                        final jsonData = AppointmentAndRequestData.fromJson(viewModel.getBookedService.data!.toJson());
                                                                        viewModel.setBookedService(ApiResponse.completed(jsonData));
                                                                        //
                                                                        // Map<String,dynamic> params1 = {
                                                                        //   "PhileBotomyID":phileBotomyID,
                                                                        //   "BookingID":widget.userID,
                                                                        //   "Page":widget.bookingType,
                                                                        //   "Latitude": "",
                                                                        //   "Longitude": ""
                                                                        // };
                                                                        // VM.fetchBookedService(params1, VM);
                                                                      }else{
                                                                        errorPopUp(context);
                                                                      }

                                                                    });
                                                                  }

                                                                  // deleteAlert(  context,viewModel , index);
                                                                },
                                                                child: Container(
                                                                  padding: const EdgeInsets.all(2),
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors.red,
                                                                      shape: BoxShape.circle
                                                                  ),
                                                                  constraints: const BoxConstraints(
                                                                    minWidth: 25,
                                                                    minHeight: 25,
                                                                  ),
                                                                  child: const Center(
                                                                      child:Icon(Icons.clear,color: Colors.white,size: 15,)
                                                                  ),
                                                                ),
                                                              ),
                                                            ) : Container()
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   flex: 0,
                                //   child: SizedBox(
                                //     height: height*0.2,
                                //     child: Column(
                                //       children: [
                                //         const Spacer(),
                                //         InkWell(
                                //           onTap: (){
                                //             // NavigateController.pagePush(context,  PaymentView(bookingID: widget.userID, bookingType: null,));
                                //           },
                                //           child: Visibility(
                                //             visible:false,
                                //             child: Container(
                                //               height: 40,
                                //               width:120,
                                //               decoration: BoxDecoration(
                                //                   color: CustomTheme.background_green,
                                //                   borderRadius: BorderRadius.circular(30),
                                //                   boxShadow: const [
                                //                     BoxShadow(
                                //                         color: Colors.black26,
                                //                         offset: Offset(1,2),
                                //                         blurRadius: 6
                                //                     )
                                //                   ]
                                //               ),
                                //               child: const Center(
                                //                 child: Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //         SizedBox(height: height * 0.03),
                                //       ],
                                //     ),
                                //   ),
                                // )
                              ],
                            );
                      // viewModel.getAddToCart.data!.lstCartDetailsGet!.isEmpty ? Center(child: Image.asset("assets/images/empty_box.png",height: 170,),) :

                        default:
                      }
                      return Container();
                    }),


                  ),
                ),
              ],
            ),
          )

        ));
  }
  deleteAlert( BuildContext context,BookedServiceVM VM,int index){
    return showDialog(context: context, builder: (context){
      return  AlertDialog(
        backgroundColor: CustomTheme.circle_green,
        title:const Text("Are you sure want to remove service ?",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
              onPressed: (){
                Map<String,dynamic> data = {
                  "bookingID": widget.userID,
                  "bookingTestNo":VM.listBookedService.data!.lstPatientResponse![0].lstTestDetails![index].testNo,
                  "userNo": userNo,
                };
                ApiClient().fetchData(ServerURL().getUrl(RequestType.DeleteServiceTest), data).then((value){
                  if(value["Status"] == 1) {
                    // BookedServiceVM model = Provider.of<BookedServiceVM>(context, listen: false);

                    // AddToCartListVM model = Provider.of<AddToCartListVM>(context, listen: false);
                    // model.setAddCartMain(ApiResponse.loading());
                    // viewModel.getAddToCart.data!.totalServiceAmount = (viewModel.getAddToCart.data!.totalServiceAmount!.toInt() - viewModel.getAddToCart.data!.lstCartDetailsGet![index].serviceAmount!.toInt()).toDouble();
                    VM.getBookedService.data!.lstPatientResponse![0].lstTestDetails!.removeAt(index);
                    final jsonData = AppointmentAndRequestData.fromJson(VM.getBookedService.data!.toJson());
                    VM.setBookedService(ApiResponse.completed(jsonData));


                    //
                    // Map<String,dynamic> params1 = {
                    //   "PhileBotomyID":phileBotomyID,
                    //   "BookingID":widget.userID,
                    //   "Page":widget.bookingType,
                    //   "Latitude": "",
                    //   "Longitude": ""
                    // };
                    // VM.fetchBookedService(params1, VM);
                  }else{
                    errorPopUp(context);
                  }

                });
                Navigator.pop(context);
              },
              child:const Text("Yes",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
          TextButton(onPressed: (){


            Navigator.pop(context);
          },
              child:const Text("No",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)))
        ],
        shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),

      );
    }
    );
  }

}
