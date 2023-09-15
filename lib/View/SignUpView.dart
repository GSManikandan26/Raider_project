import 'package:botbridge_green/Utils/NavigateController.dart';
import 'package:botbridge_green/View/Helper/ThemeCard.dart';
import 'package:botbridge_green/View/HomeView.dart';
import 'package:botbridge_green/View/LoginView.dart';
import 'package:botbridge_green/ViewModel/SignInVM.dart';
import 'package:botbridge_green/services/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';



class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
    final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
    final TextEditingController _username = TextEditingController();
  // final TextEditingController _dob = TextEditingController();
  // final TextEditingController _location = TextEditingController();
  final AuthService authService = AuthService();
  String gender="male" ;

void signupUser() {
    authService.signUpUser(
      context: context,
      email: _email.text,
      password: _password.text,
      name: _name.text,
      //  userName: _username.text, 
      //  age: "20", 
      //  gender: 'male',
    );
  }

// // sign up

//   bool _isupload = false;
//    bool showProgress = false;
//   bool visible = false;
//   final _auth = FirebaseAuth.instance;
//   // final _formkey = GlobalKey<FormState>();
//   // final bool _isObscure = true;

//  void signUp(
//     String email,
//     String username,
//     String password,
//     String gender,
//     String name,
//     String mobile, 
//   ) async {
//     print("pressed");
//     setState(() {
//       _isupload = true;
//     });

// if(await checkMobileExists(_mobile.text)){
// showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: const Text('Mobile number alredy exist'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder:(context) => const LoginView(),));
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
// }else{
//     if (_formkey.currentState!.validate()) {
//       await _auth
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .then((value) => {
//                 postDetailsToFirestore(email,username, gender, name, password, mobile)
//               })
//           // ignore: body_might_complete_normally_catch_error
//           .catchError((e) {
//             if (e is FirebaseAuthException) {
//           if (e.code == 'email-already-in-use') {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: const Text('Error'),
//                   content: const Text('User with this email already exists.'),
//                   actions: <Widget>[
//                     TextButton(
//                       child: const Text('OK'),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         setState(() {
//       _isupload = false;
//     });
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         }
//           });
//     }
// }

//     setState(() {
//       _isupload = false;
//     });
//   }

//   postDetailsToFirestore(String email,String username,String gender, String name,
//       String password, String mobile,) async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     User? user = _auth.currentUser;
//     SignupUser userModel = SignupUser();
//     userModel.email = email;
//     userModel.userName = username;
//     userModel.gender = gender;
//     userModel.name = name;
//     userModel.mobile = mobile;
//     userModel.password = password;
//     await firebaseFirestore
//         .collection("users")
//         .doc(username.toString())
//         .set(userModel.toMap());

//     setState(() {
//       _isupload = false;
//     });
//      showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Success'),
//           content: const Text('user created successfully'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => const LoginView(),));
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
 

  
  
//   Future<bool> checkMobileExists(String mobile) async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     QuerySnapshot querySnapshot = await firebaseFirestore
//         .collection("users")
//         .where('mobile', isEqualTo: mobile)
//         .limit(1)
//         .get();

//     return querySnapshot.docs.isNotEmpty;
// }


  @override
  void initState() {
    // TODO: implement initState
    _permission();
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
            backgroundColor: CustomTheme.background_green,
      body: Stack(
          children: [
            Positioned(
              top: -height * 0.07,
                left: - width * 0.15,
                child: Container(
              height: height * 0.3,
              width:height * 0.3 ,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomTheme.circle_green
              ),
            )),
            Positioned(
                top: height * 0.09,
                left:  width * 0.1,
                child: const Text("Let's GO !",style: TextStyle(color: Colors.white,fontSize: 25),)),

            Positioned(
                bottom: -height * 0.12,
                left: - width * 0.12,
                child: Container(
                  height: height * 0.3,
                  width:height * 0.3 ,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomTheme.circle_green
                  ),
                )),
            AnimatedPositioned(
                top: MediaQuery.of(context).viewInsets.bottom > 0.0 ?height * 0.03 : height * 0.18,
                left: MediaQuery.of(context).viewInsets.bottom > 0.0 ?width * 0.03:  width * 0.42,
                curve: Curves.easeInCubic,
                duration: const Duration(milliseconds: 90),
                child: Image.asset('assets/images/add_appointment.png',
                  height:MediaQuery.of(context).viewInsets.bottom > 0.0 ? height*0.05: height*0.08,),
            ),
            Align(
              alignment: Alignment.center,
              child:Container(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        SizedBox(height: height*0.25,),

            ////////////    user name/////////////////
                        SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              controller: _username,
                              textInputAction: TextInputAction.next,
                              validator: (value){
                                if(value!.length <4){
                                  return "Please Enter Valid Username";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration:  InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white60 )
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white60 )
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.orangeAccent )
                                  ),
                                  focusedErrorBorder:const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.orangeAccent )
                                  ) ,
                                  errorStyle: const TextStyle(color: Colors.deepOrangeAccent,fontSize: 12),
                                  suffixIcon:  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset('assets/images/user_name.png',height: 23,color: Colors.white,),
                                  ),
                                  label: const Text('Username',style: TextStyle(color: Colors.white60),)
                              ),
                            )),
                        SizedBox(height: height*0.02,),

