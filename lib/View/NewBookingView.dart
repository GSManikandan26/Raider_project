import 'dart:async';
import 'package:botbridge_green/Model/ServerURL.dart';
import 'package:botbridge_green/Utils/NavigateController.dart';
import 'package:botbridge_green/View/PatientDetailsView.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Model/ApiClient.dart';
import '../Utils/LocalDB.dart';
import '../ViewModel/BookedServiceVM.dart';
import 'AddToCartView.dart';
import 'Helper/ThemeCard.dart';
import 'PaymentView.dart';



class NewBookingView extends StatefulWidget {
  const NewBookingView({Key? key}) : super(key: key);

  @override
  _NewBookingViewState createState() => _NewBookingViewState();
}

class _NewBookingViewState extends State<NewBookingView> {
  final _formkey = GlobalKey<FormState>();
    final TextEditingController Username= TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController emailID = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController remark = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController doctorName = TextEditingController();
    final TextEditingController referdr = TextEditingController();
    final TextEditingController title = TextEditingController();

  final TextEditingController clientName = TextEditingController();
  final TextEditingController age = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late Color col = Colors.white;
  String genderType = "";
  String referralType = "";

  bool isSelf = false;
  bool isDoctor = false;
  bool isClient = false;
  bool isClicked = false;
  GoogleMapController? mapController;
  Set<Marker> markers = Set();
  final Completer<GoogleMapController> _controller = Completer();
  Position? currentLoc;
  startFetching() async {
    print("Start2");
    bool serviceEnabled;
    LocationPermission permission;

    // Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(userLocation.longitude);
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
        permission = await Geolocator.requestPermission();
      }else{

      }
    }else{
      print("Start3");
      Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(userLocation);
      if(mounted){
        setState(() {
          currentLoc = userLocation;
        });
      }

      markers.add(Marker( //add start location marker
          markerId: MarkerId(LatLng(userLocation.latitude,userLocation.longitude).toString()),
          position: LatLng(userLocation.latitude,userLocation.longitude), //position of marker
          infoWindow: const InfoWindow( //popup info
            title: 'Home',
            snippet: 'Start Marker',
          ),
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(devicePixelRatio: 3.2),
              "assets/images/home_mark.png")//Icon for Marker
      ));
      GoogleMapController gMapController  =await _controller.future;

      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      Geolocator.getPositionStream(locationSettings: locationSettings).listen(
              (Position? position) {
            if(position != null){
              gMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  zoom: 13.3,
                  target:LatLng(position.latitude,position.longitude) )));
            }
          });
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


  }
  ScrollController control = ScrollController();
  bool floatingButtonVisible = false;
  String? selectedGender;
  String? selectedReferral;
  _scrollListener(){
    bool isTop = control.position.pixels == 0;
    setState(() {
      if (isTop) {
        floatingButtonVisible = false;
        print('At the top');
      } else {
        floatingButtonVisible = true;
        print('At the bottom');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      control.addListener(() {
        if (control.position.atEdge) {
          bool isTop = control.position.pixels == 0;
          setState(() {
            if (isTop) {
              floatingButtonVisible = false;
              print('At the top');
            } else {
              floatingButtonVisible = true;
              print('At the bottom');
            }
          });

        }
      });
    });
    BookedServiceVM model = Provider.of<BookedServiceVM>(context, listen: false);
    model.fetchBookedService({}, model,true);
    startFetching();

    super.initState();
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
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                height: height * 0.07,
                width: width,
                decoration: BoxDecoration(
                    color: CustomTheme.background_green,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(1,4),
                          blurRadius: 6,
                          color: Colors.black12
                      )
                    ],
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(height * 0.14/3.5))
                ),
                child: Stack(
                  children: [
                     Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: InkWell(
                            onTap: (){
                              NavigateController.pagePOP(context);
                            },
                            child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(11),
                            child: InkWell(
                                onTap: (){
                                  NavigateController.pagePush(context,const AddToCartView(userID: "", bookingType:  "NewBooking")); //widget.bookingType
                                },
                                child: const Icon(Icons.add,color: Colors.white,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(11),
                            child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, "ExistedPatient").then((value) {
                                    if (value != null){
                                      if(value != false){
                                        Map<String,dynamic> data = value as Map<String,dynamic>;
                                        print(data);
                                        firstName.text = data['fname'].toString();
                                        lastName.text = data['lname'].toString();
                                        mobileNo.text = data['no'].toString();
                                        emailID.text = data['mail'].toString();
                                        pincode.text = data['pincode'].toString();
                                        dob.text = data['dob'].toString();
                                        age.text = data['age'].toString();
                                      }
                                      print(value);
                                    }
                                  });
                                },
                                child: const Icon(Icons.search,color: Colors.white,)),
                          ),
                        ],
                      ),
                    ),
                     Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   height: height * 0.03,
                          // ),
                          // InkWell(
                          //   onTap: ()  {
                          //     Navigator.pushNamed(context, "ExistedPatient").then((value) {
                          //       if (value != null){
                          //         if(value != false){
                          //           Map<String,dynamic> data = value as Map<String,dynamic>;
                          //           print(data);
                          //           firstName.text = data['fname'].toString();
                          //           lastName.text = data['lname'].toString();
                          //           mobileNo.text = data['no'].toString();
                          //           emailID.text = data['mail'].toString();
                          //           pincode.text = data['pincode'].toString();
                          //           pincode.text = data['dob'].toString();
                          //           age.text = data['age'].toString();
                          //         }
                          //         print(value);
                          //       }
                          //     });
                          //
                          //   },
                          //   child: Container(
                          //     height: height * 0.05,
                          //     width: width * 0.7,
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(20),
                          //         color: const Color(0xffBFFCC3),
                          //
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         SizedBox(width: width * 0.09,),
                          //         const Text("Search Via Name/MobileNo/PID",style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w400),),
                          //         const Spacer(),
                          //         const Icon(Icons.search,color: Colors.black54,size: 18,),
                          //         SizedBox(width: width * 0.03,),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: height * 0.021,
                          // ),
                          Text("Book New Test",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.87,
                child: SingleChildScrollView(
                  controller: control,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.03,),
                       SizedBox(
             width:  width * 0.9,
             height: height * 0.07,
             child: TextFormField(
                       textInputAction: TextInputAction.next,
                       cursorColor: Colors.black,
                       controller: Username,
                       style: const TextStyle(color: Colors.black54),
               keyboardType: TextInputType.name,
               textCapitalization: TextCapitalization.words,
               inputFormatters: <TextInputFormatter>[
                 FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
               ],
               validator: (value) {
                 if (value!.isEmpty) {
                   return "";
                 }
                 return null;
               },

               decoration: InputDecoration(
                         // filled: true,
                   // errorText: '',
                   errorStyle: const TextStyle(
                     color: Colors.transparent,
                     fontSize: 0,
                   ),
                   // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                         errorBorder: outline,
                         focusedErrorBorder: outline,
                         enabledBorder:outline,
                         focusedBorder:outline,
                         // focusColor: const Color(0xffEFEFEF),

                         label: const Text('User Name*',style: TextStyle(color: Colors.black54,fontSize: 14),)
                       ),
             ),
           ),
                      SizedBox(height: height * 0.013),
           SizedBox(
             width:  width * 0.9,
             height: height * 0.07,
             child: TextFormField(
                       textInputAction: TextInputAction.next,
                       cursorColor: Colors.black,
                       controller: firstName,
                       style: const TextStyle(color: Colors.black54),
               keyboardType: TextInputType.name,
               textCapitalization: TextCapitalization.words,
               inputFormatters: <TextInputFormatter>[
                 FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
               ],
               validator: (value) {
                 if (value!.isEmpty) {
                   return "";
                 }
                 return null;
               },

               decoration: InputDecoration(
                         // filled: true,
                   // errorText: '',
                   errorStyle: const TextStyle(
                     color: Colors.transparent,
                     fontSize: 0,
                   ),
                   // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                         errorBorder: outline,
                         focusedErrorBorder: outline,
                         enabledBorder:outline,
                         focusedBorder:outline,
                         // focusColor: const Color(0xffEFEFEF),

                         label: const Text('First Name*',style: TextStyle(color: Colors.black54,fontSize: 14),)
                       ),
             ),
           ),
                      SizedBox(height: height * 0.013),
                      SizedBox(
                        width:  width * 0.9,
                        height: height * 0.07,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          controller: lastName,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                          ],
                          style: const TextStyle(color: Colors.black54),
                          keyboardType: TextInputType.name,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Please enter Last name";
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              // filled: true,
                              // focusColor: const Color(0xffEFEFEF),
                              errorStyle: const TextStyle(
                                color: Colors.transparent,
                                fontSize: 0,
                              ),
                              // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                              errorBorder: outline,
                              focusedErrorBorder: outline,
                              enabledBorder:outline,
                              focusedBorder:outline,
                              floatingLabelStyle:const TextStyle(color: Colors.black54,fontSize: 14),
                              label: const Text('Last Name',style: TextStyle(color: Colors.black54,fontSize: 14),)
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.013),
                      SizedBox(
                        width:  width * 0.9,
                        height: height * 0.07,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          controller: mobileNo,
                          style: const TextStyle(color: Colors.black54),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value!.length != 10) {
                              return "Please enter Valid number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              // filled: true,
                              // focusColor: const Color(0xffEFEFEF),
                              errorStyle: const TextStyle(
                                color: Colors.transparent,
                                fontSize: 0,
                              ),
                              // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                              errorBorder: outline,
                              focusedErrorBorder: outline,
                              enabledBorder:outline,
                              focusedBorder:outline,
                              label: const Text('Mobile No*',style: TextStyle(color: Colors.black54,fontSize: 14),)
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.013),
                      SizedBox(
                        width:  width * 0.9,
                        height: height * 0.07,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          controller: emailID,
                          style: const TextStyle(color: Colors.black54),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.sentences,
                          // validator: (value) { to validate email value is present or not
                          //   if (value!.isEmpty) {
                          //     return "Please enter Valid Mail";
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              // filled: true,
                              // focusColor: const Color(0xffEFEFEF),
                              // contentPadding: const EdgeInsets.only(top: 4,left: 7),
                              errorStyle: const TextStyle(
                                color: Colors.transparent,
                                fontSize: 0,
                              ),
                              errorBorder: outline,
                              focusedErrorBorder: outline,
                              enabledBorder:outline,
                              focusedBorder:outline,
                              label: const Text('Email ID',style: TextStyle(color: Colors.black54,fontSize: 14),)
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.013),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width:  width * 0.4,
                            height: height * 0.07,
                            child: TextFormField(
                              controller: dob,
                              readOnly: true,
                              onTap: () => selectDate(context, selectedDate),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return "Please Selected DOB";
                              //   }
                              //   return null;
                              // },
                              style: const TextStyle(color: Colors.black54),
                              decoration: InputDecoration(
                                  // filled: true,
                                  // focusColor: const Color(0xffEFEFEF),
                                  errorStyle: const TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                  ),
                                  // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                                  errorBorder: outline,
                                  focusedErrorBorder: outline,
                                  enabledBorder:outline,
                                  focusedBorder:outline,
                                  label: const Text('DOB',style: TextStyle(color: Colors.black54,fontSize: 14),)
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.08),
                          SizedBox(
                            width:  width * 0.4,
                            height: height * 0.07,
                            child:DropdownButtonFormField2(
                              dropdownDecoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(25) ,
                              ),
                              focusColor: Colors.white,
                              validator: (value) {
                                if (selectedGender == null ) {
                                  return "Please select Gender";
                                }
                                return null;
                              },
                              icon: const Padding(
                                padding: EdgeInsets.only(bottom: 7,right: 8),
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                              style: const TextStyle(color: Colors.black54),
                              decoration:  InputDecoration(
                                // contentPadding: ,
                                //   contentPadding: const EdgeInsets.only(bottom: 18,left: 10),
                                //   filled: true,
                                //   focusColor: const Color(0xffEFEFEF),
                                  errorStyle: const TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                  ),
                                  errorBorder: outline,
                                  focusedErrorBorder: outline,
                                  enabledBorder:outline,
                                  focusedBorder:outline,
                                  label: const Text('Gender*',style: TextStyle(color: Colors.black54,fontSize: 14),)

                              ),
                              selectedItemBuilder: (BuildContext context) {
                                return genderList.map<Widget>((Gender item) {
                                  return Text(item.gender,
                                      style: const TextStyle(color: Colors.black));
                                }).toList();
                              },
                              items: genderList.map((Gender item) {
                                return DropdownMenuItem<String>(
                                  value: item.gender,
                                  child: Text(
                                    item.gender,
                                    style: const TextStyle(fontSize: 13, color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (genderList) {
                                setState(() {
                                  selectedGender = genderList.toString();
                                  genderType = genderList.toString();
                                });
                              },

                              value: selectedGender,
                              isExpanded: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.013),
                      SizedBox(
                        width:  width * 0.9,
                        height: height * 0.07,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          controller: age,
                          keyboardType:TextInputType.streetAddress,
                          validator: (value){
                            if (value!.isEmpty) {
                              return "Please enter Age*";
                            }
                            return null;
                          },

                          style: const TextStyle(color: Colors.black54),
                          decoration: InputDecoration(
                            // filled: true,
                            // focusColor: const Color(0xffEFEFEF),
                            // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                              errorStyle: const TextStyle(
                                color: Colors.transparent,
                                fontSize: 0,
                              ),
                              errorBorder: outline,
                              focusedErrorBorder: outline,
                              enabledBorder:outline,
                              focusedBorder:outline,
                              // suffixIcon:  InkWell(
                              //   onTap: () async {
                              //     _scrollIndicator( context, height, width);
                              //     var userLocation = await Geolocator.getCurrentPosition();
                              //     double lat= userLocation.latitude;
                              //     double log=userLocation.longitude;
                              //     List<Placemark> placeMarks = await placemarkFromCoordinates(lat,log);
                              //     Placemark place = placeMarks[0];
                              //     Placemark place2 = placeMarks[2];
                              //     Map<String,String> addressMap = {
                              //       "street":place2.subLocality.toString(),
                              //       "postalCode": place.postalCode.toString(),
                              //       "locality":place.locality.toString(),
                              //       "state":place2.administrativeArea.toString(),
                              //       "country":place2.country.toString()
                              //     };
                              //     var address = "${addressMap['street']!="" ? "${addressMap['street']}," : "" }${addressMap['locality']!="" ? "${addressMap['locality']}," : "" } ${addressMap['postalCode']!="" ? "${addressMap['postalCode']}," : "" } ${addressMap['state']!="" ? "${addressMap['state']}," : "" } ${addressMap['country']?? ""}";
                              //     var addData = '${place2.subLocality}, ${place.postalCode}, ${place.locality}, ${place2.administrativeArea}, ${place.country}';
                              //     Navigator.pop(context);
                              //     showDialog(
                              //         context: context,
                              //         barrierDismissible: true,
                              //         builder: (_) => setAddressPOPUP( context,height,width,address,addressMap)
                              //     );
                              //
                              //   },
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(12.0),
                              //     child: Image.asset('assets/images/address_map.png',height: 23),
                              //   ),
                              // ),
                              label: const Text('Age*',style: TextStyle(color: Colors.black54,fontSize: 14),)
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.013),
                       SizedBox(
             width:  width * 0.9,
             height: height * 0.07,
             child: TextFormField(
                       textInputAction: TextInputAction.next,
                       cursorColor: Colors.black,
                       controller: title,
                       style: const TextStyle(color: Colors.black54),
               keyboardType: TextInputType.name,
               textCapitalization: TextCapitalization.words,
               inputFormatters: <TextInputFormatter>[
                 FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
               ],
               validator: (value) {
                 if (value!.isEmpty) {
                   return "";
                 }
                 return null;
               },

               decoration: InputDecoration(
                         // filled: true,
                   // errorText: '',
                   errorStyle: const TextStyle(
                     color: Colors.transparent,
                     fontSize: 0,
                   ),
                   // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                         errorBorder: outline,
                         focusedErrorBorder: outline,
                         enabledBorder:outline,
                         focusedBorder:outline,
                         // focusColor: const Color(0xffEFEFEF),

                         label: const Text('Title',style: TextStyle(color: Colors.black54,fontSize: 14),)
                       ),
             ),
           ),
                      SizedBox(height: height * 0.013),
                        SizedBox(
             width:  width * 0.9,
             height: height * 0.07,
             child: TextFormField(
                       textInputAction: TextInputAction.next,
                       cursorColor: Colors.black,
                       controller: referdr,
                       style: const TextStyle(color: Colors.black54),
               keyboardType: TextInputType.name,
               textCapitalization: TextCapitalization.words,
               inputFormatters: <TextInputFormatter>[
                 FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
               ],
               validator: (value) {
                 if (value!.isEmpty) {
                   return "";
                 }
                 return null;
               },

               decoration: InputDecoration(
                         // filled: true,
                   // errorText: '',
                   errorStyle: const TextStyle(
                     color: Colors.transparent,
                     fontSize: 0,
                   ),
                   // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                         errorBorder: outline,
                         focusedErrorBorder: outline,
                         enabledBorder:outline,
                         focusedBorder:outline,
                         // focusColor: const Color(0xffEFEFEF),

                         label: const Text('Refered Doctor',style: TextStyle(color: Colors.black54,fontSize: 14),)
                       ),
             ),
           ),
                      SizedBox(height: height * 0.013),
                      
                      SizedBox(
                        width:  width * 0.9,
                        height: height * 0.07,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          controller: address,
                          keyboardType:TextInputType.streetAddress,
                          validator: (value){
                            if (value!.isEmpty) {
                              return "Please enter Valid Address";
                            }
                            return null;
                          },

                          style: const TextStyle(color: Colors.black54),
                          decoration: InputDecoration(
                              // filled: true,
                              // focusColor: const Color(0xffEFEFEF),
                              // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                              errorStyle: const TextStyle(
                                color: Colors.transparent,
                                fontSize: 0,
                              ),
                              errorBorder: outline,
                              focusedErrorBorder: outline,
                              enabledBorder:outline,
                              focusedBorder:outline,
                              suffixIcon:  InkWell(
                                onTap: () async {
                                  _scrollIndicator( context, height, width);
                                  var userLocation = await Geolocator.getCurrentPosition();
                                  double lat= userLocation.latitude;
                                  double log=userLocation.longitude;
                                  List<Placemark> placeMarks = await placemarkFromCoordinates(lat,log);
                                  Placemark place = placeMarks[0];
                                  Placemark place2 = placeMarks[2];
                                  Map<String,String> addressMap = {
                                    "street":place2.subLocality.toString(),
                                    "postalCode": place.postalCode.toString(),
                                    "locality":place.locality.toString(),
                                    "state":place2.administrativeArea.toString(),
                                    "country":place2.country.toString()
                                  };
                                  var address = "${addressMap['street']!="" ? "${addressMap['street']}," : "" }${addressMap['locality']!="" ? "${addressMap['locality']}," : "" } ${addressMap['postalCode']!="" ? "${addressMap['postalCode']}," : "" } ${addressMap['state']!="" ? "${addressMap['state']}," : "" } ${addressMap['country']?? ""}";
                                  var addData = '${place2.subLocality}, ${place.postalCode}, ${place.locality}, ${place2.administrativeArea}, ${place.country}';
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (_) => setAddressPOPUP( context,height,width,address,addressMap)
                                  );

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset('assets/images/address_map.png',height: 23),
                                ),
                              ),
                              label: const Text('Address*',style: TextStyle(color: Colors.black54,fontSize: 14),)
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.013),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width:  width * 0.4,
                            height: height * 0.07,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.black,
                              controller: area,
                              style: const TextStyle(color: Colors.black54),
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value){
                                if (value!.isEmpty) {
                                  return "Please enter Valid Area";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  // filled: true,
                                  // focusColor: const Color(0xffEFEFEF),
                                  errorStyle: const TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                  ),
                                  // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                                  errorBorder: outline,
                                  focusedErrorBorder: outline,
                                  enabledBorder:outline,
                                  focusedBorder:outline,
                                  label: const Text('Area*',style: TextStyle(color: Colors.black54,fontSize: 14),)
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.08),
                          SizedBox(
                            width:  width * 0.4,
                            height: height * 0.07,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.black,
                              controller: pincode,
                              keyboardType: TextInputType.number,
                              // maxLength: 6,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter pincode";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.black54),
                              decoration: InputDecoration(
                                  // filled: true,
                                  // focusColor: const Color(0xffEFEFEF),
                                  // contentPadding: const EdgeInsets.only(bottom: 4,left: 12),
                                  errorStyle: const TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                  ),
                                  errorBorder: outline,
                                  focusedErrorBorder: outline,
                                  enabledBorder:outline,
                                  focusedBorder:outline,
                                  label: const Text('Pincode*',style: TextStyle(color: Colors.black54,fontSize: 14),)
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.013),
                      SizedBox(
                        width:  width * 0.9,
                        height: height * 0.07,
                        child: DropdownButtonFormField2(
                          dropdownDecoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(25) ,
                          ),
                          focusColor: Colors.white,
                          icon: const Padding(
                            padding: EdgeInsets.only(bottom: 7,right: 8),
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                          validator: (value) {
                            if ( selectedGender == null ) {
                              return "Please select Referral";
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black54),
                          decoration:  InputDecoration(
                            // contentPadding: ,
                            //   contentPadding: const EdgeInsets.only(bottom: 18,left: 10),
                            //   filled: true,
                            //   focusColor: const Color(0xffEFEFEF),
                              errorStyle: const TextStyle(
                                color: Colors.transparent,
                                fontSize: 0,
                              ),
                              errorBorder: outline,
                              focusedErrorBorder: outline,
                              enabledBorder:outline,
                              focusedBorder:outline,
                              label: const Text('Referal*',style: TextStyle(color: Colors.black54,fontSize: 14),)

                          ),
                          selectedItemBuilder: (BuildContext context) {
                            return referralList.map<Widget>((Referral item) {
                              return Text(item.type,
                                  style: const TextStyle(color: Colors.black));
                            }).toList();
                          },
                          items: referralList.map((Referral item) {
                            return DropdownMenuItem<String>(
                              value: item.type,
                              child: Text(
                                item.type,
                                style: const TextStyle(fontSize: 13, color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (referralList) {
                            setState(() {
                              selectedReferral = referralList.toString();
                              col = Colors.black54;
                              referralType = referralList.toString();

                              if (referralList == "Client") {
                                Navigator.pushNamed(context, "SearchClientReferral").then((value) {
                                  if (value != null){
                                      if(value!=false){
                                        Map<String,dynamic> data = value as Map<String,dynamic>;
                                        print(data);
                                        clientName.text = data['name'];
                                      }

                                    print(value);
                                  }
                                });

                              }

                            });
                          },

                          // onChanged: (referralList) {
                          //   setState(() {
                          //     selectedReferral = referralList.toString();
                          //   });
                          //   if(referralList == "Doctor"){
                          //     NavigateController.pagePush(context, const SearchReferralView(type: 'DOCTOR',));
                          //
                          //   }else{
                          //     NavigateController.pagePush(context, const SearchReferralView(type: '',));
                          //   }
                          // },
                          dropdownWidth: 160,
                          value: selectedReferral,
                          isExpanded: true,
                        ),
                      ),
                      SizedBox(height: height * 0.019),
                      Row(
                        children: <Widget>[
                          SizedBox(width: width * 0.06),
                          const Text("Remark",
                              style: TextStyle(color: Colors.black54,fontSize: 14))
                        ],
                      ),
                      SizedBox(height: height * 0.002),
                      SizedBox(
                        width:  width * 0.9,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black54),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          decoration: InputDecoration(
                              // filled: true,
                              // focusColor: const Color(0xffEFEFEF),
                            errorStyle: const TextStyle(
                              color: Colors.transparent,
                              fontSize: 0,
                            ),
                            errorBorder: outline,
                            focusedErrorBorder: outline,
                            enabledBorder:outline,
                            focusedBorder:outline,
                            ),
                        ),
                      ),
                      SizedBox(height: height * 0.013),
                      getReferralField(height,width),
                      SizedBox(height: height * 0.013),
                      InkWell(
                        onTap: (){
                          BookedServiceVM model = Provider.of<BookedServiceVM>(context, listen: false);

                          var listOfTest = model.getNewBookData;
                          print(listOfTest);

                          bool referralCompleted = false;
                          DateTime currentDateTime = DateTime.now();
                          LocalDB.getLDB('userID').then((value) {

                              DateFormat appDate =
                              DateFormat("yyyy-MM-dd HH:mm:ss");
                              DateFormat appTime =
                              DateFormat("yyyy-MM-dd HH:mm:ss");
                              if (_formkey.currentState!.validate()) {
                                if(listOfTest.length != 0){
                                  LocalDB.getLDB('userID').then((value) {
                                    Map<String,dynamic> params = {
                                      "titleCode": "Mr",
                                      "firstName": firstName.text,
                                      "middleName": "",
                                      "lastName": lastName.text,
                                      "age":  age.text.isEmpty ? '' : "${age.text}",//age.text.isEmpty ? '' : "${age.text}Y", //laxmi change
                                      "ageType": "Y",
                                      "dob": selectedDate.toString(),
                                      "gender": genderType,
                                      "mobileNumber": mobileNo.text,
                                      "whatsappNo": mobileNo.text,
                                      "emailID": emailID.text,
                                      "address": address.text,
                                      "countryNo": 91,
                                      "refferralTypeNo": 1,
                                      "customerNo": 0,
                                      "physicianNo": 0,
                                      "registeredDateTime": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),// "2022-05-07 10:20",
                                      "stateNo": 1,
                                      "cityNo": 3,
                                      "areaName": area.text,
                                      "pincode": pincode.text,
                                      "riderNo": value,
                                      "userNo": value,
                                      "lstCartList": listOfTest
                                    };
                                    // showDialog(
                                    //     context: context,
                                    //     barrierDismissible: false,
                                    //     builder: (_) => successStatusPOPUP(context,height,width,"3")
                                    // );
                                    ApiClient()
                                        .fetchData(
                                        ServerURL().getUrl(RequestType
                                            .InsertBooking),
                                        params)
                                        .then((response) {
                                      print("insertbooking $response");

                                      if (response["status"] == 1) {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => successStatusPOPUP(context,height,width,response["bookingID"])
                                        );
                                      }else{

                                      }
                                    }).catchError((error) {
                                      print(error);
                                    });
                                  });
                                }else{
                                  showGuide(context,"Please Add Test");
                                }


                                // if (referralType == "Self") {
                                //
                                //   setState(() {
                                //     referralCompleted = true;
                                //   });
                                //
                                // } else if (referralType == "Client") {
                                //   if(clientName.text.isNotEmpty){
                                //     setState(() {
                                //       referralCompleted = true;
                                //     });
                                //   }
                                // } else {
                                //   if(doctorName.text.isNotEmpty){
                                //     setState(() {
                                //       referralCompleted = true;
                                //     });
                                //   }
                                // }
                                // if(referralCompleted){
                                //   Map<String, dynamic> par = {
                                //     "AppointmentDate":
                                //     appDate.format(currentDateTime),
                                //     "AppointmentTime":
                                //     appTime.format(currentDateTime),
                                //     "PriceListID": "PL55",
                                //     "PhlebotomistID": value,
                                //     "Demographics": {
                                //       "Title": "Mr",
                                //       "FirstName": firstName.text,
                                //       "LastName": lastName.text,
                                //       "Age":age.text.isEmpty ? '' : "${age.text}Y",
                                //       "Gender": genderType == "Male" ? "M" : "F"
                                //     },
                                //     "Communication": {
                                //       "PhoneNo": mobileNo.text,
                                //       "Email": emailID.text,
                                //       "Address": address.text,
                                //       "Area": area.text,
                                //       // "City": ,
                                //       "Pincode": pincode.text
                                //     },
                                //     "lstBookingService": []
                                //   };
                                //   if (referralType == "Self") {
                                //     par["ReferralType"] = "SF";
                                //     par["DoctorID"] = doctorName.text;
                                //   } else if (referralType == "Client") {
                                //     par["ReferralType"] = "CLI";
                                //     par["ClientID"] = clientName.text;
                                //     par["DoctorID"] = doctorName.text;
                                //   } else {
                                //     par["ReferralType"] = "DR";
                                //     par["DoctorID"] = doctorName.text;
                                //   }
                                //   print(par);
                                //   ApiClient()
                                //       .fetchData(
                                //       ServerURL().getUrl(RequestType
                                //           .PhlebotomyInsertHomeCollection),
                                //       par)
                                //       .then((response) {
                                //     print(response);
                                //     if (response["Status"] == 1) {
                                //       showDialog(
                                //           context: context,
                                //           barrierDismissible: false,
                                //           builder: (_) => successStatusPOPUP(context,height,width,response["BookingID"])
                                //       );
                                //     }
                                //   }).catchError((error) {
                                //     print(error);
                                //   });
                                // }else{
                                //   showGuide(context,"Please Select Referral");
                                // }
                              }else{
                                showGuide(context,"Please Fill All Field");
                              }

                          });


                        },
                        child: Container(
                          height: 40,
                          width:120,
                          decoration: BoxDecoration(
                            color: CustomTheme.background_green,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: const Center(
                            child: Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
        )
    );
  }
  showGuide( BuildContext context,content){
    return showDialog(context: context, builder: (context){
      return  AlertDialog(

        title:Center(child:  Text(content)),
        actions: [
          Center(
            child: TextButton(onPressed: () async {

              Navigator.pop(context);
            },
                child:Container(
                  height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: CustomTheme.circle_green,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: const Center(child: Text("OK",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600),)))),
          ),

        ],
        shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0))),

      );
    }
    );
  }
  getReferralField(height,width){
    switch(referralType){
      case "Client":
        return Column(
          children: [
            SizedBox(
              width: width * 0.9,
              height: height * 0.07,
              child: TextFormField(
                readOnly: true,
                controller: clientName,
                onTap: () {
                  Navigator.pushNamed(context, "SearchClientReferral").then((value) {
                    if (value != null){

                      Map<String,dynamic> data = value as Map<String,dynamic>;
                      print(data);
                      clientName.text = data['name'].toString();
                      print(value);
                    }
                  });
                },
                decoration: InputDecoration(
                    // contentPadding: const EdgeInsets.only(bottom: 18,left: 10),
                    // filled: true,
                    // focusColor: const Color(0xffEFEFEF),
                    errorStyle: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 0,
                    ),
                    errorBorder: outline,
                    focusedErrorBorder: outline,
                    enabledBorder:outline,
                    focusedBorder:outline,
                    label: const Text('Client*',style: TextStyle(color: Colors.black54,fontSize: 14),)

                ),
              ),
            ),
            SizedBox(height: height * 0.013),
            doctorField(width,height, "Doctor(Optional)",)
          ],
        );
      case "Doctor":
        return doctorField(width,height, "Doctor");
      case "Self":
        return doctorField(width,height, "Doctor(Optional)");
      case '':
        return const SizedBox();
    }
  }
  Widget successStatusPOPUP(BuildContext context,height,width,bookingID){
    Color textBorder = const Color(0xff0272B1);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height:height * 0.24,
          width: width * 0.82,
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
              const Text("Patient Added Successfully",style: TextStyle(color:Colors.black54,fontSize: 18),),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      //NavigateController.pagePush(context,    PatientDetailsView(screenType: 1, bookingType: "APP", bookingID: bookingID, data2:{}));
                      NavigateController.pagePush(context, PaymentView(bookingID: bookingID, bookingType: 1,));
                      //NavigateController.pagePush(context,AppointmentView());

                    },
                    child: const Center(
                      child: Text( "Next",style: TextStyle(color:Color(0xff2454FF),fontSize: 15,fontWeight: FontWeight.w600),),
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
  Widget doctorField(width,height, String title) {
    return Column(
      children: [
        SizedBox(
          width: width * 0.9,
          height: height * 0.07,
          child: TextFormField(
            readOnly: true,
            controller: doctorName,
            onTap: () {
              Navigator.pushNamed(context, "SearchDoctorReferral").then((value) {
                if (value != null){
                  if(value != false){
                    Map<String,dynamic> data = value as Map<String,dynamic>;
                    print(data);
                    doctorName.text = data['name'].toString();
                  }
                  print(value);
                }
              });
            },
            decoration: InputDecoration(
                // filled: true,
                // focusColor: const Color(0xffEFEFEF),
                errorStyle: const TextStyle(
                  color: Colors.transparent,
                  fontSize: 0,
                ),
                errorBorder: outline,
                focusedErrorBorder: outline,
                enabledBorder:outline,
                focusedBorder:outline,
                label:  Text(title,style: const TextStyle(color: Colors.black54,fontSize: 14),)

            ),
          ),
        ),
      ],
    );
  }
  Widget setAddressPOPUP(BuildContext context,height,width,String adress,datas){
    print(datas);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height:height * 0.69,
          width: width * 0.89,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0)
          ),
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.01),
                Stack(
                  children: [
                    Positioned(
                        right: width * 0.04,
                        top: height * 0.004,
                        child: const Visibility(
                            visible: false,
                            child: Icon(Icons.zoom_out_map,color: Colors.black54,size: 20,))),
                    const Align(
                        alignment: Alignment.center,
                        child: Text("Current Location",style: TextStyle(color:Colors.black54,fontSize: 18),)),
                  ],
                ),
                SizedBox(height: height * 0.01),
                const Divider(color: Colors.black12,thickness: 1,),
                SizedBox(height: height * 0.01),
                SizedBox(
                  height:height * 0.4,
                  width: width * 0.8,
                  child:currentLoc == null ? const Center(child: CircularProgressIndicator()) :  GoogleMap(
                    // zoomGesturesEnabled: true, //enable Zoom in, out on map
                    initialCameraPosition: CameraPosition( //innital position in map
                      target: LatLng(currentLoc!.latitude,currentLoc!.longitude), //initial position
                      zoom: 17.0, //initial zoom level
                    ),
                    // markers: markers, //markers to show on map
                    // polylines: Set<Polyline>.of(polylines.values), //polylines
                    mapType: MapType.normal,
                    markers: markers,
                    myLocationEnabled: true,//map type
                    myLocationButtonEnabled: true,
                    onMapCreated: (controller) {
                      _controller.complete(controller); // method called when map is created
                      setState(() {
                        mapController = controller;
                      });
                    },
                  ),
                ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.04,
                    ),
                    const Text("Address",style: TextStyle(color:Colors.black54,fontSize: 14),),
                  ],
                ),
                SizedBox(height: height * 0.01),
                SizedBox(
                  width: width * 0.8,
                  height: height * 0.07,
                  child: TextFormField(
                    initialValue: adress,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 5,left: 7),
                      enabledBorder: outline,
                      focusedBorder:  outline,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
            InkWell(
              onTap: () {
                address.text = "${datas['street']!="" ? "${datas['street']}," : "" }${datas['state']}";
                pincode.text = datas['postalCode'].toString();
                area.text = datas['locality'].toString();
                Navigator.pop(context);
              },
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    color: CustomTheme.background_green,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26, offset: Offset(1, 2), blurRadius: 6)
                    ]),
                child: const Center(
                  child: Icon(Icons.done,color: Colors.white,)
              ),
            ),
            ),
                SizedBox(height: height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _scrollIndicator(BuildContext context,double height,double width){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  Dialog(
          child: SizedBox(
            height: 70,
            width:400,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                CircularProgressIndicator(),
                SizedBox(width: 25,),
                Text("Loading....",style: TextStyle(fontSize: 14),),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> selectDate(BuildContext context, selectedDate1) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        // helpText: "DOB",
        initialDate: selectedDate1,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(1980, 8),
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
    if (picked != null && picked != selectedDate1) {
      DateFormat dateformat = DateFormat('dd/MM/yyyy');
      DateFormat year = DateFormat('yyyy');
      var ag = year.format(picked);

      var now = year.format(DateTime.now());
      setState(() {
        selectedDate = picked;
        dob.text = dateformat.format(picked).toString();
        age.text = (int.parse(now) - int.parse(ag)).toString();
      });
    }
  }
}




class Gender {
  String gender;
  Gender(this.gender);
}

final List<Gender> genderList = [
  Gender("Male"),
  Gender("Female"),
];


class Referral {
  String type;
  Referral(this.type);
}

final List<Referral> referralList = [
  Referral("Self"),
  Referral("Doctor"),
  Referral("Client"),
];