//import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ReadinessChartScreen extends StatefulWidget {
  @override
  _ReadinessChartScreenState createState() => _ReadinessChartScreenState();
}

class _ReadinessChartScreenState extends State<ReadinessChartScreen> {
  bool toggle = false;
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.red,
    Colors.green,
  ];
  int readycount = 0;
  int notreadycount = 0;
  int onlyreadycount = 0;
  int mynotreadycount = 0;

  Future<int> countReadies() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('teammembers')
        .where("readiness", isEqualTo: "yes")
        .getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    print(_myDocCount.length);
    int myreadycount = _myDocCount.length; // Count of Documents in Collection
    print(myreadycount);
    return myreadycount;
  }

  Future<int> countNotReadies() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('teammembers')
        .where("readiness", isEqualTo: "no")
        .getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    print(_myDocCount.length);
    int mynotreadycount =
        _myDocCount.length; // Count of Documents in Collection
    print(mynotreadycount);
    return mynotreadycount;
  }

  @override
  Widget build(BuildContext context) {
    countReadies().then((val) {
      readycount = val;
    });
    print('Newly determined readycount is ' + readycount.toString());

    countNotReadies().then((val) {
      notreadycount = val;
    });
    print('Newly determined notreadycount is ' + notreadycount.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Overall Readiness Summary"),
      ),
      body: Container(
        child: Center(
          child: toggle
              ? StreamBuilder<QuerySnapshot>(
                  stream:
                      Firestore.instance.collection('teammembers').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      );
                    }
                    countReadies().then((val) {
                      readycount = val;
                    });
//                    print('Newly determined readycount is ' +
//                        readycount.toString());
//
//                    countNotReadies().then((val) {
//                      notreadycount = val;
//                    });
//                    print('Newly determined notreadycount is ' +
//                        notreadycount.toString());

                    dataMap.putIfAbsent(
                        "Not Ready", () => notreadycount.toDouble());
                    dataMap.putIfAbsent("Ready", () => readycount.toDouble());
                    return PieChart(
                      dataMap: dataMap,
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 32.0,
                      chartRadius: MediaQuery.of(context).size.width / 1.1,
                      showChartValuesInPercentage: false,
                      showChartValues: true,
                      showChartValuesOutside: false,
                      chartValueBackgroundColor: Colors.grey[200],
                      colorList: colorList,
                      showLegends: true,
                      legendPosition: LegendPosition.bottom,
                      decimalPlaces: 1,
                      showChartValueLabel: true,
                      initialAngle: 0,
                      chartValueStyle: defaultChartValueStyle.copyWith(
                        color: Colors.blueGrey[900].withOpacity(0.9),
                      ),
                      chartType: ChartType.disc,
                    );
                  },
                )
              : Text('Press FAB to show chart'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: togglePieChart,
        child: Icon(Icons.insert_chart),
      ),
    );
  }

  void togglePieChart() {
    setState(() {
      toggle = !toggle;
    });
  }
}

//class ReadinessChartScreen extends StatefulWidget {
//  @override
//  _ReadinessChartScreenState createState() => _ReadinessChartScreenState();
//}
//
//class _ReadinessChartScreenState extends State<ReadinessChartScreen> {
//  Map<String, double> dataMap = Map();
//  @override
//  void initState() {
//    TeamMemberNotifier teamMemberNotifier =
//        Provider.of<TeamMemberNotifier>(context, listen: false);
//    getTeamMembers(teamMemberNotifier);
//    dataMap.putIfAbsent("Flutter", () => 5);
//    dataMap.putIfAbsent("React", () => 3);
//    dataMap.putIfAbsent("Xamarin", () => 2);
//    dataMap.putIfAbsent("Ionic", () => 2);
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    TeamMemberNotifier teamMemberNotifier =
//        Provider.of<TeamMemberNotifier>(context);
//    List<TeamMember> _teamMembers = teamMemberNotifier.teammemberlist;
//    int _readyCount =
//        _teamMembers.where((p) => p.readiness.contains('yes')).toList().length;
//    int _notreadyCount =
//        _teamMembers.where((p) => p.readiness.contains('yes')).toList().length;
//    _myMap =
//
//    return Scaffold(
//      appBar: AppBar(title: Text('Skill Index by Team member')),
//      body: _buildBody(context),
//    );
//  }
//
//  Widget _buildBody(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('teammembers').snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return LinearProgressIndicator();
//        } else {
//          List<Readiness> readiness = snapshot.data.documents
//              .map((documentSnapshot) =>
//                  Readiness.fromMap(documentSnapshot.data))
//              .toList();
//          List<Readiness> readiness1 = [];
//          readiness1 = readiness.getRange(0, 4).toList();
//          print('this is readiness1 - $readiness1');
////          int noofrecords = skills.length;
////          double averageofskillindices = calcskillavg(skills);
////          skills = [Record<3:flora>, Record<4:Murali>, Record<3:newone>, Record<2:Anotherone>, Record<4:entered now>, Record<2:Brand new>, Record<4:addedbyapp>, Record<3:addedbyapp>, Record<1:addedbyapp>, Record<4:venkatesh>, Record<1:notpass>, Record<4:Ajay Subbarayulu>];
//          return _buildChart(context, readiness1);
//        }
//      },
//    );
//  }
//
//  Widget _buildChart(BuildContext context, List<Readiness> readinessdata) {
//    mydata = readinessdata;
//    _generateData(mydata);
//    return Padding(
//      padding: EdgeInsets.all(8.0),
//      child: Container(
//        child: Center(
//          child: Column(
//            children: <Widget>[
//              Text(
//                'Skills by Team member',
//                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//              ),
//              SizedBox(
//                height: 10.0,
//              ),
//              Expanded(
//                child: charts.BarChart(
//                  _seriesBarData,
//                  animate: true,
//                  animationDuration: Duration(seconds: 1),
////                  behaviors: [
////                    new charts.DatumLegend(
////                      entryTextStyle: charts.TextStyleSpec(
////                          color: charts.MaterialPalette.purple.shadeDefault,
////                          fontFamily: 'Georgia',
////                          fontSize: 18),
////                    )
////                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}

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
