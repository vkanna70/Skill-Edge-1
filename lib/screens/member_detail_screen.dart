import 'package:flash_chat/api/teammembers_api.dart';
import 'package:flash_chat/model/teammembers.dart';
import 'package:flash_chat/notifier/skill_notifier.dart';
import 'package:flash_chat/notifier/teammember_notifier.dart';
import 'package:flash_chat/screens/skill_detail_screen.dart';
import 'package:flash_chat/skill_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamMemberDetail extends StatefulWidget {
  @override
  _TeamMemberDetailState createState() => _TeamMemberDetailState();
}

class _TeamMemberDetailState extends State<TeamMemberDetail> {
  List _curSkillsValues = [];
  TeamMember _currentTeamMember;
  @override
  void initState() {
//    TeamMemberNotifier teamMemberNotifier =
//        Provider.of<TeamMemberNotifier>(context, listen: false);
//    getTeamMembers(teamMemberNotifier);
//    TeamMemberNotifier teamMemberNotifier =
//        Provider.of<TeamMemberNotifier>(context);
//    if (teamMemberNotifier.currentteammember != null) {
//      _currentTeamMember = teamMemberNotifier.currentteammember;
//      print('team member notifier in init state is not null');
//    } else {
//      _currentTeamMember = TeamMember();
//    }
//    _skillsList.addAll(_currentTeamMember.skillslist);
//    _curSkillsValues.addAll(_currentTeamMember.curskillvalues);
//    _reqSkillsValues.addAll(_currentTeamMember.reqskillvalues);
    super.initState();
  }

  bool _listB_lessoreq_listA(List one, List two) {
    var i = -1;
    return one.every((element) {
      i++;
      return two[i] <= element;
    });
  }

  _onTeamMemberUpdated(TeamMember teamMember) {
    TeamMemberNotifier teamMemberNotifier =
        Provider.of<TeamMemberNotifier>(context, listen: false);
    teamMemberNotifier.addTeamMember(teamMember);
  }

  _incrSkills(List<int> curskillvalues) {
    setState(() {
      _curSkillsValues = curskillvalues;
    });
  }

  _saveTeamMember() {
    print('saveTeamMember Called');
    _currentTeamMember.curskillvalues = _curSkillsValues;
    updateTeamMember(_currentTeamMember);
    _onTeamMemberUpdated(_currentTeamMember);
  }

  @override
  Widget build(BuildContext context) {
    TeamMemberNotifier teamMemberNotifier =
        Provider.of<TeamMemberNotifier>(context);
    print('teammember notifier value in build - ' +
        teamMemberNotifier.currentteammember.firstname.toString());

    void _showSkillForm() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              //TODO: Make border radius work - by working with canvas colour
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(20),
//                topRight: Radius.circular(20),
//              )),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SkillForm(),
            );
          });
    }

//    print(teamMemberNotifier.currentteammember.curskillvalues.toString());
//
    _currentTeamMember = teamMemberNotifier.currentteammember;
    _currentTeamMember.curskillvalues =
        teamMemberNotifier.currentteammember.curskillvalues;
    _currentTeamMember.reqskillvalues =
        teamMemberNotifier.currentteammember.reqskillvalues;

    print(_currentTeamMember.curskillvalues.toString());

