import 'package:botbridge_green/Utils/LocalDB.dart';
import 'package:botbridge_green/View/AppointmentView.dart';
import 'package:botbridge_green/View/BorcodeView.dart';
import 'package:botbridge_green/View/NewRequestView.dart';
import 'package:botbridge_green/View/PaymentView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MainData.dart';
import '../Model/ApiClient.dart';
import '../Model/Response/AppoitmentAndRequestData.dart';
import '../Model/ServerURL.dart';
import '../Model/Status.dart';
import '../Utils/NavigateController.dart';
import '../ViewModel/BookedServiceVM.dart';
import '../ViewModel/CollectedSamplesVM.dart';
import '../ViewModel/PatientDetailsVM.dart';
import 'AddPrescriptionView.dart';
import 'AddToCartView.dart';
import 'Helper/ErrorPopUp.dart';
import 'Helper/LoadingIndicator.dart';
import 'Helper/ThemeCard.dart';
import 'TabbarView.dart';




class PatientDetailsView extends StatefulWidget {
  final int screenType;
  final String bookingType;
  final String bookingID;
  final Map<String,dynamic> data2;
  const PatientDetailsView({Key? key, required this.screenType, required this.bookingType, required this.bookingID, required this.data2}) : super(key: key);

  @override
  _PatientDetailsViewState createState() => _PatientDetailsViewState();
}

class _PatientDetailsViewState extends State<PatientDetailsView> {

