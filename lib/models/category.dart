class Category {
  int? id;
  var task;
  var date;

  categorymap() {
    var mapping = Map<String, dynamic>();
    mapping["id"] = id;
    mapping["task"] = task;
    mapping["date"] = date;
    return mapping;
  }
}
