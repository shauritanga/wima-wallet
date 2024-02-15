import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wima_wallet/provider/auth.dart';
import 'package:wima_wallet/screens/home_screen.dart';
import 'package:wima_wallet/screens/login.dart';
import 'package:wima_wallet/screens/registered.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({
    super.key,
    required this.statusBarHeight,
    required this.bottomBarHeight,
  });

  final double statusBarHeight;
  final double bottomBarHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: statusBarHeight),
          ListTile(
            leading: const Icon(EvaIcons.homeOutline),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomeScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(EvaIcons.personDoneOutline),
            title: const Text("Waliosajiriwa"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const RegisteredScreen(),
                ),
              );
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: const Icon(EvaIcons.powerOutline),
                title: const Text("Logout"),
                onTap: () async {
                  await ref.read(authService).signOut();
                  //ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: bottomBarHeight),
        ],
      ),
    );
  }
}