  String? userID;
  //hide String? phileBotomyID;
  bool isFetching = true;
  final PatientDetailsVM _api = PatientDetailsVM();
  ScrollController control = ScrollController();
  bool floatingButtonVisible = false;
  String? selectedGender;
  String? selectedReferral;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.bookingType);
    LocalDB.getLDB('userID').then((value) {
      setState(() {
        userID = value;
      });
      Map<String ,dynamic> params = {
        // "PhileBotomyID":value,
        "bookingID": widget.bookingID,
        "userNo":value,
        "type": widget.bookingType,
        "Latitude":"37.4219983",
        "Longitude":"-122.084"
      };
      _api.fetchPatientDetails(params);

      Map<String,dynamic> params1 = {
        "bookingID": widget.bookingID,
        "userNo":value,
        "type": widget.bookingType,
        "Latitude":"37.4219983",
        "Longitude":"-122.084"
      };
      BookedServiceVM model = Provider.of<BookedServiceVM>(context, listen: false);
      model.fetchBookedService(params1, model,false).then((value){
        setState(() {
          isFetching = false;
        });
      });
    });

  }
  UnderlineInputBorder outline = const UnderlineInputBorder(
      // borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(width: 0,color: Colors.black45)
  );
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffEFEFEF),
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.08,
                        width: width,
                        decoration: BoxDecoration(
                            color: CustomTheme.background_green,
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(height * 0.6 / 25))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: width * 0.02,),
                            InkWell(
                                onTap: () {
                                  if(widget.screenType == 1){
                                    if (kDebugMode) {
                                      print("Appoitment");
                                    }
                                    NavigateController.pagePushLikePop(context,  const AppointmentView());
                                  }else{
                                    NavigateController.pagePOP(context);
                                  }
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                )),
                            const Spacer(),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Patient Details",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                                height: height * 0.05,
                                child: Visibility(
                                    visible: widget.screenType == 1 || widget.screenType == 2,
                                    child: buildSpeedDial(context, height, width))),
                            SizedBox(width: width * 0.02,),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 9,
              child:ChangeNotifierProvider<PatientDetailsVM>(
                create: (BuildContext context) => _api,
                child: Consumer<PatientDetailsVM>(builder: (context, viewModel, _) {
                  switch (viewModel.getPatientDetails.status) {
                    case Status.Loading:
                      return  const Center(child: CircularProgressIndicator());
                    case Status.Error:
                      return  const Text("No Data",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),);
                    case Status.Completed:
                    // updateData();
                      var VM = viewModel.getPatientDetails.data!;
                      return SingleChildScrollView(
                        controller: control,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.03,
                            ),
                            SizedBox(
                              width: width * 0.9,
                              height: height * 0.07,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                cursorColor: Colors.black,
                                readOnly: true,
                                initialValue:VM.lstPatientResponse == null ? "": VM.lstPatientResponse![0].patientName ,
                                style: const TextStyle(color: Colors.black54),
                                decoration: InputDecoration(
                                    // filled: true,
                                    // focusColor: const Color(0xffEFEFEF),
                                    // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                                    enabledBorder: outline,
                                    focusedBorder: outline,
                                    label: const Text(
                                      'Patient Name',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 14),
                                    )),
                              ),
                            ),
                            SizedBox(height: height * 0.013),
                            SizedBox(
                              width: width * 0.9,
                              height: height * 0.07,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                cursorColor: Colors.black,
                                readOnly: true,
                                initialValue:VM.lstPatientResponse == null ? "": VM.lstPatientResponse![0].mobileNumber,
                                style: const TextStyle(color: Colors.black54),
                                decoration: InputDecoration(
                                    // filled: true,
                                    // focusColor: const Color(0xffEFEFEF),
                                    enabledBorder: outline,
                                    focusedBorder:outline,
                                    label: const Text(
                                      'Mobile No',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 14),
                                    )),
                              ),
                            ),
                            SizedBox(height: height * 0.013),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width * 0.4,
                                  height: height * 0.07,
                                  child: TextFormField(
                                    initialValue:VM.lstPatientResponse == null ? "": VM.lstPatientResponse![0].age!.replaceAll('Y', '').isEmpty ? "--" : VM.lstPatientResponse![0].age!.replaceAll('Y', ''),
                                    textInputAction: TextInputAction.next,
                                    readOnly: true,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black54),
                                    decoration: InputDecoration(
                                        // filled: true,
                                        // focusColor: const Color(0xffEFEFEF),
                                        // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                                        enabledBorder: outline,
                                        focusedBorder: outline,
                                        label: const Text(
                                          'Age',
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 14),
                                        )),
                                  ),
                                ),
                                SizedBox(width: width * 0.08),
                                SizedBox(
                                  width: width * 0.4,
                                  height: height * 0.07,
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue:VM.lstPatientResponse == null ? "": VM.lstPatientResponse![0].gender == "Male" ? "Male" : "Female",
                                    textInputAction: TextInputAction.next,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black54),
                                    decoration: InputDecoration(
                                        // filled: true,
                                        // focusColor: const Color(0xffEFEFEF),
                                        // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                                        enabledBorder: outline,
                                        focusedBorder: outline,
                                        label: const Text(
                                          'Gender',
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 14),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.013),
                            SizedBox(
                              width: width * 0.9,
                              height: height * 0.07,
                              child: TextFormField(
                                readOnly: true,
                                textInputAction: TextInputAction.next,
                                cursorColor: Colors.black,
                                initialValue:VM.lstPatientResponse == null ? "": VM.lstPatientResponse![0].address,
                                style: const TextStyle(color: Colors.black54),
                                decoration: InputDecoration(
                                    // filled: true,
                                    // focusColor: const Color(0xffEFEFEF),
                                    // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                                    enabledBorder: outline,
                                    focusedBorder: outline,
                                    label: const Text(
                                      'Address*',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 14),
                                    )),
                              ),
                            ),
                            SizedBox(height: height * 0.013),
                            SizedBox(
                              width: width * 0.9,
                              height: height * 0.07,
                              child: TextFormField(
                                readOnly: true,
                                initialValue:VM.lstPatientResponse == null ? "": VM.lstPatientResponse![0].registeredDateTime,
                                textInputAction: TextInputAction.next,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black54),
                                decoration: InputDecoration(
                                    // filled: true,
                                    // focusColor: const Color(0xffEFEFEF),
                                    // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                                    enabledBorder: outline,
                                    focusedBorder: outline,
                                    label: const Text(
                                      'Scheduled on',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 14),
                                    )),
                              ),
                            ),
                            SizedBox(height: height * 0.013),
                            SizedBox(
                              width: width * 0.9,
                              height: height * 0.07,
                              child: TextFormField(
                                readOnly: true,
                                initialValue:VM.lstPatientResponse == null ? "": getReferral( VM.lstPatientResponse![0].physicianNo.toString()),
                                textInputAction: TextInputAction.next,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black54),
                                decoration: InputDecoration(
                                    // filled: true,
                                    // focusColor: const Color(0xffEFEFEF),
                                    // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                                    enabledBorder: outline,
                                    focusedBorder: outline,
                                    label: const Text(
                                      'Referral Type',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 14),
                                    )),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Consumer<BookedServiceVM>(builder: (context, viewModel, _) {
                              switch (viewModel.getBookedService.status) {
                                case Status.Loading:
                                  return  const Center(child: CircularProgressIndicator());
                                case Status.Error:
                                  return  const Text("No Data",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),);
                                case Status.Completed:
                                // updateData();
                                  var VM = viewModel.getBookedService.data!;
                                  print("Count-----${VM.lstPatientResponse![0].lstTestDetails!.length}-----Count");
                                  return
                                    VM.lstPatientResponse == null ? SizedBox():
                                    VM.lstPatientResponse!.isEmpty  ?  SizedBox() :
                                    VM.lstPatientResponse![0].lstTestDetails == null ?
                                    SizedBox() :
                                     VM.lstPatientResponse![0].lstTestDetails!.isEmpty ?
                                     SizedBox() :
                                    SizedBox(
                                      height: height * 0.3,
                                      width: width * 0.96,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: height * 0.12,
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
                                                                                   Text(VM.lstPatientResponse![0].lstTestDetails![index].testNo.toString(),style: TextStyle(fontSize: 10),),
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
                                                                                  Text(VM.lstPatientResponse![0].lstTestDetails![index].testType.toString(),style: TextStyle(fontSize: 12),),
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
                                          Spacer(),
                                          Visibility(
                                              visible:VM.lstPatientResponse![0].lstTestDetails != null ,
                                              child: setAction(widget.screenType,VM.lstPatientResponse![0])),
                                          SizedBox(height: height * 0.03),
                                        ],
                                      ),
                                    );
                              // viewModel.getAddToCart.data!.lstCartDetailsGet!.isEmpty ? Center(child: Image.asset("assets/images/empty_box.png",height: 170,),) :

                                default:
                              }
                              return Container();
                            }),

                          ],
                        ),
                      );
                  // viewModel.getAddToCart.data!.lstCartDetailsGet!.isEmpty ? Center(child: Image.asset("assets/images/empty_box.png",height: 170,),) :

                    default:
                  }
                  return Container();
                }),
              ),

            )
          ],
        ),
      ),
    ));
  }

  String getReferral(String type){
    switch (type) {
      case "0": //"SF"
        return "Self";
      case "Client":
        return "CLI";
      case "1": //"DOC"
        return "Doctor";
      default:
        return "Doctor";
    }
  }

  Widget setAction(int type, LstPatientResponse param) {
    switch (type) {
      case 1:
        return appointmentAction();
      case 2:
        return newRequestAction(param);
      case 3:
        return historyAction();
      default:
        return sampleAction();
    }
  }
  Widget sampleAction() {
    return InkWell(
      onTap: () {
        updateStatus(MainData.statusSubmitToLab,widget.bookingID,context);
      },
      child: Container(
        height: 45,
        width: 140,
        decoration: BoxDecoration(
            color: CustomTheme.background_green,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, offset: Offset(1, 2), blurRadius: 6)
            ]),
        child: const Center(
          child: Text(
            'Submit to Lab',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget appointmentAction() {
    return InkWell(
      onTap: () {
        updateStatus(MainData.statusArrival,widget.bookingID,context);
          },
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
            color: CustomTheme.background_green,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, offset: Offset(1, 2), blurRadius: 6)
            ]),
        child: const Center(
          child: Text(
            'Submit',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget newRequestAction(LstPatientResponse param) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            showRequest(context,"Decline Request","Are you sure to want Decline ?",widget.bookingID,MainData.statusReject);
          },
          child: Visibility(
           visible:param.currentStatusName == "Phlebotomist Assigned" ? false : true,
            child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
            color: CustomTheme.background_green,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1, 2),
                  blurRadius: 6)
            ]),
        child: const Center(
          child: Text(
            'Decline',
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
            )

        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        InkWell(
          onTap: () {
            showRequest(context,"Accept Request","Are you sure to want accept ?",widget.bookingID,MainData.statusAccept);
          },
         child: Visibility(
          visible:param.currentStatusName == "Phlebotomist Assigned" ? false : true,
           child: Container(
             height: 40,
             width: 120,
             decoration: BoxDecoration(
                 color: CustomTheme.background_green,
                 borderRadius: BorderRadius.circular(30),
                 boxShadow: const [
                   BoxShadow(
                       color: Colors.black26,
                       offset: Offset(1, 2),
                       blurRadius: 6)
                 ]),
             child: const Center(
               child: Text(
                 'Accept',
                 style:
                 TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
               ),
             ),
           ),
          )
         //  child: Container(
         //    height: 40,
         //    width: 120,
         //    decoration: BoxDecoration(
         //        color: CustomTheme.background_green,
         //        borderRadius: BorderRadius.circular(30),
         //        boxShadow: const [
         //          BoxShadow(
         //              color: Colors.black26,
         //              offset: Offset(1, 2),
         //              blurRadius: 6)
         //        ]),
         //    child: const Center(
         //      child: Text(
         //        'Accept',
         //        style:
         //            TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
         //      ),
         //    ),
         //  ),
        ),
      ],
    );
  }

  Widget historyAction() {
    return Container();
  }

