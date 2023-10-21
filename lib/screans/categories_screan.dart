import 'package:flutter/material.dart';
import 'package:todolist/models/category.dart';
import 'package:todolist/screans/home_screan.dart';
import 'package:todolist/searvices/category_service.dart';
import 'package:todolist/database/repository.dart';
import 'package:sqflite/sqflite.dart';

class CategoriesScrean extends StatefulWidget {
  const CategoriesScrean({super.key});

  @override
  State<CategoriesScrean> createState() => _CategoriesScreanState();
}

class _CategoriesScreanState extends State<CategoriesScrean> {
  var _categorynamecontroller = TextEditingController();
  var _categorydescreptioncontroller = TextEditingController();
  var _category = Category();
  var _categoryservice = CategoryService();
  List<Category> _categoryList = <Category>[];
  var category;
  var _editCategorynamecontroller = TextEditingController();
  var _editCategorydescreptioncontroller = TextEditingController();

  @override
  void initstate() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = <Category>[];
    var categories = await _categoryservice.readCategories();
    categories.foreach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.task = category["task"];
        categoryModel.date = category["date"];
        categoryModel.id = category["id"];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryservice.readCategorybyId(categoryId);
    setState(() {
      _editCategorynamecontroller.text =
          category[0]['task'] ?? 'no task';
      _editCategorydescreptioncontroller.text =
          category[0]['date'] ?? 'no date';
    });
    _editFormdialog(context);
  }

  _showFormdialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () async {
                    _category.task = _categorynamecontroller.text;
                    _category.date = _categorydescreptioncontroller.text;
                    var result = await _categoryservice.savecategory(_category);
                    if(result>0){
                      print(result);
                      Navigator.pop(context);
                      getAllCategories();
                    }
                  },
                  child: Text("save", style: TextStyle(color: Colors.blue))),
            ],
            title: Text("Categories"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categorynamecontroller,
                    decoration: InputDecoration(
                      hintText: "write Task",
                      labelText: 'Task',
                    ),
                  ),
                  TextField(
                    controller: _categorydescreptioncontroller,
                    decoration: InputDecoration(
                      hintText: "write date",
                      labelText: 'date',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFormdialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () => Navigator.pop(context),

                child: Text(
                  "cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () async {
                    _category.id=category[0]['id'];
                    _category.task = _editCategorynamecontroller.text;
                    _category.date = _editCategorydescreptioncontroller.text;
                    var result = await _categoryservice.updatecategory(_category);
                    if(result>=0){
                      Navigator.pop(context);
                      getAllCategories();
                    }
                  },
                  child: Text("update", style: TextStyle(color: Colors.blue))),
            ],
            title: Text("edit Categories"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editCategorynamecontroller,
                    decoration: InputDecoration(
                      hintText: "write Task",
                      labelText: 'Task',
                    ),
                  ),
                  TextField(
                    controller: _editCategorydescreptioncontroller,
                    decoration: InputDecoration(
                      hintText: "write date",
                      labelText: 'date',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormdialog(BuildContext context,catoegoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () => Navigator.pop(context),

                child: Text(
                  "cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () async {

                    var result = await _categoryservice.deletecategory(catoegoryId);
                    if(result>=0){
                      Navigator.pop(context);
                      getAllCategories();
                    }
                  },
                  child: Text("delete", style: TextStyle(color: Colors.blue))),
            ],
            title: Text("delete Category ?"),
  
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => homescrean())),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text("Categories "),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8.0,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editCategory(context, _categoryList[index].id);
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_categoryList[index].task),
                    IconButton(
                        onPressed: () {
                          _deleteFormdialog(context,_categoryList[index].id);
                        },
                        icon: Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.red,
                        ))
                  ],
                ),
                subtitle: Text(_categoryList[index].date),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormdialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
