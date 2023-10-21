import 'package:flutter/material.dart';
import 'package:todolist/helper/drawer_navigation.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/screans/todo_screan.dart';
import 'package:todolist/searvices/todo_services.dart';

class homescrean extends StatefulWidget {
  const homescrean({super.key});

  @override
  State<homescrean> createState() => _home_screanState();
}

class _home_screanState extends State<homescrean> {
  TodoServices _todoServices = TodoServices();
  List<Todo> _todolist = <Todo>[];

  @override
  initstae() {
    super.initState();
    getalltodo();
  }

  getalltodo() async {
    _todoServices = TodoServices();
    _todolist = <Todo>[];
    var todo = await _todoServices.readTodo();
    todo.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todolist.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasker",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
      ),
      drawer: Drawernavigation(),
      body: ListView.builder(
          itemCount: _todolist.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:  EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(_todolist[index].title ?? "no title")],
                  ),
                  subtitle: Text(_todolist[index].category ?? "no Category"),
                  trailing: Text(_todolist[index].todoDate ?? "no date"),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => todo())),
        child: Icon(Icons.add),
      ),
    );
  }
}