//Floating action button
  SpeedDial buildSpeedDial(BuildContext context, height, width) {
    Color textBorder = const Color(0xff0272B1);
    return SpeedDial(
      animatedIconTheme: const IconThemeData(size: 28.0),
      // backgroundColor:const Color(0xff182893),
      backgroundColor:Colors.white,
      icon: Icons.message, //icon on Floating action button
      activeIcon: Icons.close, //icon when menu is expanded on button
      foregroundColor: Colors.green, //font color, icon color in button
      activeBackgroundColor: Colors.white,
      activeForegroundColor:Colors.green,
      visible: true,
      direction: SpeedDialDirection.down,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.1,
      children: [
        SpeedDialChild(
          child: Image.asset('assets/images/add_prescripton.png',height: height*0.025,color:   Colors.white,),
          backgroundColor: const Color(0xff84DF8F),
          onTap: () {
            NavigateController.pagePush(context,  AddPrescriptionView(bookingID: widget.bookingID,));
          },
          // label: 'PDF',
          // labelStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          // labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          // child: FittedBox(
          //   child:
          //   Stack(
          //     alignment: const Alignment(1.4, -1.5),
          //     children: [
          //       FloatingActionButton(
          //         // Your actual Fab
          //         onPressed: () {
          //           NavigateController.pagePush(context, const AddToCartView());
          //         },
          //         backgroundColor: const Color(0xff182893),
          //         child: const Icon(Icons.add),
          //       ),
          //       Container(
          //         // This is your Badge
          //         padding: const EdgeInsets.all(8),
          //         constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
          //         decoration: BoxDecoration(
          //           // This controls the shadow
          //           boxShadow: [
          //             BoxShadow(
          //                 spreadRadius: 1,
          //                 blurRadius: 5,
          //                 color: Colors.black.withAlpha(50))
          //           ],
          //           borderRadius: BorderRadius.circular(16),
          //           color: Colors.white, // This would be color of the Badge
          //         ),
          //         // This is your Badge
          //         child: const Center(
          //           // Here you can put whatever content you want inside your Badge
          //           child: Text('4', style: TextStyle(color: Color(0xff182893))),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          child: Image.asset('assets/images/add_test.png',height: height*0.032,color: Colors.white,),
          backgroundColor: const Color(0xff84DF8F),
          onTap: () {
            // NavigateController.pagePush(context,  SearchTests(BookingID: widget.userID, referalID: '', bookingType: widget.bookingType,));
            NavigateController.pagePush(context,AddToCartView(userID: widget.bookingID, bookingType: widget.bookingType));
          },

          // label: 'EXCEL',
          // labelStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          // labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/barcode.png',height: height*0.028,color:Colors.white,),
          ),
          backgroundColor:const Color(0xff84DF8F) ,
          onTap: () {
            NavigateController.pagePush(context,  BarcodePage(userID: widget.bookingID, bookingType: widget.bookingType));
          },
          // label: 'PDF',
          // labelStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          // labelBackgroundColor: Colors.black,
        ),
      ],
      child: const Icon(Icons.add),
    );
  }
  updateStatus(String bookingStatus,String bookingID,BuildContext context) async {
    scrollIndicator( context,  MediaQuery.of(context).size.height,  MediaQuery.of(context).size.width);
    SharedPreferences pref = await SharedPreferences.getInstance();
    // Map<String,dynamic> params = {
    //   "Reason":"NIL",
    //   "UserNo":pref.get(MainData.userNo),
    //   "Latitude":"",
    //   "Longitude":"",
    //   "Location": "",
    //   "BookingStatus": bookingStatus,
    //   "PhileBotomyID": pref.getString(MainData.userID),
    //   "BookingID": bookingID,
    //   "BookingStatusID":bookingStatus
    // };

    var venueNo = await LocalDB.getLDB("venueNo") ?? "";
    var venueBranchNo = await LocalDB.getLDB("venueBranchNo") ?? "";

    Map<String,dynamic> params =
      {
        "userNo": pref.get(MainData.userNo),
        "venueNo": venueNo,
        "venueBranchNo": venueBranchNo,
        "reason": "",
        "bookingID": bookingID,
        "bookingStatus": bookingStatus

    };

    String url = ServerURL().getUrl(RequestType.UpdatePatientStatus);
    if (MainData.statusReject == bookingStatus || MainData.statusAccept == bookingStatus) {
      url = ServerURL().getUrl(RequestType.UpdatePatientStatus); // InsertAppointmentAndRequest
    }
    print(url);
    print("latest $params");
    print("testing-------------=");
    ApiClient().fetchData(url, params).then((response){
      print("latesturl $url");
      print("latestresponse $response");
      if(response["status"]==1){
        if(bookingStatus == MainData.statusSubmitToLab){
          CollectedSampleVM model = Provider.of<CollectedSampleVM>(context, listen: false);
          LocalDB.getLDB('userID').then((value) {
            print(value);
            Map<String,dynamic> params = {
              // "PhileBotomyID":value,
              // "BookingID":"",
              // "Page": widget.bookingType,
              // "Latitude": "",
              // "Longitude": ""
            "bookingID": bookingID,
            "type":  widget.bookingType,
              "bookingStatus": bookingStatus,
            "userNo": value,
            };
            print("testing-------------3");
            model.fetchCollectedSamplesDetails(params,model);
          });
          Navigator.pop(context);
        }else{
          // Navigator.pop(context);
          // pagePush(context,  PaymentPage(bookingID: widget.userID));
        }
        if(widget.screenType == 1){
          Navigator.pop(context);
          NavigateController.pagePush(context, PaymentView(bookingID: widget.bookingID, bookingType: widget.screenType,));
        }else if(widget.screenType == 2){
          Navigator.pop(context);
          NavigateController.pagePushLikePop(context, const NewRequestView());
        }else{
          Navigator.pop(context);
        }

      }
      else{
        Navigator.pop(context);
        errorPopUp(context);
      }
    }).catchError((error){
      print(error);
      Navigator.pop(context);
      errorPopUp(context);
    }).onError((error, stackTrace) {
      print(error);
      Navigator.pop(context);
      errorPopUp(context);
    });
  }
  showRequest( BuildContext context,String title,String sub,String bookingID,String status){
    return showDialog(context: context, builder: (context){
      return  AlertDialog(
        backgroundColor: CustomTheme.circle_green,
        title: Center(child: Text(title,style:const TextStyle(color: Colors.white),)),
        content: Text(sub,style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () async {
            updateStatus(status,bookingID,context);
          },
              child:const Text("Okay",style: TextStyle(color: Colors.orange),)),
          TextButton(onPressed: (){
            Navigator.pop(context);
          },
              child:const Text("Cancel",style: TextStyle(color: Colors.orange)))
        ],
        shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),

      );
    }
    );
  }
}

