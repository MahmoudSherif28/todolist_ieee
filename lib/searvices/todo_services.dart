import 'package:todolist/database/repository.dart';
import 'package:todolist/models/todo.dart';

class TodoServices{
  Repository? _repository;

   TodoServices(){
    _repository=Repository();
  }
  saveTodo(Todo todo)async{
    return await _repository?.insertdata("todo", todo.todomap());
  }
  readTodo()async{
     return await _repository?.readdata("todo");

  }
}