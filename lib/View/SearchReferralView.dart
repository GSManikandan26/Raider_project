import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/Status.dart';
import '../ViewModel/ReferalDataVM.dart';



class SearchReferralView extends StatefulWidget {
  final String type;
  final String searchType;
  const SearchReferralView({Key? key, required this.type, required this.searchType}) : super(key: key);

  @override
  _SearchReferralViewState createState() => _SearchReferralViewState();
}

class _SearchReferralViewState extends State<SearchReferralView> {
  bool isFetching = true;
  final ReferalDataVM _api = ReferalDataVM();
  @override
  void initState() {
    // TODO: implement initState
    Map<String,dynamic> params = {
      "SearchKey": "",
      "SearchType": widget.searchType,
    };
    _api.fetchHistoryDetails(params);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: const Color(0xffEFEFEF),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: height * 0.1,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context, false);
                          }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                          SizedBox(
                            width: width * 0.78,
                            height: height *0.07,
                            child: Center(
                              child: TextFormField(
                                // controller: searchKey,
                                // onChanged: (value) {
                                //   if (value.length > 2) {
                                //     searchPatient(value.toString());
                                //   }
                                //
                                // },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(top: 4,left: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(color: Colors.white)
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(color: Colors.white)
                                    ),
                                    hintText: 'Search'
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.03,)
                        ],
                      ),
                    ],
                  )),
              Container(
                  height: height * 0.86,
                  child:ChangeNotifierProvider<ReferalDataVM>(
                    create: (BuildContext context) => _api,
                    child: Consumer<ReferalDataVM>(builder: (context, viewModel, _) {
                      switch (viewModel.getHistoryList.status) {
                        case Status.Loading:
                          return  const Center(child: CircularProgressIndicator());
                        case Status.Error:
                          return const Center(child: Center(child: Text("Something Issue"),))  ;
                        case Status.Completed:
                        // updateData();
                          var VM = viewModel.getHistoryList.data!;
                          return
                            VM.lstReferalDetails == null ?
                            const Center(child:Center(child: Text("No Record Found",style: TextStyle(fontWeight: FontWeight.bold),),)) :
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Flex(direction: Axis.vertical,
                                    children: [
                                      ListView.builder(
                                        itemCount:VM.lstReferalDetails!.length ,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                                            child: Card(
                                              color: Colors.white,
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(15))),
                                              child: ListTile(
                                                onTap: () {
                                                  Map<String,dynamic> data = {
                                                    'name':VM.lstReferalDetails![index].commonID.toString(),
                                                    'id':VM.lstReferalDetails![index].commonID.toString()
                                                  };
                                                  Navigator.pop(context,data);

                                                  // [{"CustomerID":"CUS678","ServiceNo":"73162","ServiceCode":"Albumin","ServiceType":"ANA","IsFasting":false,"Remarks":"NIL"}]
                                                },
                                                leading:  CircleAvatar(
                                                  backgroundColor:  const Color(0xffEFEFEF),
                                                  radius: 26,
                                                  child: widget.type == "DOCTOR" ?Image.asset('assets/images/doctor.png',height: height*0.4,):Image.asset('assets/images/client.png',height: height*0.04,) ,
                                                ),
                                                title:  Text("${VM.lstReferalDetails![index].commonID}",style: const TextStyle(fontSize: 15,color: Color(0xff2454FF),fontWeight: FontWeight.w400)),
                                                subtitle:  Text("${VM.lstReferalDetails![index].commonName}",style: const TextStyle(fontSize: 12,color: Colors.grey),),
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
      ),
    ),
        )
    );
  }
}
