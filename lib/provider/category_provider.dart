import 'package:app_dashboard_news/models/category.dart';
import 'package:flutter/widgets.dart';

class CategoryProvider with ChangeNotifier {
  final List<Category> _categories = [];

  List<Category> get categories => _categories;

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }

  void getAllCategory() {}
}
