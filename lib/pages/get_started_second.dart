import 'package:flutter/material.dart';

class GetStartedScondScreen extends StatelessWidget {
  const GetStartedScondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.12),
        Image.asset(
          "assets/img/bank.png",
          width: 250,
          height: 250,
        ),
        const SizedBox(height: 24),
        const Text("Pata taarifa za wafanya biashara wenye akaunti za bank"),
        const SizedBox(height: 24),
      ],
    );
  }
}
