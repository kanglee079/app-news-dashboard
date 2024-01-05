import 'package:flutter/widgets.dart';

import '../models/news_article.dart';

class ArticleProvider with ChangeNotifier {
  void addArticle(NewsArticle article) {
    notifyListeners();
  }
}
