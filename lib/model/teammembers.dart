class TeamMember {
  String id;
  String firstname;
  String lastname;
  String currole;
  String futrole;
  String asprole;
  String tower;
  List skillslist = [];
  List curskillvalues = [];
  List reqskillvalues = [];
  String readiness;

  TeamMember();

  TeamMember.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    firstname = data['firstname'];
    lastname = data['lastname'];
    currole = data['currole'];
    futrole = data['futrole'];
    asprole = data['asprole'];
    tower = data['tower'];
    skillslist = data['skillslist'];
    reqskillvalues = data['reqskillvalues'];
    curskillvalues = data['curskillvalues'];
    readiness = data['readiness'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'currole': currole,
      'futrole': futrole,
      'asprole': asprole,
      'tower': tower,
      'skillslist': skillslist,
      'curskillvalues': curskillvalues,
      'reqskillvalues': reqskillvalues,
      'readiness': readiness
    };
  }
}
