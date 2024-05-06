// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:wima_wallet/models/dashboard.dart';

// final dataSummaryStreamProvider = StreamProvider.autoDispose<Dashboard>((ref) {
//   final firestore = FirebaseFirestore.instance;
//   final doc = firestore.collection("data").snapshots();
//   return doc.asyncMap((snapshot) {
//     final women = snapshot.docs.where((doc) {
//       return doc.data().containsValue("Mke");
//     }).toList();
//     final total = snapshot.docs.length;
//     final group = snapshot.docs.where((doc) {
//       return doc.data()['has_a_group'] == "Ndiyo";
//     }).toList();
//     final account = snapshot.docs.where((doc) {
//       return doc.data()['have_account'] == "Hapana" &&
//           doc.data()['like_to_have_bank_account'] == "Ndiyo";
//     }).toList();

//     final loan = snapshot.docs.where((doc) {
//       return doc.data()['like_loan'] == "Ndiyo";
//     }).toList();

//     Dashboard dashboard = Dashboard(
//       women: women.length,
//       total: total,
//       group: group.length,
//       account: account.length,
//       loan: loan.length,
//       y
//     );
//     return dashboard;
//   });
// });
