import 'package:admonhilton/pages/login.dart';
import 'package:admonhilton/pages/results.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/results',
      builder: (context, state) => ResultsScreen(),
    ),
  ]);
});
