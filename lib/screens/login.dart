import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wima_wallet/provider/auth.dart';
import 'package:wima_wallet/screens/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.18),
          Image.asset("assets/img/logo_sme.png", width: 150, height: 150),
          SizedBox(height: size.height * 0.18, width: double.infinity),
          MaterialButton(
            onPressed: () async {
              final result = await ref.read(authService).signInWithGoogle();
              if (!result) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Kuingia kumeshindwa")));
              } else{
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                  (route) => false);
              }
            },
            height: 56,
            minWidth: size.width - 48,
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Text(
              "Ingia na akaunti ya google",
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
