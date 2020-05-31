import 'package:flash_chat/screens/charts_screen.dart';
import 'package:flash_chat/screens/clikvarsity_screen.dart';
import 'package:flash_chat/screens/teammembersfeed.dart';
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _currentBnbIndex = 0;
  final List<Widget> _children = [
//    MemberlistScreen(),
    TeamMembersFeed(),
//    ChartsScreen(),
    ReadinessChartScreen(),
    ClikvarsityScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentBnbIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBnbIndex,
        type: BottomNavigationBarType.fixed,
//        backgroundColor: Colors.lightBlue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
//            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text('Charts'),
//            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Clikvarsity'),
//            backgroundColor: Colors.lightBlue,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentBnbIndex = index;
          });
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) =>
//                  ChartsScreen(),
//            ),
//          );
        },
      ),
    );
  }
}

//class MyBottomNavBar extends StatefulWidget {
//  @override
//  _MyBottomNavBarState createState() => _MyBottomNavBarState();
//}
//
//class _MyBottomNavBarState extends State<MyBottomNavBar> {
//  int _currentBnbIndex = 0;
////  final List<Widget> _children = [MemberlistScreen(), ChartsScreen(),ClikvarsityScreen()];
//  final List<Widget> _children = [MemberlistScreen(), ChartsScreen(),ClikvarsityScreen()];
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: _children[_currentBnbIndex],
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _currentBnbIndex,
//        type: BottomNavigationBarType.fixed,
////        backgroundColor: Colors.lightBlue,
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: Text('Home'),
////            backgroundColor: Colors.lightBlue,
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.insert_chart),
//            title: Text('Charts'),
////            backgroundColor: Colors.lightBlue,
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.school),
//            title: Text('Clikvarsity'),
////            backgroundColor: Colors.lightBlue,
//          ),
//        ],
//        onTap: (index) {
//          setState(() {
//            _currentBnbIndex = index;
//          });
//        },
//      ),
//    );
//  }
//}
