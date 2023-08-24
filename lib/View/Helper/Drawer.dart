//Compliance Master Drawer
import 'package:botbridge_green/Utils/LocalDB.dart';
import 'package:botbridge_green/View/Helper/ListApiHit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/ApiClient.dart';
import '../../Model/ServerURL.dart';
import '../LoginView.dart';
import 'ThemeCard.dart';


class HomeDrawer extends StatefulWidget {
  final double height;
  final double width;
  final int selectedScreen;
  const HomeDrawer(
      {Key? key,
        required this.height,
        required this.width,
        required this.selectedScreen})
      : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  double animatedHieght = 60;
  bool _visible=false;
  bool isSwitched = true;
  String UserName = "";
  String accountName = "";

  getData() async {
    LocalDB.getLDB( "AccountName").then((value) {
      setState(() {
        UserName =value;
      });
    });

    LocalDB.getLDB("isOffline").then((value) {
      print("$value-----");
      setState(() {
        isSwitched = value == "0" ? true : false;
      });
    });
    LocalDB.getLDB("username").then((value) {
      setState(() {
        accountName =value;
      });
    });

  }


  void toggleSwitch(bool value) {

    print(value);
    LocalDB.getLDB('userID').then((value) {
      print(value.replaceAll("USR", ""));
      Map<String,dynamic> params = {
        "userNo":value.replaceAll("USR", ""),
        "isOffline": isSwitched ? "1" : "0"
      };

      ApiClient().fetchData(ServerURL().getUrl(RequestType.UpdateRiderStatus), params).then((response){
        print("second response $response");
        setState(() {
          LocalDB.setLDB("isOffline",isSwitched ? "1" : "0");
          LocalDB.getLDB("isOffline").then((value) {

            print(" $value-----");
          });
          isSwitched = !isSwitched;
          // Navigator.pop(context);
        });

        if(response["status"] == 1){
          setState(() {
            LocalDB.setLDB("isOffline",isSwitched ? "1" : "0");
            LocalDB.getLDB("isOffline").then((value) {

              print(" $value-----");
            });
            isSwitched = !isSwitched;
            // Navigator.pop(context);
          });
        }else{
          // Navigator.pop(context);
        }
      });
    });

    // if(isSwitcheds == false)
    // {
    //   setState(() {
    //     isSwitcheds = true;
    //     textValue = 'Switch Button is ON';
    //   });
    //   print('Switch Button is ON');
    // }
    // else
    // {
    //   setState(() {
    //     isSwitcheds = false;
    //     textValue = 'Switch Button is OFF';
    //   });
    //   print('Switch Button is OFF');
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
 enableSet(int min){
   Future.delayed(Duration(milliseconds: min), () { //asynchronous delay
     if (mounted) { //checks if widget is still active and not disposed
       setState(() { //tells the widget builder to rebuild again because ui has updated
         _visible=!_visible; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
       });
     }
   });
 }
  TextStyle textStyle = const TextStyle(
      color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 13);
  TextStyle selectedTextStyle = const TextStyle(
      color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 14);
  Widget listTitle(Widget page, String title, BuildContext context, bool item) {
    return ListTile(
      title: Text(
        title,
        style: item ? selectedTextStyle : textStyle,
      ),
      onTap: () {
        // NavigateController.pagePush(context, page);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: widget.width * 0.65,
      color: Colors.transparent,
      child: Drawer(
        shape: const RoundedRectangleBorder(borderRadius:  BorderRadius.only(topRight: Radius.circular(17),bottomRight:  Radius.circular(17))),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius:  BorderRadius.only(topRight: Radius.circular(17),bottomRight:  Radius.circular(17))),
          child: Row(
            children: [
              Expanded(
                flex: 15,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.05),
                    Row(
                      children: [
                        SizedBox(width: width * 0.01),
                        Image.asset('assets/images/profile.png',height: height*0.08,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width * 0.02,),
                                 Text(UserName,style: const TextStyle(color: Colors.black54,fontSize: 18
                                ),)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.03),
                    //  ListTile(
                    //    onTap: (){
                    //    },
                    //   title: Row(
                    //     children: const [
                    //       Icon(Icons.pregnant_woman),
                    //       SizedBox(width: 7),
                    //       Text('Profile'),
                    //     ],
                    //   ),
                    // ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      height: animatedHieght,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: (){
                              setState(() {
                                if (animatedHieght == 60) {
                                  animatedHieght = 110.0;
                                   enableSet(110);
                                } else {
                                  animatedHieght = 60;
                                  enableSet(0);
                                }
                              });
                            },
                            title: Row(
                              children:  [
                                Image.asset('assets/images/my_status.png',height: height * 0.03),
                                const SizedBox(width: 7),
                                const Text('My Status'),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _visible,
                            child: Column(
                              children: [
                                InkWell(
                                    onTap:(){
                                      animatedHieght = 60;
                                      enableSet(0);
                                    },
                                    child: const Text('Proceed to Lab')),
                                SizedBox(height: height * 0.01,),
                                InkWell(
                                    onTap:(){
                                      animatedHieght = 60;
                                      enableSet(0);
                                    },
                                    child: const Text('Reached to Lab')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ListTile(
                    //   // onTap: (){
                    //   //   logoutPOPUP( context,height,width);
                    //   // },
                    //   title: PopupMenuButton<int>(
                    //     itemBuilder: (context) => [
                    //       // PopupMenuItem 1
                    //       PopupMenuItem(
                    //         value: 1,
                    //         // row with 2 children
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: const [
                    //             Text("   Change Status    ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600))
                    //           ],
                    //         ),
                    //       ),
                    //       // PopupMenuItem 2
                    //       PopupMenuItem(
                    //           value: 2,
                    //           // row with two children
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.end,
                    //             children: [
                    //               InkWell(
                    //                 onTap: () async {
                    //                   sentStatus(isSwitched);
                    //                   print(isSwitched);
                    //                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginView()));
                    //                   // SharedPreferences  pref = await SharedPreferences.getInstance();
                    //                   // pref.clear();
                    //                 },
                    //                 child: const Center(
                    //                   child: Text("Yes",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600)),
                    //                 ),
                    //               ),
                    //               SizedBox(width: width * 0.09),
                    //               InkWell(
                    //                 onTap: (){
                    //                   Navigator.pop(context);
                    //                 },
                    //
                    //                 child: const Center(
                    //                   child: Text("No",style: TextStyle(color: Colors.black54),),
                    //                 ),
                    //               ),
                    //               SizedBox(width: width * 0.06),
                    //             ],
                    //           )
                    //       ),
                    //     ],
                    //     offset: const Offset(0, 50),
                    //     color: Colors.white,
                    //     elevation: 10,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10)
                    //     ),
                    //     // on selected we show the dialog box
                    //     onSelected: (value) {
                    //       // if value 1 show dialog
                    //       // if (value == 1) {
                    //       //   _showDialog(context);
                    //       //   // if value 2 show dialog
                    //       // } else if (value == 2) {
                    //       //   _showDialog(context);
                    //       // }
                    //     },
                    //     child: Row(
                    //       children:  [
                    //         isSwitched ?  Image.asset('assets/images/active_status.png',height: height * 0.03 ,) :
                    //         Image.asset('assets/images/active_status.png',height: height * 0.03 ,color: Colors.red,),
                    //         const SizedBox(width: 7),
                    //         const Text('Active Status'),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    ListTile(
                      title: Row(
                        children:  [
                          isSwitched ?  Image.asset('assets/images/active_status.png',height: height * 0.03 ,) :
                          Image.asset('assets/images/active_status.png',height: height * 0.03 ,color: Colors.red,),
                          const SizedBox(width: 7),
                          const Text('Active Status'),
                        ],
                      ),
                      trailing:Switch(
                        onChanged: toggleSwitch,
                        value: isSwitched,
                        activeColor: Colors.green,
                        activeTrackColor: Colors.grey[200],
                        inactiveThumbColor: Colors.redAccent,
                        inactiveTrackColor: Colors.orange,
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ListApi()));

                      },
                      title:  Row(
                        children:  [
                          Icon(Icons.error,color: Colors.redAccent,),
                          const SizedBox(width: 7),
                          const Text('API'),
                          const Spacer()
                        ],
                      ),
                    ),
                    ListTile(
                       onTap: () async {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginView()));
                         SharedPreferences  pref = await SharedPreferences.getInstance();
                         pref.clear();
                       },
                       title:  Row(
                         children:  [
                           Image.asset('assets/images/log_out.png',height: height * 0.033,width: height * 0.033,),
                           const SizedBox(width: 7),
                           const Text('Logout'),
                           const Spacer()
                         ],
                       ),
                     )
                    //  ListTile(
                    //    // onTap: (){
                    //    //   logoutPOPUP( context,height,width);
                    //    // },
                    //   title: PopupMenuButton<int>(
                    //     itemBuilder: (context) => [
                    //       // PopupMenuItem 1
                    //       PopupMenuItem(
                    //         value: 1,
                    //         // row with 2 children
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: const [
                    //             Text("Are your sure to want logout",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600))
                    //           ],
                    //         ),
                    //       ),
                    //       // PopupMenuItem 2
                    //       PopupMenuItem(
                    //         value: 2,
                    //         // row with two children
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           children: [
                    //             InkWell(
                    //               onTap: () async {
                    //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginView()));
                    //                 SharedPreferences  pref = await SharedPreferences.getInstance();
                    //                 pref.clear();
                    //               },
                    //               child: const Center(
                    //                 child: Text("Yes",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600)),
                    //               ),
                    //             ),
                    //             SizedBox(width: width * 0.09),
                    //             InkWell(
                    //               onTap: (){
                    //                 Navigator.pop(context);
                    //               },
                    //
                    //               child: const Center(
                    //                 child: Text("No",style: TextStyle(color: Colors.black54),),
                    //               ),
                    //             ),
                    //             SizedBox(width: width * 0.06),
                    //           ],
                    //         )
                    //       ),
                    //     ],
                    //     offset: const Offset(0, 50),
                    //     color: Colors.white,
                    //     elevation: 10,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10)
                    //     ),
                    //     // on selected we show the dialog box
                    //     onSelected: (value) {
                    //       // if value 1 show dialog
                    //       // if (value == 1) {
                    //       //   _showDialog(context);
                    //       //   // if value 2 show dialog
                    //       // } else if (value == 2) {
                    //       //   _showDialog(context);
                    //       // }
                    //     },
                    //     child: Row(
                    //       children:  [
                    //       Image.asset('assets/images/log_out.png',height: height * 0.033,width: height * 0.033,),
                    //         const SizedBox(width: 7),
                    //         const Text('Logout'),
                    //         const Spacer()
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    height: 45,
                    width: 3,
                    decoration: BoxDecoration(
                        color: CustomTheme.circle_green,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  sentStatus(bool statusType){
    print(statusType);
    LocalDB.getLDB('userID').then((value) {
      print(value.replaceAll("USR", ""));
      Map<String,dynamic> params = {
        "userNo":value.replaceAll("USR", ""),
        "isOffline": isSwitched ? "1" : "0"
      };

      ApiClient().fetchData(ServerURL().getUrl(RequestType.UpdateRiderStatus), params).then((response){
        print("fist response $response");
        if(response["Status"] == 1){
          print(response);
          setState(() {
            isSwitched = !isSwitched;
            LocalDB.setLDB("isOffline",response["isOffline"].toString());
            Navigator.pop(context);
          });
        }else{
          Navigator.pop(context);
        }
      });
    });

  }
}

logoutPOPUP(BuildContext context,height,width){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
        title: const Center(child:  Text("Logout",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Are You sure to want logout!"),
              SizedBox(height: height * 0.04,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      LocalDB.clearAllLDB(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginView()));
                    },
                    child: const Center(
                      child: Text("Yes",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(width: width * 0.09),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },

                    child: const Center(
                      child: Text("No",style: TextStyle(color: Colors.black38),),
                    ),
                  ),
                  SizedBox(width: width * 0.05),
                ],
              )

            ],
          ),
        ),
      );
    },
  );
}