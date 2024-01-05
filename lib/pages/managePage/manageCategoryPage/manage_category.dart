import 'package:app_dashboard_news/apps/route/route_name.dart';
import 'package:app_dashboard_news/models/category.dart';
import 'package:flutter/material.dart';

import '../../../services/firebase_service.dart';
import '../../../widgets/item_category.dart';

class ManageCateogryPage extends StatelessWidget {
  const ManageCateogryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Danh Mục",
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  "Danh sách danh mục",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<Category>>(
                  stream: FirebaseService().streamCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Không có danh mục nào'));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ItemCategory(
                          index: index,
                          nameCategory: snapshot.data![index].name,
                          idCategory: snapshot.data![index].id,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.manageAddCategoryPage);
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
