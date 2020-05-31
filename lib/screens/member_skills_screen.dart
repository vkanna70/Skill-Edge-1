import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/skill_detail_screen.dart';
import 'package:flutter/material.dart';

class MemberskillsScreen extends StatefulWidget {
  final DocumentSnapshot members;
  MemberskillsScreen({this.members});
  static const String id = 'member_skills_screen';
  @override
  _MemberskillsScreenState createState() => _MemberskillsScreenState();
}

class _MemberskillsScreenState extends State<MemberskillsScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
//Practitioner readiness check based on a comparison of current and required skill sets
    List<dynamic> curSkillValues = widget.members.data['curskillvalues'];
    List<dynamic> reqSkillValues = widget.members.data['reqskillvalues'];

    bool _listB_lessoreq_listA(List one, List two) {
      var i = -1;
      return one.every((element) {
        i++;
        return two[i] <= element;
      });
    }

    bool readiness = _listB_lessoreq_listA(curSkillValues, reqSkillValues);
    String readinessUpdate = readiness ? "yes" : "no";
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
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
        title: Text('⚡' + widget.members.data['firstname']),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    dense: false,
                    //contentPadding: EdgeInsets.all(10),
                    title: Text(
                      'Future role:  ' + widget.members.data['role'],
                      style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                    ),
                    subtitle: (widget.members.data['currole'] != null)
                        ? Text('Current role:          ' +
                            widget.members.data['currole'])
                        : Text('Unspecified'),
                    trailing: (readiness)
                        ? Icon(Icons.check_circle_outline,
                            size: 30, color: Colors.greenAccent)
                        : Icon(Icons.block, size: 30, color: Colors.redAccent),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 70),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: widget.members.data['skillslist'].length,
                  itemExtent: 110.0,
                  itemBuilder: (context, index) {
                    String skillName = widget.members.data['skillslist'][index];
                    int curSkillValue =
                        widget.members.data['curskillvalues'][index];
                    int reqSkillValue =
                        widget.members.data['reqskillvalues'][index];
                    List<dynamic> curSkillValuesList = [];
                    List<dynamic> reqSkillValuesList = [];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SkilldetailScreen(
                              skillname: skillName,
                            ),
                          ),
                        );
                      },
                      title: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    skillName,
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text('Required Level:  ' +
                                      reqSkillValue.toString()),
                                ],
                              ),
                            ),
                            Text(
                              curSkillValue.toString(),
                              style: TextStyle(
                                color: (widget.members.data['curskillvalues']
                                            [index] >=
                                        widget.members.data['reqskillvalues']
                                            [index])
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
//                                ),
                            Column(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.arrow_upward),
                                  onPressed: () {
                                    setState(
                                      () {
                                        curSkillValuesList = widget
                                            .members.data['curskillvalues'];
                                        reqSkillValuesList = widget
                                            .members.data['reqskillvalues'];
                                        curSkillValuesList[index]++;
                                        readiness = _listB_lessoreq_listA(
                                            curSkillValuesList,
                                            reqSkillValuesList);
                                        readinessUpdate =
                                            readiness ? "yes" : "no";
                                        widget.members.reference.setData({
                                          'curskillvalues': curSkillValuesList,
                                          'readiness': readinessUpdate
                                        }, merge: true);
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_downward),
                                  onPressed: () {
                                    setState(
                                      () {
                                        curSkillValuesList = widget
                                            .members.data['curskillvalues'];
                                        reqSkillValuesList = widget
                                            .members.data['reqskillvalues'];
                                        curSkillValuesList[index]--;
                                        readiness = _listB_lessoreq_listA(
                                            curSkillValuesList,
                                            reqSkillValuesList);
                                        readinessUpdate =
                                            readiness ? "yes" : "no";
                                        widget.members.reference.setData({
                                          'curskillvalues': curSkillValuesList,
                                          'readiness': readinessUpdate
                                        }, merge: true);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
