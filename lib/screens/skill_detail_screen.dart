import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/api/skills_api.dart';
import 'package:flash_chat/model/skills.dart';
import 'package:flash_chat/notifier/skill_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SkilldetailScreen extends StatefulWidget {
  final String skillname;
  SkilldetailScreen({this.skillname});
  @override
  _SkilldetailScreenState createState() => _SkilldetailScreenState();
}

class _SkilldetailScreenState extends State<SkilldetailScreen> {
  Skill _currentskill;

  @override
  void initState() {
    SkillsNotifier skillsNotifier =
        Provider.of<SkillsNotifier>(context, listen: false);
    getSkills(skillsNotifier);
    _currentskill = skillsNotifier.skilllist.firstWhere(
        (p) => p.name.toLowerCase().contains(widget.skillname.toLowerCase()));
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    SkillsNotifier skillsNotifier = Provider.of<SkillsNotifier>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
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
        title: Text(widget.skillname),
//        backgroundColor: Colors.lightBlueAccent,
      ),
      body: _currentskill != null
          ? SingleChildScrollView(
              child: Container(
//TODO: Convert to Listview so that it is scrollable
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            _currentskill.name.toString(),
                            style: TextStyle(
                                color: Color(0xFF2A2969),
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Category: ' +
                                '${_currentskill.category.toString()}',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Description: \n\n' +
                            '${_currentskill.description.toString()} \n',
                        style: TextStyle(
                          color: Color(0xFF2A2969),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Related Badges',
                      style: TextStyle(
                          color: Color(0xFF2A2969),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              _currentskill.badges[index].toString(),
                            ),
                          );
                        },
                        itemCount: _currentskill.badges.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.black,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Top Learning Resources',
                      style: TextStyle(
                          color: Color(0xFF2A2969),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              _currentskill.resources[index].toString(),
                            ),
                          );
                        },
                        itemCount: _currentskill.resources.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.black,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            )
          : Text('Skill not present in the database'),
//      body: SafeArea(
//        child: Column(
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Container(
//                child: Card(
//                  elevation: 5,
//                  child: ListTile(
//                    dense: false,
//                    //contentPadding: EdgeInsets.all(10),
//                    title: Text(
//                      'Future role:  ' + widget.members.data['role'],
//                      style: TextStyle(fontSize: 18, color: Colors.lightBlue),
//                    ),
//                    subtitle: (widget.members.data['currole'] != null)
//                        ? Text('Current role:          ' +
//                            widget.members.data['currole'])
//                        : Text('Unspecified'),
//                    trailing: (readiness)
//                        ? Icon(Icons.check_circle_outline,
//                            size: 30, color: Colors.greenAccent)
//                        : Icon(Icons.block, size: 30, color: Colors.redAccent),
//                  ),
//                ),
//              ),
//            ),
//            SizedBox(height: 5),
//            Expanded(
//              child: Container(
//                margin: EdgeInsets.only(bottom: 70),
//                padding: EdgeInsets.symmetric(horizontal: 10),
//                child: ListView.builder(
//                  itemCount: widget.members.data['skillslist'].length,
//                  itemExtent: 110.0,
//                  itemBuilder: (context, index) {
//                    String skillName = widget.members.data['skillslist'][index];
//                    int curSkillValue =
//                        widget.members.data['curskillvalues'][index];
//                    int reqSkillValue =
//                        widget.members.data['reqskillvalues'][index];
//                    List<dynamic> curSkillValuesList = [];
//                    List<dynamic> reqSkillValuesList = [];
//                    return ListTile(
//                      title: Container(
//                        padding: EdgeInsets.all(5.0),
//                        child: Row(
//                          children: <Widget>[
//                            Expanded(
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  SizedBox(
//                                    height: 10,
//                                  ),
//                                  Text(
//                                    skillName,
//                                    style: TextStyle(
//                                      color: Colors.lightBlue,
//                                      fontSize: 18,
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    height: 10,
//                                  ),
//                                  Text('Required Level:  ' +
//                                      reqSkillValue.toString()),
//                                ],
//                              ),
//                            ),
//                            Text(
//                              curSkillValue.toString(),
//                              style: TextStyle(
//                                color: (widget.members.data['curskillvalues']
//                                            [index] >=
//                                        widget.members.data['reqskillvalues']
//                                            [index])
//                                    ? Colors.green
//                                    : Colors.red,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 18,
//                              ),
//                            ),
////                                ),
//                            Column(
//                              children: <Widget>[
//                                IconButton(
//                                  icon: Icon(Icons.arrow_upward),
//                                  onPressed: () {
//                                    setState(
//                                      () {
//                                        curSkillValuesList = widget
//                                            .members.data['curskillvalues'];
//                                        reqSkillValuesList = widget
//                                            .members.data['reqskillvalues'];
//                                        curSkillValuesList[index]++;
//                                        readiness = _listB_lessoreq_listA(
//                                            curSkillValuesList,
//                                            reqSkillValuesList);
//                                        readinessUpdate =
//                                            readiness ? "yes" : "no";
//                                        widget.members.reference.setData({
//                                          'curskillvalues': curSkillValuesList,
//                                          'readiness': readinessUpdate
//                                        }, merge: true);
//                                      },
//                                    );
//                                  },
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.arrow_downward),
//                                  onPressed: () {
//                                    setState(
//                                      () {
//                                        curSkillValuesList = widget
//                                            .members.data['curskillvalues'];
//                                        reqSkillValuesList = widget
//                                            .members.data['reqskillvalues'];
//                                        curSkillValuesList[index]--;
//                                        readiness = _listB_lessoreq_listA(
//                                            curSkillValuesList,
//                                            reqSkillValuesList);
//                                        readinessUpdate =
//                                            readiness ? "yes" : "no";
//                                        widget.members.reference.setData({
//                                          'curskillvalues': curSkillValuesList,
//                                          'readiness': readinessUpdate
//                                        }, merge: true);
//                                      },
//                                    );
//                                  },
//                                ),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                    );
//                  },
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
    );
  }
}
