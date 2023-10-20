import 'package:todolist/database/repository.dart';
import 'package:todolist/models/category.dart';

class CategoryService {
  Repository? _repository;
  CategoryService(){
    _repository=Repository();

  }

  savecategory(Category category) async{
  return await _repository?.insertdata("categories", category.categorymap());
  }
  readCategories()async{
    _repository?.readdata("category");
    return await _repository?.readdata('category');
  }

  readCategorybyId(categoryId)async {
    return await _repository?.readDataById('categories',categoryId);
  }

  updatecategory(Category category)async {
    return await _repository?.updatedata("categories",category.categorymap());
  }
}
