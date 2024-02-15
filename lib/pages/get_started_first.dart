import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wima_wallet/screens/login.dart';
import 'package:wima_wallet/widgets/custom_cliper.dart';

class GetStartedFirstPAge extends StatelessWidget {
  final int currentIndex;
  final String imageUrl;
  final String message;
  const GetStartedFirstPAge({
    super.key,
    required this.currentIndex,
    required this.imageUrl,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: 6778,
          width: double.infinity,
        ),
        ClipPath(
          clipper: CustomShape(left: 0.7),
          child: Container(
            height: size.height * 0.7,
            color: Colors.grey.shade300,
          ),
        ),
        ClipPath(
          clipper: CustomShape(left: 0.5),
          child: Container(
            padding: const EdgeInsets.all(70),
            height: size.height * 0.7,
            width: double.infinity,
            color: Colors.grey.shade400,
            child: Image.asset(imageUrl),
          ),
        ),
        Positioned(
          top: size.height * 0.75,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: Text(message),
          ),
        ),
        Positioned(
          top: size.height * 0.85,
          left: 0,
          right: 0,
          child: currentIndex == 2
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MaterialButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setBool("visited", true);

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    height: 48,
                    color: const Color(0xff102d61),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "Anza",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: currentIndex == 0
                            ? const Color(0xff102d61)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: currentIndex == 1
                            ? const Color(0xff102d61)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: currentIndex == 2
                            ? const Color(0xff102d61)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
