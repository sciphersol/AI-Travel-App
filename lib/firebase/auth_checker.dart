import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/home_screen.dart';
import 'package:travel_app/login_screen/login_or_signup.dart';
import 'package:travel_app/riverpord/riverpord.dart';
import 'package:travel_app/onboarding_screens/onboarding_pages.dart';
import '../onboarding_screens/splash_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (user) {
        if (user != null) {
          if (ref.watch(isAuthenticatedProvider) == true) {
            return  HomeScreen();
          } else {
            return  const UnauthorizedScreen();
          }
        } else {
          return  LoginOrSignupScreen();
        }
      },
      loading: () =>  OnboardingPages(),
      error: (e, error) =>  LoginOrSignupScreen(),
    );
  }
}
