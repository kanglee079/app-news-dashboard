import 'package:app_dashboard_news/apps/helper/show_toast.dart';
import 'package:app_dashboard_news/models/category.dart';
import 'package:app_dashboard_news/models/news_article.dart';
import 'package:app_dashboard_news/services/firebase_service.dart';
import 'package:app_dashboard_news/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddNewsArticleScreen extends StatefulWidget {
  const AddNewsArticleScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsArticleScreen> createState() => _AddNewsArticleScreenState();
}

class _AddNewsArticleScreenState extends State<AddNewsArticleScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController photoUrlController = TextEditingController();
  String? selectedCategoryId;
  bool isFeatured = false;
  List<Category> categories = []; // Placeholder for categories

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    var loadedCategories = await FirebaseService().getCategories();
    setState(() {
      categories = loadedCategories;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    authorNameController.dispose();
    descriptionController.dispose();
    contentController.dispose();
    photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Thêm tin tức mới'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              CustomTextField(
                nameField: 'Tiêu đề',
                icon: Icons.title,
                controller: titleController,
              ),
              const SizedBox(height: 10),
              // Dropdown for categories
              DropdownButtonFormField<String>(
                value: selectedCategoryId,
                hint: const Text('Chọn danh mục'),
                dropdownColor: Colors.grey,
                style: const TextStyle(color: Colors.black),
                onChanged: (newValue) {
                  setState(() {
                    selectedCategoryId = newValue;
                  });
                },
                items: categories
                    .map<DropdownMenuItem<String>>((Category category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                nameField: 'Tên tác giả',
                icon: Icons.person,
                controller: authorNameController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                nameField: 'Mô tả',
                icon: Icons.description,
                controller: descriptionController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                nameField: 'Nội dung',
                icon: Icons.text_snippet,
                controller: contentController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                nameField: 'Photo URL',
                icon: Icons.image,
                controller: photoUrlController,
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text('Là bài viết nổi bật'),
                value: isFeatured,
                onChanged: (newValue) {
                  setState(() {
                    isFeatured = newValue ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Handle the article addition logic
                  try {
                    NewsArticle newArticle = NewsArticle(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      idCategory: selectedCategoryId ?? '',
                      isFeatured: isFeatured,
                      title: titleController.text,
                      authorName: authorNameController.text,
                      dateTime: DateTime.now(),
                      description: descriptionController.text,
                      content: contentController.text,
                      comments: [],
                      photoUrl: photoUrlController.text,
                      likes: 0,
                    );
                    await FirebaseService().addArticle(newArticle);
                    showToastSuccess("Thêm tin tức thành công");
                  } catch (e) {
                    showToastError("Error: $e");
                  }
                },
                child: const Text('Thêm tin tức'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
