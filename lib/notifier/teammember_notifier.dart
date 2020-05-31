import 'dart:collection';

import 'package:flash_chat/model/teammembers.dart';
import 'package:flutter/cupertino.dart';

class TeamMemberNotifier with ChangeNotifier {
  List<TeamMember> _teammemberList = [];
  TeamMember _currentteammember;

  UnmodifiableListView<TeamMember> get teammemberlist =>
      UnmodifiableListView(_teammemberList);

  TeamMember get currentteammember => _currentteammember;

  set teammemberlist(List<TeamMember> teammemberlist) {
    _teammemberList = teammemberlist;
    notifyListeners();
  }

  set currentteammember(TeamMember teamMember) {
    _currentteammember = teamMember;
    notifyListeners();
  }

  addTeamMember(TeamMember teamMember) {
    _teammemberList.insert(0, teamMember);
    notifyListeners();
  }

  deleteTeamMember(TeamMember teamMember) {
    _teammemberList
        .removeWhere((_teammember) => _teammember.id == teamMember.id);
    notifyListeners();
  }
}
