import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/searvices/category_service.dart';
import 'package:intl/intl.dart';
import 'package:todolist/searvices/todo_services.dart';

class todo extends StatefulWidget {
  const todo({super.key});

  @override
  State<todo> createState() => _todoState();
}

class _todoState extends State<todo> {
  var _todotitlecontroller = TextEditingController();
  var _tododescreptionecontroller = TextEditingController();
  var _tododateecontroller = TextEditingController();
  var _selectedvalue;
  var _categories = <DropdownMenuItem>[];

  @override
  void initstate() {
    super.initState();
    _loadcategories();
  }

  _loadcategories() async {
    var _categoryServices = CategoryService();
    var categories = await _categoryServices.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category["name"]),
          value: category['name'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickDate != null) {
      setState(() {
        _dateTime = _pickDate;
        _tododateecontroller.text = DateFormat('yyyy-mm-dd').format(_pickDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _todotitlecontroller = TextEditingController(),
              decoration: InputDecoration(
                labelText: "title",
                hintText: "write what to do ",
              ),
            ),
            TextField(
              controller: _tododescreptionecontroller = TextEditingController(),
              decoration: InputDecoration(
                labelText: "Descreption",
                hintText: "write descreption ",
              ),
            ),
            TextField(
              controller: _tododateecontroller = TextEditingController(),
              decoration: InputDecoration(
                labelText: "date",
                hintText: "write date ",
                prefixIcon: InkWell(
                  onTap: () {
                    _selectedTodoDate(context);
                  },
                  child: Icon(Icons.date_range_outlined),
                ),
              ),
            ),
            DropdownButtonFormField(
              value: _selectedvalue,
              items: _categories,
              hint: Text("category"),
              onChanged: (value) {
                setState(() {
                  _selectedvalue = value;
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  var todoObject = Todo();
                  todoObject.title = _todotitlecontroller.text;
                  todoObject.description = _tododescreptionecontroller.text;
                  todoObject.isFinished = 0 as String?;
                  todoObject.category = _selectedvalue;
                  todoObject.todoDate = _tododateecontroller.text;
                  var _todoServices = TodoServices();
                  var result= await _todoServices.saveTodo(todoObject);
                  print(result);
                },
                child: Text(
                  "save",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
