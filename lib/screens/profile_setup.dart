import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wima_wallet/provider/user.dart';
import 'package:wima_wallet/screens/registration.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  String companyCode = "WIMA45E";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;

  String name = "";
  String phone = "";
  String email = "";
  String code = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kamilisha wasifu"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Jaza taarifa zako za msingi kabla ya kuendelea"),
              const SizedBox(height: 16),
              TextFormField(
                enabled: false,
                initialValue: user?.displayName,
                decoration: InputDecoration(
                  hintText: "Jina kamili",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onSaved: (value) => name = value!,
                validator: (value) {
                  return null;
                },
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Namba ya simu",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onSaved: (value) => phone = value!,
                validator: (value) {
                  String pattern = r'^[+255|0]+[6|7][1-9]{8}$';
                  RegExp regExp = RegExp(pattern);
                  if (value!.isEmpty) {
                    return "Jaza namba ya simu";
                  } else if (!regExp.hasMatch(value)) {
                    return "Jaza namba ya simu sahihi";
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                enabled: false,
                initialValue: user?.email,
                decoration: InputDecoration(
                  hintText: "Barua pepe",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onSaved: (value) => email = value!,
                validator: (value) {
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Namba ya taasisi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onSaved: (value) => code = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Tafadali jaza namba ya taasisi uliyopewa";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();

                    if (code.toLowerCase() != companyCode.toLowerCase()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Tafadhali jaza namba uliyopewa na taasisi"),
                        ),
                      );
                      return;
                    }

                    Map<String, dynamic> data = {
                      "name": user?.displayName,
                      "phone": phone,
                      "email": user?.email,
                    };
                    final result = await showDialog(
                      context: context,
                      builder: (context) => FutureProgressDialog(
                        ref.read(userProvider).addUser(data),
                        message: const Text("Loading..."),
                      ),
                    );

                    if (!result) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Tafadhali jaza namba uliyopewa na taasisi"),
                        ),
                      );
                      return;
                    }
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.setBool('completedRegistration', true);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => const RegistrationScreen()));
                  }
                },
                height: 48,
                color: const Color(0xff102d61),
                minWidth: size.width,
                child: const Text(
                  "Tuma",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
