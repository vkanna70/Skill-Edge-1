class Skill {
  String id;
  String name;
  String description;
  String category;
  List resources;
  List badges;

  Skill();

  Skill.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    description = data['description'];
    category = data['category'];
    resources = data['resources'];
    badges = data['badges'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'resources': resources,
      'badges': badges,
    };
  }
}
