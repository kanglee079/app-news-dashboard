import 'package:app_dashboard_news/apps/helper/show_toast.dart';
import 'package:app_dashboard_news/models/news_article.dart';
import 'package:app_dashboard_news/services/firebase_service.dart';
import 'package:app_dashboard_news/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../../models/category.dart';

class EditNewsVideoPage extends StatefulWidget {
  String videoId;

  EditNewsVideoPage({Key? key, required this.videoId}) : super(key: key);

  @override
  _EditNewsVideoPageState createState() => _EditNewsVideoPageState();
}

class _EditNewsVideoPageState extends State<EditNewsVideoPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController photoUrlController = TextEditingController();
  String? selectedCategoryId;
  bool isFeatured = false;
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _loadArticleData();
    _loadCategories();
  }

  Future<void> _loadArticleData() async {
    NewsArticle? article =
        await FirebaseService().getArticleById(widget.videoId);
    if (article != null) {
      titleController.text = article.title;
      authorNameController.text = article.authorName;
      descriptionController.text = article.description;
      contentController.text = article.content;
      photoUrlController.text = article.photoUrl;
      selectedCategoryId = article.idCategory;
      isFeatured = article.isFeatured;
      setState(() {});
    }
  }

  Future<void> _loadCategories() async {
    categories = await FirebaseService().getCategories();
    setState(() {});
  }

  bool _validateInput() {
    if (titleController.text.isEmpty ||
        authorNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        contentController.text.isEmpty ||
        photoUrlController.text.isEmpty ||
        selectedCategoryId == null) {
      showToastError("Vui lòng nhập đầy đủ thông tin!");
      return false;
    }
    return true;
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
          title: const Text('Chỉnh sửa bài viết'),
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
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text("Chọn danh mục"),
                  ),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
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
                  ),
                ],
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_validateInput()) {
                    try {
                      NewsArticle updatedArticle = NewsArticle(
                        id: widget.videoId,
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
                      await FirebaseService().updateArticle(updatedArticle);
                      showToastSuccess("Chỉnh sửa bài viết thành công");
                    } catch (e) {
                      showToastError("Error: $e");
                    }
                  }
                },
                child: const Text('Cập nhật bài viết'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
