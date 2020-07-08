//import 'dart:html';

import 'package:flash_chat/api/teammembers_api.dart';
import 'package:flash_chat/model/skills.dart';
import 'package:flash_chat/model/teammembers.dart';
import 'package:flash_chat/notifier/teammember_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/skills_api.dart';
import 'notifier/skill_notifier.dart';

class SkillForm extends StatefulWidget {
  @override
  _SkillFormState createState() => _SkillFormState();
}

class _SkillFormState extends State<SkillForm> {
  List<Skill> _skillslist = [];
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];
  final List<String> staticSkillList = [
    'Java',
    'Jenkins',
    'SpringBoot',
    'ReactNative',
    'Docker',
    'Git',
    'Kubernetes'
  ];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  String _currentSkill;
  int _currentReqSKill = 1;
  int _currentCurSKill = 1;

  _onTeamMemberUpdated(TeamMember teamMember) {
    TeamMemberNotifier teamMemberNotifier =
        Provider.of<TeamMemberNotifier>(context, listen: false);
    teamMemberNotifier.notifyListeners();
  }

  @override
  void initState() {
    SkillsNotifier skillsNotifier =
        Provider.of<SkillsNotifier>(context, listen: false);
    getSkills(skillsNotifier);
    _skillslist = skillsNotifier.skilllist.toList();
    print(_skillslist[0].name.toString());
    // TODO: implement initState
    super.initState();
  }

  bool _listB_lessoreq_listA(List one, List two) {
    var i = -1;
    return one.every((element) {
      i++;
      return two[i] <= element;
    });
  }

  @override
  Widget build(BuildContext context) {
    TeamMemberNotifier teamMemberNotifier =
        Provider.of<TeamMemberNotifier>(context);
    print('teammember notifier value during the build of skill form - ' +
        teamMemberNotifier.currentteammember.firstname.toString());
    TeamMember _currentTeamMember = teamMemberNotifier.currentteammember;
    SkillsNotifier skillsNotifier = Provider.of<SkillsNotifier>(context);

    var _currentSkillsList =
        new List<String>.from(_currentTeamMember.skillslist);
    var _currentCurSkillValues =
        new List<int>.from(_currentTeamMember.curskillvalues);
    var _currentReqSkillValues =
        new List<int>.from(_currentTeamMember.reqskillvalues);

//    List _currentSkillsList = _currentTeamMember.skillslist;
//    List _currentCurSkillValues = _currentTeamMember.curskillvalues;
//    List _currentReqSkillValues = _currentTeamMember.reqskillvalues;

//    return Container(
//      child: Text('Skill form goes here'),
//    );
//    User user = Provider.of<User>(context);
//
//    return StreamBuilder<UserData>(
//      stream: DatabaseService(uid: user.uid).userData,
//      builder: (context, snapshot) {
//        if(snapshot.hasData){
//          UserData userData = snapshot.data;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Add a skill for ${_currentTeamMember.firstname}',
            style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF2A2969),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),

//          TextFormField(
//////            initialValue: _currentTeamMember.firstname,
//////                  decoration: textInputDecoration,
////            validator: (val) =>
////                val.isEmpty ? 'Please enter a skill name' : null,
////            decoration: InputDecoration(
////              hintText: 'Enter the skill name',
////            ),
////            textAlign: TextAlign.center,
////            autofocus: true,
////            onChanged: (val) => setState(() => _currentSkill = val),
////          ),
          //          TODO: Convert the dropdown from hardcoded list to one that fetches from the skills collection
//          TODO: Remove the fixed width sizedbox used for centering text in dropdown
          DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: 'select skill',
            ),
            value: _currentSkill,
