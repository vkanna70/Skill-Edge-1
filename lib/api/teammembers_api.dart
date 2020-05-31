import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/model/teammembers.dart';
import 'package:flash_chat/notifier/teammember_notifier.dart';

getTeamMembers(TeamMemberNotifier teamMemberNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('teammembers')
      .orderBy("firstname", descending: false)
      .getDocuments();

  List<TeamMember> _teammemberList = [];

  snapshot.documents.forEach((document) {
    TeamMember teamMember = TeamMember.fromMap(document.data);
    _teammemberList.add(teamMember);
  });

  teamMemberNotifier.teammemberlist = _teammemberList;
}

updateTeamMember(TeamMember teamMember) async {
  CollectionReference teammemberRef =
      Firestore.instance.collection('teammembers');
  await teammemberRef
      .document(teamMember.id)
      .setData(teamMember.toMap(), merge: true);
//  teamMemberUpdated(teamMember);
  print('updated teammember with id: ${teamMember.id}');
}
//  } else {
//    food.createdAt = Timestamp.now();
//
//    DocumentReference documentRef = await foodRef.add(food.toMap());
//
//    food.id = documentRef.documentID;
//
//    print('uploaded food successfully: ${food.toString()}');
//
//    await documentRef.setData(food.toMap(), merge: true);
//
//    foodUploaded(food);
//  }
//}

//uploadFoodAndImage(Food food, bool isUpdating, File localFile, Function foodUploaded) async {
//  if (localFile != null) {
//    print("uploading image");
//
//    var fileExtension = path.extension(localFile.path);
//    print(fileExtension);
//
//    var uuid = Uuid().v4();
//
//    final StorageReference firebaseStorageRef =
//        FirebaseStorage.instance.ref().child('foods/images/$uuid$fileExtension');
//
//    await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
//      print(onError);
//      return false;
//    });
//
//    String url = await firebaseStorageRef.getDownloadURL();
//    print("download url: $url");
//    _uploadFood(food, isUpdating, foodUploaded, imageUrl: url);
//  } else {
//    print('...skipping image upload');
//    _uploadFood(food, isUpdating, foodUploaded);
//  }
//}
//
//_uploadFood(Food food, bool isUpdating, Function foodUploaded, {String imageUrl}) async {
//  CollectionReference foodRef = Firestore.instance.collection('Foods');
//
//  if (imageUrl != null) {
//    food.image = imageUrl;
//  }
//
//  if (isUpdating) {
//    food.updatedAt = Timestamp.now();
//
//    await foodRef.document(food.id).updateData(food.toMap());
//
//    foodUploaded(food);
//    print('updated food with id: ${food.id}');
//  } else {
//    food.createdAt = Timestamp.now();
//
//    DocumentReference documentRef = await foodRef.add(food.toMap());
//
//    food.id = documentRef.documentID;
//
//    print('uploaded food successfully: ${food.toString()}');
//
//    await documentRef.setData(food.toMap(), merge: true);
//
//    foodUploaded(food);
//  }
//}
//
//deleteFood(Food food, Function foodDeleted) async {
//  if (food.image != null) {
//    StorageReference storageReference =
//        await FirebaseStorage.instance.getReferenceFromUrl(food.image);
//
//    print(storageReference.path);
//
//    await storageReference.delete();
//
//    print('image deleted');
//  }
//
//  await Firestore.instance.collection('Foods').document(food.id).delete();
//  foodDeleted(food);
//}
