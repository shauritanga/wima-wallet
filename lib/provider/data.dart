import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataProvider = Provider<Data>((ref) => Data());

class Data {
  final CollectionReference _dataCollection =
      FirebaseFirestore.instance.collection("data");

  Future<bool> addData(Map<String, dynamic> data) async {
    final response = await _dataCollection.add(data);
    if (response.id.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<QuerySnapshot> getData() async {
    return await _dataCollection.get();
  }
}
