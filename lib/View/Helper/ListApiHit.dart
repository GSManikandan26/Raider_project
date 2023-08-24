import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Utils/NavigateController.dart';
import 'Drawer.dart';


List<Map<String,dynamic>> listHitData = [];

class ListApi extends StatefulWidget {
  const ListApi({Key? key}) : super(key: key);

  @override
  _ListApiState createState() => _ListApiState();
}

class _ListApiState extends State<ListApi> {
  DateFormat dateFormatterTime = DateFormat('hh:mm a');
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(listHitData);
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          key: scaffoldkey,
          drawer: HomeDrawer(height: height, width: width, selectedScreen: -1,),
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(13.0),
              child: InkWell(
                  onTap: () {
                    scaffoldkey.currentState!.openDrawer();
                  },
                  child:Icon(Icons.menu,color: Colors.black,)),
            ),
            backgroundColor: Colors.white,

          ),
          body: ListView.builder(
            itemCount: listHitData.length,
            itemBuilder: (BuildContext context, int index) {
              List<Map<String,dynamic>> data = listHitData.reversed.toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: ListTile(
                      tileColor: Colors.white,
                      onTap: (){
                        NavigateController.pagePush(context, ViewApiHit(index: index,));
                      },
                      title: Text(data[index]['url'],style: const TextStyle(color: Colors.blue),),
                        trailing: Text(dateFormatterTime.format(data[index]['time'] ?? DateTime.now())),
                    ),
                  ),
                ),
              );
            },),
        )
    );
  }
}

class ViewApiHit extends StatefulWidget {
  final int index;
  const ViewApiHit({Key? key, required this.index}) : super(key: key);

  @override
  _ViewApiHitState createState() => _ViewApiHitState();
}

class _ViewApiHitState extends State<ViewApiHit> {
  DateFormat dateFormatterTime = DateFormat('hh:mm a');
  List<Map<String,dynamic>> data = listHitData.reversed.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Response'),

        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(dateFormatterTime.format(data[widget.index]['time'] ?? DateTime.now())),
          ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("URL:",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 16),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${data[widget.index]['url']}"),
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("params: ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 16),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${data[widget.index]['params']}"),
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text("response: ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 16),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${data[widget.index]['body']}"),
            ),
          ],
        ),
      ),
    );
  }
}