//            items: staticSkillList.map((skill) {
            items: _skillslist.map((skill) {
              return DropdownMenuItem(
                value: skill.name,
                child: Text(
                  '${skill.name}',
                ),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentSkill = val),
          ),

          SizedBox(height: 20.0),
          Text('Select Required Level (1-5)'),
          SizedBox(height: 5.0),
          Slider(
            value: _currentReqSKill.toDouble(),
            label: '$_currentReqSKill',
            activeColor: Colors.blue[300 + _currentReqSKill * 100],
            //           inactiveColor: Colors.blue[_currentStrength ?? userData.strength],
            min: 1.0,
            max: 5.0,
            divisions: 4,
            onChanged: (val) => setState(() => _currentReqSKill = val.round()),
          ),
          SizedBox(height: 10),
          Text('Select current Level (1-5)'),
          SizedBox(height: 5),
          Slider(
            value: _currentCurSKill.toDouble(),
            label: '$_currentCurSKill',
            activeColor: Colors.blue[300 + _currentCurSKill * 100],
            min: 1.0,
            max: 5.0,
            divisions: 4,
            onChanged: (val) => setState(() => _currentCurSKill = val.round()),
          ),
          RaisedButton(
              color: Color(0xFF2A2969),
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    _currentSkillsList.add(_currentSkill);
                    _currentCurSkillValues.add(_currentCurSKill);
                    _currentReqSkillValues.add(_currentReqSKill);
                    _currentTeamMember.skillslist = _currentSkillsList;
                    _currentTeamMember.curskillvalues = _currentCurSkillValues;
                    _currentTeamMember.reqskillvalues = _currentReqSkillValues;
                    print(_currentSkillsList.toString());
                    print(_currentReqSkillValues.toString());
                    print(_currentCurSkillValues.toString());

                    bool readiness = _listB_lessoreq_listA(
                        _currentCurSkillValues, _currentReqSkillValues);
                    String readinessUpdate = readiness ? "yes" : "no";
                    _currentTeamMember.readiness = readinessUpdate;
                    updateTeamMember(_currentTeamMember);

                    updateTeamMember(_currentTeamMember);
                    _onTeamMemberUpdated(_currentTeamMember);
                    Navigator.pop(context);
                  });
//                  _currentSkillsList.add(_currentSkill);
//                  _currentCurSkillValues.add(_currentCurSKill);
//                  _currentReqSkillValues.add(_currentReqSKill);
//                  _currentTeamMember.skillslist = _currentSkillsList;
//                  _currentTeamMember.curskillvalues = _currentCurSkillValues;
//                  _currentTeamMember.reqskillvalues = _currentReqSkillValues;
//                  print(_currentSkillsList.toString());
//                  print(_currentReqSkillValues.toString());
//                  print(_currentCurSkillValues.toString());
//                  updateTeamMember(_currentTeamMember);

                }
              }
//                      await DatabaseService(uid: user.uid).updateUserData(
//                        _currentSugars ?? snapshot.data.sugars,
//                        _currentName ?? snapshot.data.name,
//                        _currentStrength ?? snapshot.data.strength
//                      );
//                      Navigator.pop(context);
//                    }},
              ),
        ],
      ),
    );

//                DropdownButtonFormField(
//                  value: _currentSugars ?? userData.sugars,
//                  decoration: textInputDecoration,
//                  items: sugars.map((sugar) {
//                    return DropdownMenuItem(
//                      value: sugar,
//                      child: Text('$sugar sugars'),
//                    );
//                  }).toList(),
//                  onChanged: (val) => setState(() => _currentSugars = val ),
//                ),
//                SizedBox(height: 10.0),

//                RaisedButton(
//                  color: Colors.pink[400],
//                  child: Text(
//                    'Update',
//                    style: TextStyle(color: Colors.white),
//                  ),
//                  onPressed: () async {
//                    if(_formKey.currentState.validate()){
//                      await DatabaseService(uid: user.uid).updateUserData(
//                        _currentSugars ?? snapshot.data.sugars,
//                        _currentName ?? snapshot.data.name,
//                        _currentStrength ?? snapshot.data.strength
//                      );
//                      Navigator.pop(context);
//                    }
//                  }
//                ),
//              ],
//            ),
//          );
//        } else {
//          return Loading();
//        }
//      }
//    );
  }
}
