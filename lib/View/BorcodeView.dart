import 'package:botbridge_green/Model/ApiClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Model/ServerURL.dart';
import '../Model/Status.dart';
import '../Utils/LocalDB.dart';
import '../Utils/NavigateController.dart';
import '../ViewModel/SampleWiseServiceVM.dart';
import 'Helper/ThemeCard.dart';

class BarcodePage extends StatefulWidget {
  final String bookingType;
  final String userID;
  const BarcodePage({Key? key, required this.bookingType, required this.userID}) : super(key: key);

  @override
  _BarcodePageState createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  final SampleWiseServiceDataVM _api = SampleWiseServiceDataVM();
  String? scanResult;
  @override
  void initState() {
    // TODO: implement initState

    LocalDB.getLDB('userID').then((value) {
      print("Appointviewuserid $value");
      Map<String,dynamic> params1 = {
        "bookingID": widget.userID,
        "userNo":value,
        "type": widget.bookingType,
        "Latitude":"37.4219983",
        "Longitude":"-122.084"
      };
      _api.fetchSampleWiseTest(params1);  //fetchSampleWiseTest
    });

    // Map<String,dynamic> params = {
    //   "BookingID":widget.bookingID,
    //    "userNO": 2,
    // };
    // _api.fetchSampleWiseTest( params);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
                                child: Text("Sample Wise Test",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
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
                      child:  ChangeNotifierProvider<SampleWiseServiceDataVM>(
                        create: (BuildContext context) => _api,
                        child: Consumer<SampleWiseServiceDataVM>(builder: (context, viewModel, _) {
                          switch (viewModel.getAddToCart.status) {
                            case Status.Loading:
                              return  const Center(child: CircularProgressIndicator());
                            case Status.Error:
                              return  const Text("No Data",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),);
                            case Status.Completed:
                            // updateData();
                            print("hello");
                              var VM = viewModel.getAddToCart.data!;
                              return
                                VM.lstPatientResponse == null  ?  const Center(child:Center(child: Text("No Record Found",style: TextStyle(fontWeight: FontWeight.bold),),))  :
                                VM.lstPatientResponse!.isEmpty  ? const Center(child:Center(child: Text("No Record Found",style: TextStyle(fontWeight: FontWeight.bold),),))  :
                                VM.lstPatientResponse![0].lstTestSampleWise == null ?
                                const SizedBox() :
                                VM.lstPatientResponse![0].lstTestSampleWise!.isEmpty ?
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
                                                        physics:const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: VM.lstPatientResponse![0].lstTestSampleWise!.length,
                                                        itemBuilder: (BuildContext context,index){
                                                          return  Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius:const BorderRadius.all(Radius.circular(15)
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors.black45.withOpacity(0.2),
                                                                      blurRadius: 8,
                                                                      offset: const Offset(4, 8),
                                                                    ),
                                                                  ]
                                                              ),
                                                              child: ListTile(
                                                                  leading:  CircleAvatar(
                                                                      radius: 20,
                                                                      backgroundColor: Colors.transparent,
                                                                      child: Image.asset('assets/images/barcode.png',height: height*0.05)),
                                                                  title:  Text(
                                                                    "${VM.lstPatientResponse![0].lstTestSampleWise![index].testName}",
                                                                    style: const TextStyle(fontWeight: FontWeight.w600,color:  Color(0xff182893)),
                                                                  ),
                                                                  subtitle: const Text(
                                                                    "Tap to Scan",
                                                                    style: TextStyle(
                                                                        color: Colors.black87, fontWeight: FontWeight.w400),
                                                                  ),
                                                                  onTap: () {
                                                                    _barscanner(VM.lstPatientResponse![0].lstTestSampleWise![index].testNo,VM.lstPatientResponse![0].lstTestSampleWise![index].bookingId,VM.lstPatientResponse![0].lstTestSampleWise![index].sampleNo);
                                                                  }),
                                                            ),
                                                          );
                                                        }
                                                        ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 0,
                                      child: SizedBox(
                                        height: height*0.2,
                                        child: Column(
                                          children: [
                                            const Spacer(),
                                            InkWell(
                                              onTap: (){
                                                // NavigateController.pagePush(context,  PaymentView(bookingID: widget.userID, bookingType: null,));
                                              },
                                              child: Visibility(
                                                visible:false,
                                                child: Container(
                                                  height: 40,
                                                  width:120,
                                                  decoration: BoxDecoration(
                                                      color: CustomTheme.background_green,
                                                      borderRadius: BorderRadius.circular(30),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.black26,
                                                            offset: Offset(1,2),
                                                            blurRadius: 6
                                                        )
                                                      ]
                                                  ),
                                                  child: const Center(
                                                    child: Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: height * 0.03),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                          // viewModel.getAddToCart.data!.lstCartDetailsGet!.isEmpty ? Center(child: Image.asset("assets/images/empty_box.png",height: 170,),) :

                            default:
                          }
                          return Container();
                        }),
                      ),


                    ),
                  ),
                ],
              ),
            )
    ));
  }

  Future _barscanner(testname,bookingid,sampleno) async {
    String scanResult;
    try{
      scanResult=await FlutterBarcodeScanner.scanBarcode("#ff6666","Cancel",true,ScanMode.BARCODE);

    }on PlatformException{
      scanResult="Failed";
    }
    if(!mounted)return;

    setState(() {
      this.scanResult=scanResult;
    });

    Map <String,dynamic> params = {"lstBarcode" : [{"sampleNo" : sampleno,"barcodeNo":scanResult.toString()}],"test_id":testname ?? "","bookingID":bookingid};
    dynamic response = await ApiClient().fetchData(ServerURL().getUrl(RequestType.ValidatePrePrintedBarcode),params);
      print("barcode success $response");
      Fluttertoast.showToast(
          msg: "Uploaded..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 14.0
      );






  }
}
