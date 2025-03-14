import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_control/home_screen.dart';
import 'package:smart_control/splashscreen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    )
  ],
);

GoRouter get router => _router;
