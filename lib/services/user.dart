import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b6_v2/models/user.dart';

class UserServices {
  ///Create User
  Future createUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }

  ///Get User By ID
  Stream<UserModel> getUserByID(String userID) {
    return FirebaseFirestore.instance
        .collection('userCollection')
        .doc(userID)
        .snapshots()
        .map((userModel) => UserModel.fromJson(userModel.data()!));
  }

}
