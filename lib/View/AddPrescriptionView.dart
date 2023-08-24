import 'dart:convert';
import 'dart:io';

import 'package:botbridge_green/MainData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Model/ApiClient.dart';
import '../Model/ServerURL.dart';
import '../Utils/NavigateController.dart';
import 'Helper/ThemeCard.dart';




class AddPrescriptionView extends StatefulWidget {
  final String bookingID;
  const AddPrescriptionView({Key? key, required this.bookingID}) : super(key: key);

  @override
  _AddPrescriptionViewState createState() => _AddPrescriptionViewState();
}

class _AddPrescriptionViewState extends State<AddPrescriptionView> {
  final ImagePicker pickImage = ImagePicker();
  List<XFile>? selectedImages = [];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffEFEFEF),
          body:Column(
            children: [
              Container(
                height: height * 0.07,
                width: width,
                decoration: BoxDecoration(
                    color: CustomTheme.background_green,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(height * 0.8/25))
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
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(11),
                        child: Text("Add Prescription",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              selectedImages!.isNotEmpty && selectedImages!= null?
              Flex(
                direction: Axis.vertical,
                children: [
                  GridView.builder(
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                      ),
                      itemCount: selectedImages!.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(
                                File(selectedImages![index].path),
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      selectedImages!.removeAt(index);
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.redAccent,
                                    child: Center(
                                      child: Icon(Icons.clear,size: 15,color: Colors.white,)
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                    height: height/20,
                                    child:const Center(
                                        child:  Text("Image.jpg"))),
                              )
                            ],
                          ),
                        );
                      }),
                ],
              ) : const SizedBox(
                child: Align(
                    alignment: Alignment.center,
                    child: Text("")),
              ),
            ],
          ) ,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              openSheet();
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            hoverColor: Colors.transparent,
            child:  Image.asset('assets/images/upload_prescription.png',height: height*0.076),
          ),
        )
    );
  }
  _isStorage() async{
    var isStorage =await Permission.storage.status;
    if(!isStorage.isGranted){
      await Permission.storage.request();
    }
    if( await Permission.storage.isGranted){
      uploadImage();
    }else{
      Navigator.pop(context);
    }
  }
  Future<void> uploadImage() async {
    final List<XFile>? selectedImage = await pickImage.pickMultiImage();
    if(selectedImage != null){
      if(selectedImage.isNotEmpty){
        setState(() {
          selectedImages!.addAll(selectedImage);
        });

      }
    }
  }

  void imagePicker(int type) async {
    // Navigator.pop(context);
    File? _image;
    final image = await pickImage.pickImage(source:type == 0 ? ImageSource.camera :  ImageSource.gallery, imageQuality: 100);
    print(image?.path);
    try {
      if (image?.path != null) {
        setState(() {
          _image = File(image!.path);
        });
        convert(_image);
        Map<String,dynamic> params =
        {
          "bookingID": widget.bookingID,
          "venueNo": MainData.tenantNo,
          "venueBranchNo": MainData.tenantBranchNo,
          "prescriptionImgst": [
            {
              "imageType": "",
              "imageName": image!.name.toString(),
              "base64": convert(_image)
            }
          ]
        };


        // {
        //   "BookingID":"",
        //   "ImageType":"jpg",
        //   "ImageName": "image",
        //   "Image": convert(_image).toString()
        // };

        ApiClient().fetchData(ServerURL().getUrl(RequestType.UploadPrescription), params).then((value){


          // if(value["status"] == 1){
            setState(() {
              selectedImages = [image];
            });
            // Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Uploaded..",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 14.0
            );
          // }

        });

      }
    } catch (e){
      print(e);
    }
  }


  openSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Capture Image'),
                onTap: () {
                  Navigator.pop(context);
                  imagePicker(0);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Select Image'),
                onTap: () {
                  Navigator.pop(context);
                  imagePicker(1);
                },
              ),
            ],
          );
        });
  }

}

convert(_image) {
  String img = base64Encode(_image.readAsBytesSync());
  return img;
}
