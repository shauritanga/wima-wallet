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
  late bool _hasCompletedRegistration;

  Future<void> completedRegistration() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final completed = preferences.getBool('completedRegistration');
    print(completed);
    if (completed != null) {
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
    print(_hasCompletedRegistration);
    return Scaffold(
      body: _hasCompletedRegistration
          ? const RegistrationScreen()
          : const ProfileSetupScreen(),
    );
  }
}
