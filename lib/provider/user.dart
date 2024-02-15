import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = Provider<UserModel>((ref) => UserModel());

class UserModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addUser(Map<String, dynamic> data) async {
    DocumentReference documentReference =
        await _firestore.collection("users").add(data);
    if (documentReference.id.isNotEmpty) {
      return true;
    }
    return false;
  }
}
