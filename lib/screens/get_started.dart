import 'package:flutter/material.dart';
import 'package:wima_wallet/pages/get_started_first.dart';
import 'package:wima_wallet/pages/get_started_second.dart';
import 'package:wima_wallet/pages/get_started_third.dart';

class GetStaredScreen extends StatefulWidget {
  const GetStaredScreen({super.key});

  @override
  State<GetStaredScreen> createState() => _GetStaredScreenState();
}

class _GetStaredScreenState extends State<GetStaredScreen> {
  final PageController _controller =
      PageController(initialPage: 0, viewportFraction: 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: _controller,
        children: const [
          GetStartedFirstPAge(),
          GetStartedScondScreen(),
          GetStartedThirdScreen(),
        ],
      ),
    );
  }
}
