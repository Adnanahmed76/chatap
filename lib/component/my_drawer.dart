import 'package:chatap/services/auth/auth_services.dart';
import 'package:chatap/pages/setting_sreen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final _auth = AuthServices();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // separates top and bottom
        children: [
          // TOP: Logo + Home + Setting
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),
              // Home
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
              // Setting
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("S E T T I N G"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                    //navigate to settings page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingSreen()));
                  },
                ),
              ),
            ],
          ),

          // BOTTOM: Logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 20.0),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap: () {
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
