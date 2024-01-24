import 'package:ceal_placement_notifier/controllers/authentication_controller.dart';
import 'package:ceal_placement_notifier/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key, required this.child});

  final Widget child;

  void logout(BuildContext context) {
    //show alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you Sure?"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You are about to logout'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Continue'),
              onPressed: () async {
                await auth.signOut().then((value) {
                  context.pop();
                }).catchError((err) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: err));
                  context.pop();
                });
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/admin-dashboard')) {
      return 0;
    }
    if (location.startsWith('/admin-add-placement')) {
      return 1;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).pushReplacement(AppRouteConstants.adminDashboard);
      case 1:
        GoRouter.of(context)
            .pushReplacement(AppRouteConstants.adminAddPlacement);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ceal Placement Notifier Admin Panel"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Add Placement',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }
}
