import 'package:app_dashboard_news/apps/helper/show_toast.dart';
import 'package:app_dashboard_news/models/category.dart';
import 'package:flutter/material.dart';

import '../../../services/firebase_service.dart';
import '../../../widgets/custom_text_field.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController nameCategoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nameCategoryController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
            "Thêm thể loại",
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                nameField: "Tên thể loại:",
                icon: Icons.category_outlined,
                controller: nameCategoryController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                nameField: "Mô tả:",
                icon: Icons.category_outlined,
                controller: descriptionController,
              ),
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () async {
            Category newCategory = Category(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: nameCategoryController.text,
              description: descriptionController.text,
            );
            try {
              await FirebaseService().addCategory(newCategory);
              showToastSuccess("Thêm danh mục thành công");
              nameCategoryController.clear();
              descriptionController.clear();
            } catch (e) {
              showToastError("Lỗi: $e");
              print(e);
            }
          },
          child: Ink(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: Center(
                child: Text(
                  "Thêm thể loại",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