////////////////////////name//////////////////////////////

                        SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              controller: _name,
                              textInputAction: TextInputAction.next,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please Enter Valid Name";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration:  InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white60 )
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white60 )
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.orangeAccent )
                                  ),
                                  focusedErrorBorder:const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.orangeAccent )
                                  ) ,
                                  errorStyle: const TextStyle(color: Colors.deepOrangeAccent,fontSize: 12),
                                  suffixIcon:  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset('assets/images/id.png',height: 23,color: Colors.white,),
                                  ),
                                  label: const Text('Name',style: TextStyle(color: Colors.white60),)
                              ),
                            )),
                        SizedBox(height: height*0.02,),
//////////////////////////////email//////////////////////////////////

                        SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              controller: _email,
                              textInputAction: TextInputAction.next,
                              validator: (value){
                                if(value!.length <4){
                                  return "Please Enter Valid email id";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration:  InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white60 )
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white60 )
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.orangeAccent )
                                  ),
                                  focusedErrorBorder:const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.orangeAccent )
                                  ) ,
                                  errorStyle: const TextStyle(color: Colors.deepOrangeAccent,fontSize: 12),
                                  suffixIcon:  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset('assets/images/smartphone.png',height: 23,color: Colors.white,),
                                  ),
                                  label: const Text('Email',style: TextStyle(color: Colors.white60),)
                              ),
                            )),
                        SizedBox(height: height*0.02,),
///////////////////////////////mobile///////////////////////////////

                        SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              controller: _mobile,
                              textInputAction: TextInputAction.next,
                              validator: (value){
                                if(value!.length <4){
                                  return "Please Enter Valid Mobile Number";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration:  InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white60 )
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white60 )
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.orangeAccent )
                                  ),
                                  focusedErrorBorder:const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.orangeAccent )
                                  ) ,
                                  errorStyle: const TextStyle(color: Colors.deepOrangeAccent,fontSize: 12),
                                  suffixIcon:  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset('assets/images/smartphone.png',height: 23,color: Colors.white,),
                                  ),
                                  label: const Text('Mobile Number',style: TextStyle(color: Colors.white60),)
                              ),
                            )),
                        SizedBox(height: height*0.02,),

/////////////////////////////password///////////////////////////////////

                        SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              controller: _password,
                              textInputAction: TextInputAction.done,
                              validator: (value){
                                if(value!.length <2){
                                  return "Please Enter Valid Password";
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration:  InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white60 )
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.white60 )
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.orangeAccent )
                                  ),
                                  focusedErrorBorder:const UnderlineInputBorder(
                                      borderSide: BorderSide(color:Colors.orangeAccent )
                                  ) ,
                                  errorStyle: const TextStyle(color: Colors.deepOrangeAccent,fontSize: 12),
                                  suffixIcon:  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset('assets/images/password.png',height: 23,color: Colors.white,),
                                  ),
                                  label: const Text('Password',style: TextStyle(color: Colors.white60),)
                              ),
                            )),
                        // SizedBox(height: height*0.01,),
                        // Row(
                        //   children: [
                        //     const Spacer(),
                        //     const Text('Forgot Password?',style: TextStyle(color: Colors.white60,fontSize: 12),),
                        //     SizedBox(width: width*0.05),
                        //   ],
                        // ),
                        SizedBox(height: height*0.04),
                        SizedBox(
                          width: 150,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.white
                                ),
                                elevation: MaterialStateProperty.all(7)
                            ),
                            onPressed: () {
                              signupUser();
                              
                              // NavigateController.pagePush(context, const HomeView());
                              // Map<String,dynamic> data = {
                              //   "userName": _email.text,
                              //   "password": _password.text,
                              //   "deviceType": "ANDROID",
                              //   "requestType": "HC",
                              //   "latitude": "",
                              //   "longitude": ""
                              // };
                              // print(data);
                              // if(_formkey.currentState!.validate()){
                              //   SignInVM foodNotifier = Provider.of<SignInVM>(context, listen: false);
                              //   loginMain( context, data,foodNotifier,true);
                              // }

                            },
                            child: const Text('Sign Up',style: TextStyle(color: Colors.green,fontSize: 19,fontWeight: FontWeight.w600),),
                          ),
                        ),
                        SizedBox(height: height*0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Text("I Have an Account?",style: TextStyle(color: Colors.white60,fontSize: 14),),
                            const SizedBox(width: 5,),
                            TextButton(child: const Text('SignIn',style: TextStyle(color: Colors.indigo,fontSize: 16,fontWeight: FontWeight.bold),), onPressed:() {
                              Navigator.push(context, MaterialPageRoute(builder:(context) =>const LoginView() ));
                            }),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),),

          ],
      ),
    ),
        ));
  }

  void _permission()async {
    var accessLocation = await Permission.location.status;

    if(!accessLocation.isGranted){
      await Permission.location.request();
    }

    if( await Permission.location.isGranted){
      print("done");
    }else{
      SystemNavigator.pop();
    }

  }
}














