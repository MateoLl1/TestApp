

import 'package:go_router/go_router.dart';
import 'package:test_app/presentation/screens/firma/signature_screen.dart';
import 'package:test_app/presentation/screens/home/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/signature',
      builder: (context, state) => const SignatureScreen(),
    ),
  ]
);