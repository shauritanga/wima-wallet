import 'package:flutter/material.dart';

class GetStartedFirstPAge extends StatelessWidget {
  const GetStartedFirstPAge({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.12),
        Image.asset(
          "assets/img/sme.png",
          height: 250,
          width: 250,
        ),
        const SizedBox(height: 24),
        const Text("Sajiri wafanya biashara wadogo wadogo"),
        const SizedBox(height: 24),
      ],
    );
  }
}