//    _onFoodDeleted(Food food) {
//      Navigator.pop(context);
//      foodNotifier.deleteFood(food);
//    }

    return Scaffold(
      appBar: AppBar(
        title: Text(teamMemberNotifier.currentteammember.firstname),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'Future role: ${teamMemberNotifier.currentteammember.futrole}',
                            style: TextStyle(
                              fontSize: 22,
//                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15),
                          Text(
                              'Current role: ' +
                                  teamMemberNotifier.currentteammember.currole
                                      .toString(),
                              textAlign: TextAlign.center),
                          SizedBox(height: 10),
                          Text(
                              'Aspirational role: ' +
                                  teamMemberNotifier.currentteammember.asprole
                                      .toString(),
                              textAlign: TextAlign.center),
                          SizedBox(height: 20),
                        ]),
                  ),
                ),
                SizedBox(height: 5),
                GridView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  itemCount:
                      teamMemberNotifier.currentteammember.skillslist.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      color: (teamMemberNotifier
                                  .currentteammember.curskillvalues[index] <
                              teamMemberNotifier
                                  .currentteammember.reqskillvalues[index])
                          ? Colors.redAccent
                          : Colors.greenAccent,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5),
                          Text(
                            teamMemberNotifier
                                .currentteammember.skillslist[index]
                                .toString()
                                .substring(
                                    0,
                                    teamMemberNotifier.currentteammember
                                                .skillslist[index].length <
                                            12
                                        ? teamMemberNotifier.currentteammember
                                            .skillslist[index].length
                                        : 12),
                            textAlign: TextAlign.center,
                            style: TextStyle(
//                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Reqd: ' +
                              teamMemberNotifier
                                  .currentteammember.reqskillvalues[index]
                                  .toString()),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 20),
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                      teamMemberNotifier.currentteammember
                                          .curskillvalues[index]
                                          .toString(),
                                      style: TextStyle(fontSize: 90),
                                      textAlign: TextAlign.center),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Consumer<SkillsNotifier>(
                                        builder: (context, notifier, child) {
                                          return SkilldetailScreen(
                                            skillname: teamMemberNotifier
                                                .currentteammember
                                                .skillslist[index]
                                                .toString(),
                                          );
                                        },
//                                        child: SkilldetailScreen(
//                                          skillname: teamMemberNotifier
//                                              .currentteammember.skillslist[index]
//                                              .toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
//                            ],
//                          ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.add_circle,
                                        size: 40,
                                        color: Colors.blueGrey,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            print(
                                                'teammember Notifier value of id -  ' +
                                                    teamMemberNotifier
                                                        .currentteammember.id
                                                        .toString());
                                            _currentTeamMember =
                                                teamMemberNotifier
                                                    .currentteammember;
                                            _curSkillsValues =
                                                teamMemberNotifier
                                                    .currentteammember
                                                    .curskillvalues;
                                            if (_curSkillsValues[index] < 5)
                                              _curSkillsValues[index]++;
                                            _currentTeamMember.curskillvalues =
                                                _curSkillsValues;
                                            print(
                                                'going to update with value - ' +
                                                    _currentTeamMember
                                                        .curskillvalues[index]
                                                        .toString());
                                            print('id is ' +
                                                _currentTeamMember.id
                                                    .toString());

                                            bool readiness =
                                                _listB_lessoreq_listA(
                                                    _currentTeamMember
                                                        .curskillvalues,
                                                    _currentTeamMember
                                                        .reqskillvalues);
                                            String readinessUpdate =
                                                readiness ? "yes" : "no";
                                            _currentTeamMember.readiness =
                                                readinessUpdate;
                                            updateTeamMember(
                                                _currentTeamMember);
                                          },
                                        );
                                      },
                                    ),
//                                    SizedBox(
//                                      height: 5,
//                                    ),
                                    IconButton(
                                        icon: Icon(Icons.remove_circle,
                                            size: 40, color: Colors.blueGrey),
                                        onPressed: () {
                                          setState(
                                            () {
                                              print(
                                                  'teammember Notifier value of id -  ' +
                                                      teamMemberNotifier
                                                          .currentteammember.id
                                                          .toString());
                                              _currentTeamMember =
                                                  teamMemberNotifier
                                                      .currentteammember;
                                              _curSkillsValues =
                                                  teamMemberNotifier
                                                      .currentteammember
                                                      .curskillvalues;
                                              if (_curSkillsValues[index] > 0)
                                                _curSkillsValues[index]--;
                                              _currentTeamMember
                                                      .curskillvalues =
                                                  _curSkillsValues;
                                              print(
                                                  'going to update with value - ' +
                                                      _currentTeamMember
                                                          .curskillvalues[index]
                                                          .toString());
                                              print('id is ' +
                                                  _currentTeamMember.id
                                                      .toString());

                                              bool readiness =
                                                  _listB_lessoreq_listA(
                                                      _currentTeamMember
                                                          .curskillvalues,
                                                      _currentTeamMember
                                                          .reqskillvalues);
                                              String readinessUpdate =
                                                  readiness ? "yes" : "no";
                                              _currentTeamMember.readiness =
                                                  readinessUpdate;
                                              updateTeamMember(
                                                  _currentTeamMember);
                                            },
                                          );
                                        }),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
//          ),
//        ),
//      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () {
              _showSkillForm();
//              Navigator.of(context).push(
//                MaterialPageRoute(builder: (BuildContext context) {
//                  return SkillForm(
//                    isUpdating: true,
//                  );
//                }),
//              );
            },
            child: Icon(Icons.add),
            foregroundColor: Colors.white,
          ),
//          SizedBox(height: 20),
////          FloatingActionButton(
////            heroTag: 'button2',
////            onPressed: () => deleteFood(foodNotifier.currentFood, _onFoodDeleted),
////            child: Icon(Icons.delete),
////            backgroundColor: Colors.red,
////            foregroundColor: Colors.white,
////          ),
        ],
      ),
    );
  }
}
