import 'package:flutter/material.dart';
import 'package:todolist/helper/drawer_navigation.dart';
class homescrean extends StatefulWidget {
  const homescrean({super.key});

  @override
  State<homescrean> createState() => _home_screanState();
}

class _home_screanState extends State<homescrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasker",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),),
          drawer: Drawernavigation(),
    );
  }
}
