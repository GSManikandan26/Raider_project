import 'package:botbridge_green/Utils/LocalDB.dart';
import 'package:botbridge_green/View/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Model/Status.dart';
import '../Utils/NavigateController.dart';
import '../ViewModel/AppointmentListVM.dart';
import 'Helper/ThemeCard.dart';
import 'PatientDetailsView.dart';



class AppointmentView extends StatefulWidget {
  const AppointmentView({Key? key}) : super(key: key);

  @override
  _AppointmentViewState createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  final AppointmentListVM _api = AppointmentListVM();
  String BookinType = "APP" ;
  bool isFetching = true;
  bool isSearchbar = true;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    LocalDB.getLDB('userID').then((value) {
      print("Appointviewuserid $value");
      Map<String,dynamic> params = {
        "bookingID": "",
        "type": "APP",
        "userNo": value,
      };
      _api.fetchAppointmentDetails(params);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: const Color(0xffEFEFEF),
            body:SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      height: height * 0.16,
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.07,
                            width: width,
                            decoration: BoxDecoration(
                                color: CustomTheme.background_green,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(height * 0.6/25))
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(11),
                                    child: InkWell(
                                        onTap: (){
                                          FocusScope.of(context).unfocus();
                                          NavigateController.pagePushLikePop(context,  const HomeView());
                                        },
                                        child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(11),
                                    child: Text("Appointment",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width * 0.8,
                                height: height * 0.066,
                                child: TextFormField(
                                  cursorColor: Colors.grey,
                                  onChanged: (value){
                                    var mobilenum = value;
                                    print("mobil characters $value");
                                    LocalDB.getLDB('userID').then((value) {
                                      print("Appointviewuserid $value");
                                      Map<String,dynamic> params = {
                                        "bookingID": "",
                                        "type": "APP",
                                        "userNo": value,
                                        //"registeredDateTime": DateFormat("yyyy-MM-dd").format(picked)
                                        "mobilenumber":mobilenum.toString(),
                                      };
                                      _api.fetchAppointmentDetails(params);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 4,left: 13),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14),
                                          borderSide: const BorderSide(color: Colors.white,width: 2)
                                      ),
                                      focusedBorder:OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14),
                                          borderSide: const BorderSide(color: Colors.white,width: 2)
                                      ),
                                      hintText: 'Search'
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.015,),
                              GestureDetector(
                                  onTap: (){
                                    _selectDatePicker(context);
                                  },
                                  child: Image.asset('assets/images/calender.png',height: height*0.044))
                            ],
                          ),
                        ],
                      )),
                  Container(
                    height: height * 0.8,
                    color: Colors.transparent,
                    child:ChangeNotifierProvider<AppointmentListVM>(
                      create: (BuildContext context) => _api,
                      child: Consumer<AppointmentListVM>(builder: (context, viewModel, _) {
                        switch (viewModel.getAddToCart.status) {
                          case Status.Loading:
                            return  const Center(child: CircularProgressIndicator());
                          case Status.Error:
                            return const Center(child: Center(child: Text("Something Issue"),))  ;
                          case Status.Completed:
                          // updateData();
                            var VM = viewModel.getAddToCart.data!;
                            return
                              VM.lstPatientResponse == null ?
                              //VM.lstPatientResponse!.isEmpty ?
                              const Center(child:Center(child: Text("No Record Found",style: TextStyle(fontWeight: FontWeight.bold),),)) :
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Flex(
                                      direction: Axis.vertical,
                                      children: [
                                        ListView.builder(
                                          itemCount: VM.lstPatientResponse!.length,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context, int index) {
                                            return InkWell(
                                              onTap: (){
                                                NavigateController.pagePush(context,  PatientDetailsView(screenType: 1, bookingType: BookinType, bookingID:  VM.lstPatientResponse![index].bookingId.toString(), data2:{}));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                                child: Container(
                                                  height: height * 0.13,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(17)
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                          right:width * 0.0,
                                                          bottom: height * 0.0,
                                                          child: Image.asset('assets/images/side_illustrate.png',height: height*0.05,color:  Color(0xff182893),)
                                                      ),
                                                      Positioned(
                                                        bottom: height * 0.012,
                                                        right:width * 0.02 ,
                                                        child: Text(
                                                          VM.lstPatientResponse![index].isPaid == true ? "PAID" : "UNPAID",
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 11),
                                                        ),),
                                                      Positioned(
                                                        left:width * 0.03,
                                                        top: height * 0.035,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children:  const [
                                                            CircleAvatar(
                                                              backgroundColor:  Color(0xffEFEFEF),
                                                              radius: 27,
                                                              backgroundImage: AssetImage('assets/images/profile.png'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left:width * 0.21,
                                                        top: height * 0.02,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children:  [
                                                            Row(
                                                              children:  [
                                                                Text("${VM.lstPatientResponse![index].patientName}",style: const TextStyle(color: Color(0xff203298)),overflow: TextOverflow.ellipsis),
                                                                Text(" ${VM.lstPatientResponse![index].age!.replaceAll('Y', "")}, ${VM.lstPatientResponse![index].gender }",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 13),),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: height * 0.01,
                                                            ),
                                                            SizedBox(
                                                                width: width * 0.6,
                                                                child: Text("${VM.lstPatientResponse![index].address}",style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                            SizedBox(
                                                              height: height * 0.01,
                                                            ),
                                                            Text(
                                                              "${CustomTheme.normalDate.format(DateFormat("yyyy-MM-dd HH:mm").parse(VM.lstPatientResponse![index].registeredDateTime.toString()))}"
                                                                  // "${VM.lstPatientResponse![index].registeredDateTime}"
                                                                  ""
                                                              ,style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(height: height * 0.04,),
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
            ) ,
          ),
        ));
  }
  Future<void> _selectDatePicker(BuildContext context) async { //selectedDate
    final DateTime? picked = await showDatePicker(
        context: context,
        // helpText: "DOB",
        initialDate: selectedDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2031),
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
            child: Theme(
              data: ThemeData.light().copyWith(
                primaryColor: CustomTheme.circle_green,

                buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                colorScheme:  ColorScheme.light(primary: CustomTheme.circle_green)
                    .copyWith(secondary: CustomTheme.circle_green),
                dialogTheme: const DialogTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)))),
              ),
              child: child!,
            ),
          );
        });
    if (picked != null && picked != selectedDate) {
      print("mypickeddate $picked");
      setState(() {
        selectedDate = picked;
      });
      LocalDB.getLDB('userID').then((value) {
        print("Appointviewuserid $value");
        Map<String,dynamic> params = {
          "bookingID": "",
          "type": "APP",
          "userNo": value,
          "registeredDateTime": DateFormat("yyyy-MM-dd").format(picked)

        };
        _api.fetchAppointmentDetails(params);
      });
    }
  }
}
