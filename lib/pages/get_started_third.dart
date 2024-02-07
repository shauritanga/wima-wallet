import 'package:flutter/material.dart';
import 'package:wima_wallet/screens/login_screen.dart';

class GetStartedThirdScreen extends StatelessWidget {
  const GetStartedThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Pata taarifa za maeneo waliopo (Location)"),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
            );
          },
          child: const Text("Get Started"),
        ),
      ],
    );
  }
}
