import 'package:app_dashboard_news/apps/route/route_name.dart';
import 'package:flutter/material.dart';

import '../../widgets/item_admin_page.dart';

class ManagePage extends StatelessWidget {
  const ManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mục quản trị",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: Column(
        children: [
          ItemAdminPage(
            nameItem: "Danh Mục",
            ontap: () {
              Navigator.pushNamed(context, RouteName.manageCategoryPage);
            },
          ),
          ItemAdminPage(
            nameItem: "Bài Viết",
            ontap: () {
              Navigator.pushNamed(context, RouteName.manageNewsPage);
            },
          ),
          ItemAdminPage(
            nameItem: "Videos",
            ontap: () {
              Navigator.pushNamed(context, RouteName.manageNewsVideoPage);
            },
          ),
          ItemAdminPage(
            nameItem: "Người dùng",
            ontap: () {},
          ),
        ],
      ),
    );
  }
}
