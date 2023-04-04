// import 'package:flutter/material.dart';

// class InfoDrawer extends StatelessWidget {
//   const InfoDrawer({super.key});

// ignore_for_file: prefer_const_constructors

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: <Widget>[
//           AppBar(
//             title: const Text('Hello Friend!'),
//             automaticallyImplyLeading: false,
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.shop),
//             title: const Text('Shop'),
//             onTap: () {},
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.payment),
//             title: const Text('Order'),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.payment),
//             title: const Text('Manage Products'),
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_manager.dart';

class InfoDrawer extends StatelessWidget {
  const InfoDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..pushReplacementNamed('/');
              context.read<AuthManager>().logout();
            },
          ),
        ],
      ),
    );
  }
}
