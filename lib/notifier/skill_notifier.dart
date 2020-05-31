import 'dart:collection';

import 'package:flash_chat/model/skills.dart';
import 'package:flutter/cupertino.dart';

class SkillsNotifier with ChangeNotifier {
  List<Skill> _skillList = [];
  Skill _currentskill;

  UnmodifiableListView<Skill> get skilllist => UnmodifiableListView(_skillList);

  Skill get currentskill => _currentskill;

  set skilllist(List<Skill> skilllist) {
    _skillList = skilllist;
    notifyListeners();
  }

  set currentskill(Skill skill) {
    _currentskill = skill;
    notifyListeners();
  }

  addSkill(Skill skill) {
    _skillList.insert(0, skill);
    notifyListeners();
  }

  deleteSkill(Skill skill) {
    _skillList.removeWhere((_skill) => _skill.id == skill.id);
    notifyListeners();
  }
}
