import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/member_skills_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _firestore = Firestore.instance;

class MemberlistScreen extends StatefulWidget {
  static const String id = 'member_list_screen';
  @override
  _MemberlistScreenState createState() => _MemberlistScreenState();
}

class _MemberlistScreenState extends State<MemberlistScreen> {
  final _auth = FirebaseAuth.instance;
//  int _currentBnbIndex = 0;
//  final List<Widget> _children = [MemberlistScreen(), ChartsScreen(),ClikvarsityScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Future Readiness'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: 'Search by name or towername',
            ),
            onChanged: (String) {},
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('teammembers').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  ;
                  final teammembers = snapshot.data.documents.toList();
                  final filteredteam = teammembers;
                  return FirestoreListView(documents: teammembers);
                }),
          ),
        ],
      ),
    );
  }
}

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  FirestoreListView({this.documents});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              documents[index].data['firstname'],
              style: TextStyle(fontSize: 20, color: Colors.lightBlue),
            ),
            subtitle: (documents[index].data['role'] != null)
                ? Text(documents[index].data['role'])
                : Text('Unspecified'),
            trailing: (documents[index].data['readiness'] == 'yes')
                ? Icon(Icons.check_circle_outline,
                    size: 30, color: Colors.greenAccent)
                : Icon(Icons.block, size: 30, color: Colors.redAccent),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MemberskillsScreen(members: documents[index]),
                ),
              );
            },
          );
        });
  }
}

//class MyBottomNavBar extends StatefulWidget {
//  @override
//  _MyBottomNavBarState createState() => _MyBottomNavBarState();
//}
//
//class _MyBottomNavBarState extends State<MyBottomNavBar> {
//  int _currentBnbIndex = 0;
//  final List<Widget> _children = [
////    MemberlistScreen(),
//    TeamMembersFeed(),
//    ChartsScreen(),
//    ClikvarsityScreen()
//  ];
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
////          Navigator.push(
////            context,
////            MaterialPageRoute(
////              builder: (context) =>
////                  ChartsScreen(),
////            ),
////          );
//        },
//      ),
//    );
//  }
//}
