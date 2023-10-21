class Todo{
  int? id ;
  String? title;
  String? description;
  String? category;
  String? todoDate;
  String? isFinished;
  todomap(){
    var mapping=Map<String,dynamic>();
    mapping["id"]=id;
    mapping["title"]=title;
    mapping["description"]=description;
    mapping["category"]=category;
    mapping["todoDate"]=todoDate;
    mapping["isFinished"]=isFinished;
    return mapping;
  }
}