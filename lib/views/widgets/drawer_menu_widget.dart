import 'package:e_commerce_app/services/firebase_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              accountName: Text(
                FirebaseAuth.instance.currentUser!.displayName ?? "Rashid",
                style: const TextStyle(fontSize: 18),
              ),
              accountEmail:
                  Text(FirebaseAuth.instance.currentUser!.email ?? ""),
              currentAccountPictureSize: const Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser!.photoURL ?? ""),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(' My Orders '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text(' Go Premium '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text(' Account Detailes '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'LogOut',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () async {
              await FirebaseAuthMethods().signOut();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: ((context) => const Login()),
              //   ),
              // );
            },
          ),
        ],
      ),
    ); //Drawer
  }
}
