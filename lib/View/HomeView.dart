import 'package:botbridge_green/Utils/NavigateController.dart';
import 'package:botbridge_green/View/AppointmentView.dart';
import 'package:botbridge_green/View/CollectedSamplesView.dart';
import 'package:botbridge_green/View/Helper/ThemeCard.dart';
import 'package:botbridge_green/View/HistoryView.dart';
import 'package:botbridge_green/View/NewBookingView.dart';
import 'package:botbridge_green/View/NewRequestView.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Utils/LocalDB.dart';
import 'Helper/Drawer.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String userName = "";

  getData() async {
    LocalDB.getLDB( "username").then((value) {
      setState(() {
        userName =value;
      });
    });

  }
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    // _animationController =
    // AnimationController(vsync: this, duration: const Duration(seconds: 0));
    // _animationController.repeat(reverse: true);
    getData();
    super.initState();
  }
  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: WillPopScope(
          onWillPop: ()=>NavigateController.disableBackBt(),
          child: Scaffold(
            backgroundColor: Colors.white,
            key:scaffoldkey ,
            drawer: HomeDrawer(selectedScreen: 1, width: width, height: height,),
            appBar: AppBar(
              backgroundColor:  CustomTheme.background_green,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(19.0),
                child: InkWell(
                    onTap: (){
                      scaffoldkey.currentState!.openDrawer();
                    },
                    child: Image.asset('assets/images/hamburger.png')),
              ),
            ),
            body: ListView(
              physics:  const BouncingScrollPhysics(),
              children: [
                Container(
                  height: height* 0.22,
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.21,
                        width: width,
                        decoration: BoxDecoration(
                          color: CustomTheme.background_green,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(height * 0.3/15))
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom:height * -0.089,
                              right: width * -0.181,
                              child: Image.asset('assets/images/hearting.png',height: height*0.28,color: CustomTheme.circle_green,),
                            ),
                            Positioned(
                                top:height * 0.00,
                                left: width * 0.05,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(greeting(),style: const TextStyle(color: Colors.white,fontSize: 21),),
                                     Text(userName,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    const Text("Make the most of your social life with help from",style: TextStyle(color: Colors.white,fontSize: 14),),
                                    const Text("Our home health care service",style: TextStyle(color: Colors.white,fontSize: 14),),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    // InkWell(
                                    //     onTap: (){
                                    //       NavigateController.pagePush(context, const NewBookingView());
                                    //     },
                                    //     child: SizedBox(
                                    //       width: width * 0.30,
                                    //        height: height * 0.1,
                                    //       child: Lottie.asset('assets/images/new_appoitment.json',
                                    //
                                    //         fit: BoxFit.fill,),
                                    //     ))
                                    SizedBox(
                                      width: width * 0.30,
                                      height: height * 0.04,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25.0),
                                              ),
                                            ),
                                            backgroundColor: MaterialStateProperty.all(
                                                const Color(0xff3768E1)
                                            ),
                                            elevation: MaterialStateProperty.all(7)
                                        ),
                                        onPressed: () {
                                          NavigateController.pagePush(context, const NewBookingView());
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/images/add_appointment.png',height: height*0.02,),
                                            SizedBox(width: width * 0.016,),
                                            const Text('New Booking',style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w600),),
                                          ],
                                        ),
                                      )

                                      // FadeTransition(
                                      //   opacity: _animationController,
                                      //   child: ElevatedButton(
                                      //     style: ButtonStyle(
                                      //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      //           RoundedRectangleBorder(
                                      //             borderRadius: BorderRadius.circular(25.0),
                                      //           ),
                                      //         ),
                                      //         backgroundColor: MaterialStateProperty.all(
                                      //             const Color(0xff3768E1)
                                      //         ),
                                      //         elevation: MaterialStateProperty.all(7)
                                      //     ),
                                      //     onPressed: () {
                                      //       NavigateController.pagePush(context, const NewBookingView());
                                      //     },
                                      //     child: Row(
                                      //       mainAxisAlignment: MainAxisAlignment.center,
                                      //       children: [
                                      //         Image.asset('assets/images/add_appointment.png',height: height*0.02,),
                                      //         SizedBox(width: width * 0.016,),
                                      //         const Text('Appointment',style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w600),),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      // const Spacer(),
                      // Row(
                      //   children: [
                      //     SizedBox(width: width * 0.03,),
                      //     const Text('Our Health \nService',style: TextStyle(color: Color(0xff182893),fontSize: 19,fontWeight: FontWeight.w600),),
                      //     const Spacer(),
                      //     // Image.asset('assets/images/hamburger.png',height: height * 0.02,color: Colors.grey[300],),
                      //     SizedBox(width: width * 0.05,),
                      //   ],
                      // ),
                      // SizedBox(height: height * 0.023,)
                    ],
                  ),
                ),
                Container(
                  height: height * 0.59,
                  child: SizedBox(
                    // height: height * 0.51,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: width * 0.03,),
                            const Text('Our Health \nService',style: TextStyle(color: Color(0xff182893),fontSize: 19,fontWeight: FontWeight.w600),),
                            const Spacer(),
                            // Image.asset('assets/images/hamburger.png',height: height * 0.02,color: Colors.grey[300],),
                            SizedBox(width: width * 0.05,),
                          ],
                        ),
                        SizedBox(height: height * 0.012,),
                        Flex(
                            direction: Axis.vertical,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                                physics:  const BouncingScrollPhysics(),
                                itemCount: listGrid.length,
                                itemBuilder: (BuildContext context,index){
                                  return InkWell(
                                    hoverColor: Colors.white,
                                    focusColor:Colors.white ,
                                    highlightColor: Colors.white,
                                    onTap: (){
                                      NavigateController.pagePush(context,listGrid[index].screen);
                                    },
                                    child: SizedBox(
                                      height: height * 0.12,
                                      width: width* 0.9,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: width * 0.038,),
                                              Container(
                                                height: height * 0.09,
                                                width: width* 0.19,
                                                decoration: BoxDecoration(
                                                    color:Colors.transparent ,
                                                    borderRadius: BorderRadius.circular(12)
                                                ),
                                                child:  Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Center(
                                                      child: Image.asset(listGrid[index].assets,color: CustomTheme.background_green,)
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(width: width * 0.001,),
                                              SizedBox(
                                                height: height * 0.09,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: height * 0.01,),
                                                    Text(listGrid[index].title,style: const TextStyle(color: Color(
                                                        0xff4662AC),fontSize: 16,fontWeight: FontWeight.w700),),
                                                    SizedBox(height: height * 0.01),
                                                    Text(listGrid[index].description,style: const TextStyle(color: Colors.black54,fontSize: 10,fontWeight: FontWeight.w600),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // const Spacer(),
                                          Row(
                                            children: [
                                              SizedBox(width: width * 0.21,),
                                              SizedBox(
                                                  width: width * 0.63,
                                                  child: const Divider(color: Colors.black26,thickness: 1)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );

                                  //   InkWell(
                                  //   onTap: (){
                                  //     NavigateController.pagePush(context,listGrid[index].screen);
                                  //   },
                                  //   child: SizedBox(
                                  //     height: height * 0.13,
                                  //     width: width* 0.9,
                                  //     child: Column(
                                  //       children: [
                                  //         Row(
                                  //           children: [
                                  //             SizedBox(width: width * 0.03,),
                                  //             Container(
                                  //               height: height * 0.1,
                                  //               width: width* 0.19,
                                  //               decoration: BoxDecoration(
                                  //                 color:CustomTheme.circle_green ,
                                  //                 borderRadius: BorderRadius.circular(12)
                                  //               ),
                                  //               child:  Padding(
                                  //                 padding: const EdgeInsets.all(15.0),
                                  //                 child: Center(
                                  //                   child: Image.asset(listGrid[index].assets,)
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             SizedBox(width: width * 0.06,),
                                  //             SizedBox(
                                  //               height: height * 0.1,
                                  //               child: Column(
                                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   SizedBox(height: height * 0.01,),
                                  //                   Text(listGrid[index].title,style: const TextStyle(color: Color(0xff2454FF),fontSize: 17,fontWeight: FontWeight.w400),),
                                  //                   SizedBox(height: height * 0.016),
                                  //                   Text(listGrid[index].description,style: const TextStyle(color: Colors.black54,fontSize: 10,fontWeight: FontWeight.w600),),
                                  //
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //         const Spacer(),
                                  //         Row(
                                  //           children: [
                                  //             SizedBox(width: width * 0.26,),
                                  //             SizedBox(
                                  //             width: width * 0.65,
                                  //                 child: const Divider(color: Colors.black26,thickness: 1)),
                                  //           ],
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // );
                                }
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}

class HomeGridData{
  final String title;
  final String assets;
  final String description;
  final Widget screen;

  HomeGridData(this.title, this.assets, this.description, this.screen);
}
final List<HomeGridData> listGrid = [
  HomeGridData("Appointment",'assets/images/appointment.png',"Make your formal arrangement at your home,\nat your place, anywhere.",const AppointmentView()),
  HomeGridData("New Request",'assets/images/new_request.png',"Request for access to our Facilities \nand Services",const NewRequestView()),
  HomeGridData("Samples",'assets/images/sample_collected.png',"Total number  of blood samples collected \nfrom the patients", const CollectedSamplesView()),
  HomeGridData("History",'assets/images/history.png',"Record of information about a person’s \nhealth",const HistoryView()),
];

