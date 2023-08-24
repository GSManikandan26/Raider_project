import 'package:botbridge_green/View/AddPrescriptionView.dart';
import 'package:botbridge_green/View/PaymentView.dart';
import 'package:botbridge_green/View/TabbarView.dart';
import 'package:flutter/material.dart';

import '../Utils/NavigateController.dart';
import 'Helper/ThemeCard.dart';



class TestsViewView extends StatefulWidget {
  const TestsViewView({Key? key}) : super(key: key);

  @override
  _TestsViewViewState createState() => _TestsViewViewState();
}

class _TestsViewViewState extends State<TestsViewView> {
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
                          NavigateController.pagePOP(context);
                        },
                        child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(11),
                    child: Text("Tests",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.06),
          InkWell(
            onTap: (){
              NavigateController.pagePush(context, const SearchTests(referalID: '', BookingID: '', bookingType: '',));
            },
            child: Container(
              height: height * 0.08,
              width: width * 0.93,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(height * 0.5/28)),
              child:  Stack(
                children:  [
                  Positioned(
                    top:height * 0.017,
                    left: width * 0.04,
                    child: const Icon(Icons.youtube_searched_for,color: Colors.black38,size: 30,),
                  ),
                  Positioned(
                      top:height * 0.022,
                      left: width * 0.18,
                      child: const Text('Add More Test',style: TextStyle(color: Color(0xff203298),fontWeight: FontWeight.w600,fontSize: 17),)
                  )
                ],
              ),
              ),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: (){
              // NavigateController.pagePush(context, const AddPrescriptionView());
            },
            child: Container(
                height: height * 0.08,
                width: width * 0.93,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(height * 0.5/28)),
              child: Stack(
                children:  [
                  Positioned(
                    top:height * 0.017,
                    left: width * 0.04,
                    child: const Icon(Icons.add_box_outlined,color: Colors.black38,size: 30,),
                  ),
                  Positioned(
                      top:height * 0.022,
                      left: width * 0.18,
                      child: const Text('Add Prescription',style: TextStyle(color: Color(0xff203298),fontWeight: FontWeight.w600,fontSize: 17),)
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: (){
              // NavigateController.pagePush(context, const PaymentView(bookingID: '',));
            },
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
          SizedBox(height: height * 0.02),
        ],
      ) ,
    ));
  }
}
