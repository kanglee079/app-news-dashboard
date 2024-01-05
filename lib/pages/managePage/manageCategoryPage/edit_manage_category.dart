import 'package:app_dashboard_news/models/category.dart';
import 'package:app_dashboard_news/services/firebase_service.dart';
import 'package:flutter/material.dart';

import '../../../apps/helper/show_toast.dart';
import '../../../widgets/custom_text_field.dart';

class EditCategoryPage extends StatefulWidget {
  String categoryId;
  EditCategoryPage({
    super.key,
    required this.categoryId,
  });

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final TextEditingController nameCategoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCategoryById(widget.categoryId);
  }

  Future<void> _getCategoryById(String categoryId) async {
    final category = await FirebaseService().getCategoryById(categoryId);
    if (category != null) {
      nameCategoryController.text = category.name;
      descriptionController.text = category.description;
    }
  }

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
            "Sửa thể loại",
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
            Category updatedCategory = Category(
              id: widget.categoryId,
              name: nameCategoryController.text,
              description: descriptionController.text,
            );
            await FirebaseService().updateCategory(updatedCategory);
            showToastSuccess("Sửa thành công");
          },
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                "Sửa thể loại",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
