import 'package:flutter/material.dart';
import 'package:wima_wallet/screens/login_screen.dart';

class GetStartedThirdScreen extends StatelessWidget {
  const GetStartedThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.12),
        Image.asset(
          "assets/img/location.png",
          width: 250,
          height: 250,
        ),
        const SizedBox(height: 24),
        const Text("Pata taarifa za maeneo waliopo (Location)"),
        const SizedBox(height: 24),
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
