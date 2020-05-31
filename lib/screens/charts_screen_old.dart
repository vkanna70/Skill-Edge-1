import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Sales.dart';
import 'package:flutter/material.dart';

class ChartsScreen extends StatefulWidget {
  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  List<charts.Series<Sales, String>> _seriesBarData;
  List<Sales> mydata;
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Sales, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Sales sales, _) => sales.firstname.toString(),
        measureFn: (Sales sales, _) => sales.skillindex,
//        colorFn: (Sales sales, _) =>
//            charts.ColorUtil.fromDartColor(Color(int.parse(sales.colorVal))),
        id: 'Skill index by team member',
        data: mydata,
        labelAccessorFn: (Sales row, _) => "${row.firstname}",
      ),
    );
  }
//double calcskillavg(List Sales){
//    double skillindexavg = 1;
//    return skillindexavg;
//}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Skill Index by Team member')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('teammembers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Sales> skills = snapshot.data.documents
              .map((documentSnapshot) => Sales.fromMap(documentSnapshot.data))
              .toList();
          List<Sales> skills1 = [];
          skills1 = skills.getRange(0, 4).toList();
          print('this is skills1 - $skills1');
//          int noofrecords = skills.length;
//          double averageofskillindices = calcskillavg(skills);
//          skills = [Record<3:flora>, Record<4:Murali>, Record<3:newone>, Record<2:Anotherone>, Record<4:entered now>, Record<2:Brand new>, Record<4:addedbyapp>, Record<3:addedbyapp>, Record<1:addedbyapp>, Record<4:venkatesh>, Record<1:notpass>, Record<4:Ajay Subbarayulu>];
          return _buildChart(context, skills1);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Sales> saledata) {
    mydata = saledata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Skills by Team member',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 1),
//                  behaviors: [
//                    new charts.DatumLegend(
//                      entryTextStyle: charts.TextStyleSpec(
//                          color: charts.MaterialPalette.purple.shadeDefault,
//                          fontFamily: 'Georgia',
//                          fontSize: 18),
//                    )
//                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//class ChartsScreen extends StatefulWidget {
//  @override
//  _ChartsScreenState createState() => _ChartsScreenState();
//}
//
//class _ChartsScreenState extends State<ChartsScreen> {
//  final _auth = FirebaseAuth.instance;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          leading: null,
//          centerTitle: true,
//          actions: <Widget>[
//            IconButton(
//                icon: Icon(Icons.close),
//                onPressed: () {
//                  _auth.signOut();
//                  Navigator.pop(context);
//                }),
//          ],
//          title: Text('⚡️Future Readiness Dashboard'),
//          backgroundColor: Colors.lightBlueAccent,
//        ),
//      body:
////        Center(child: Text('This is Charts Screen'),),
//    Center(child:SimplePieChart(seriesList),),
//      );
//  }
//}
