import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screans/home_screan.dart';

import '../screans/categories_screan.dart';

class Drawernavigation extends StatefulWidget {
  const Drawernavigation({super.key});

  @override
  State<Drawernavigation> createState() => _DrawernavigationState();
}

class _DrawernavigationState extends State<Drawernavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.facebook.com/photo/?fbid=3873466282880587&set=a.1397304100496830'),
              ),
              accountName: Text("Mahmoud Sherif"),
              accountEmail: Text("Mahmsherif28@gmail.com"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text("Home"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => homescrean())),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("categories"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CategoriesScrean())),
            ),
          ],
        ),
      ),
    );
  }
}
