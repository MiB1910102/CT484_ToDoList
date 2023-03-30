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
          UserAccountsDrawerHeader(
            accountName: const Text('John Doe'),
            accountEmail: const Text('johndoe@example.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-kqiEsLqfs7qAuSWrS0OzkwHUnkfEVPpQBQ&usqp=CAU'),
            ),
            // ignore: prefer_const_literals_to_create_immutables
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Order'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Manage Products'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
