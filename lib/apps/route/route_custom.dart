import 'package:app_dashboard_news/models/category.dart';
import 'package:app_dashboard_news/pages/managePage/manageCategoryPage/add_manage_cateogry.dart';
import 'package:app_dashboard_news/pages/managePage/manageCategoryPage/edit_manage_category.dart';
import 'package:app_dashboard_news/pages/managePage/manageCategoryPage/manage_category.dart';
import 'package:app_dashboard_news/pages/managePage/manageNewsPage/add_manage_news.dart';
import 'package:app_dashboard_news/pages/managePage/manageNewsPage/edit_manage_news.dart';
import 'package:app_dashboard_news/pages/managePage/manageNewsPage/manage_news_page.dart';
import 'package:app_dashboard_news/pages/my_app.dart';
import 'package:app_dashboard_news/pages/settingPage/setting_page.dart';
import 'package:app_dashboard_news/pages/statePage/state_page.dart';
import 'package:flutter/material.dart';

import '../../pages/managePage/manage_page.dart';
import 'route_name.dart';

class RouterCustom {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.myHomePage:
        return MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        );
      case RouteName.statePage:
        return MaterialPageRoute(
          builder: (context) => const StatsPage(),
        );
      case RouteName.managePage:
        return MaterialPageRoute(
          builder: (context) => const ManagePage(),
        );
      case RouteName.settingName:
        return MaterialPageRoute(
          builder: (context) => const SettingsPage(),
        );
      case RouteName.manageCategoryPage:
        return MaterialPageRoute(
          builder: (context) => const ManageCateogryPage(),
        );
      case RouteName.manageAddCategoryPage:
        return MaterialPageRoute(
          builder: (context) => const AddCategoryScreen(),
        );
      case RouteName.manageEditCategoryPage:
        var argument = settings.arguments as Category;
        return MaterialPageRoute(
          builder: (context) => EditCategoryPage(
            categoryId: argument.id,
          ),
        );
      case RouteName.manageNewsPage:
        return MaterialPageRoute(
          builder: (context) => const ManageNewsPage(),
        );
      case RouteName.manageAddNewsPage:
        return MaterialPageRoute(
          builder: (context) => const AddNewsArticleScreen(),
        );
      case RouteName.manageEditNewsPage:
        var articleId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => EditNewsArticlePage(
            articleId: articleId,
          ),
        );

      default:
        return _errorPage();
    }
  }

  static Route _errorPage() {
    return MaterialPageRoute(builder: (context) {
      return Container();
    });
  }
}
