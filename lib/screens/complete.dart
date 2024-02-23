import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wima_wallet/screens/profile_setup.dart';
import 'package:wima_wallet/screens/registration.dart';

class CompletedRegistration extends StatefulWidget {
  const CompletedRegistration({super.key});

  @override
  State<CompletedRegistration> createState() => _CompletedRegistrationState();
}

class _CompletedRegistrationState extends State<CompletedRegistration> {
  bool? _hasCompletedRegistration;

  Future completedRegistration() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final response = await firestore
        .collection("users")
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get();

    if (response.docs.isNotEmpty) {
      setState(() {
        _hasCompletedRegistration = true;
      });
    } else {
      setState(() {
        _hasCompletedRegistration = false;
      });
    }
  }

  @override
  void initState() {
    completedRegistration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _hasCompletedRegistration == null
          ? const Center(child: CircularProgressIndicator())
          : (_hasCompletedRegistration == true)
              ? const RegistrationScreen()
              : const ProfileSetupScreen(),
    );
  }
}
