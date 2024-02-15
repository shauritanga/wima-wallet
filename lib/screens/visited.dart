import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wima_wallet/screens/get_started.dart';

import 'package:wima_wallet/screens/login.dart';

class VisitedScreen extends ConsumerStatefulWidget {
  const VisitedScreen({super.key});

  @override
  ConsumerState<VisitedScreen> createState() => _VisitedScreenState();
}

class _VisitedScreenState extends ConsumerState<VisitedScreen> {
  late bool visited;
  checkIfFistTime() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getBool("visited");
    if (result == null) {
      setState(() {
        visited = false;
      });
      return;
    }
    setState(() {
      visited = true;
    });
  }

  @override
  void initState() {
    super.initState;
    checkIfFistTime();
  }

  @override
  Widget build(BuildContext context) {
    return visited ? const LoginScreen() : const GetStaredScreen();
  }
}
