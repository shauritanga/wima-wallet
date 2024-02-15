import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wima_wallet/provider/auth.dart';
import 'package:wima_wallet/screens/home_screen.dart';
import 'package:wima_wallet/screens/visited.dart';

final authStateProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(authService).authStateChanges();
});

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (state) {
        switch (state) {
          case AuthState.authenticated:
            return const HomeScreen();
          case AuthState.unauthenticated:
            return const VisitedScreen();
          case AuthState.loading:
            return const CircularProgressIndicator();
        }
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) {
        return const Text("Error occured.Please try again");
      },
    );
  }
}
