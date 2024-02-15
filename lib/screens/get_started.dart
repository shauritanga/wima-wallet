import 'package:flutter/material.dart';
import 'package:wima_wallet/pages/get_started_first.dart';

class GetStaredScreen extends StatefulWidget {
  const GetStaredScreen({super.key});

  @override
  State<GetStaredScreen> createState() => _GetStaredScreenState();
}

class _GetStaredScreenState extends State<GetStaredScreen> {
  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: 1.0);
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        controller: _controller,
        children: [
          GetStartedFirstPAge(
            currentIndex: currentPage,
            imageUrl: "assets/img/sme.png",
            message: "Sajiri wafanyabiashara wadogo",
          ),
          GetStartedFirstPAge(
            currentIndex: currentPage,
            imageUrl: "assets/img/bank.png",
            message: "Pata taarifa ya wanaotumia huduma za kibenki",
          ),
          GetStartedFirstPAge(
            currentIndex: currentPage,
            imageUrl: "assets/img/location.png",
            message: "Jua maeneo watokako",
          ),
        ],
      ),
    );
  }
}
