import 'package:ceal_placement_notifier/main.dart';
import 'package:ceal_placement_notifier/screens/admin_screens/admin_add_placement_screen.dart';
import 'package:ceal_placement_notifier/screens/admin_screens/admin_dashboard_screen.dart';
import 'package:ceal_placement_notifier/screens/admin_screens/admin_home_screen.dart';
import 'package:ceal_placement_notifier/screens/student_screens/student_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

// GoRouter configuration
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const InitialiserScreen(),
      routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return AdminHomeScreen(
                child: child,
              );
            },
            routes: [
              GoRoute(path: "admin-dashboard",
              builder: (context,state) {
                return const AdminDashboardScreen();
              }),
              GoRoute(path: "admin-add-placement",
              builder: (context,state) {
                return const AdminAddPlacementScreen();
              }),
            ]),
        GoRoute(
          path: 'student-home',
          builder: (context, state) => const StudentHomeScreen(),
        ),
      ],
    ),
  ],
);

class AppRouteConstants {
  static const String adminHome = "/admin-home";
  static const String studentHome = "/student-home";
  static const String adminDashboard = "/admin-dashboard";
  static const String adminAddPlacement = "/admin-add-placement";
}
