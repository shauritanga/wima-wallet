import 'package:flutter/material.dart';
import 'package:wima_wallet/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
                (route) => false);
          },
          height: 56,
          minWidth: size.width - 48,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Text(
            "Login with gmail",
            style: TextStyle(
              fontSize: 19,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
