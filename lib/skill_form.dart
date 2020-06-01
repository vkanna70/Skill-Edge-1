import 'package:flash_chat/api/teammembers_api.dart';
import 'package:flash_chat/model/teammembers.dart';
import 'package:flash_chat/notifier/teammember_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SkillForm extends StatefulWidget {
  @override
  _SkillFormState createState() => _SkillFormState();
}

class _SkillFormState extends State<SkillForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

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
  Widget build(BuildContext context) {
    TeamMemberNotifier teamMemberNotifier =
        Provider.of<TeamMemberNotifier>(context);
    print('teammember notifier value during the build of skill form - ' +
        teamMemberNotifier.currentteammember.firstname.toString());
    TeamMember _currentTeamMember = teamMemberNotifier.currentteammember;

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
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
//            initialValue: _currentTeamMember.firstname,
//                  decoration: textInputDecoration,
            validator: (val) =>
                val.isEmpty ? 'Please enter a skill name' : null,
            decoration: InputDecoration(
              hintText: 'Enter the skill name',
            ),
            textAlign: TextAlign.center,
            autofocus: true,
            onChanged: (val) => setState(() => _currentSkill = val),
          ),
          //TODO: Convert the plain text field into a dropdown with values from the skills collection
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
              color: Colors.pink[400],
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
