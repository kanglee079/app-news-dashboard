import 'package:app_dashboard_news/apps/helper/show_toast.dart';
import 'package:app_dashboard_news/models/news_video.dart';
import 'package:app_dashboard_news/services/firebase_service.dart';
import 'package:app_dashboard_news/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddNewsVideoScreen extends StatefulWidget {
  const AddNewsVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsVideoScreen> createState() => _AddNewsVideoScreenState();
}

class _AddNewsVideoScreenState extends State<AddNewsVideoScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController videoUrlController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();

    videoUrlController.dispose();
    super.dispose();
  }

  bool _validateInput() {
    if (titleController.text.isEmpty || videoUrlController.text.isEmpty) {
      showToastError("Vui lòng nhập đầy đủ thông tin!");
      return false;
    }
    return true;
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
              // Dropdown for categories

              const SizedBox(height: 10),
              CustomTextField(
                nameField: 'Video URL',
                icon: Icons.image,
                controller: videoUrlController,
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_validateInput()) {
                    try {
                      NewsVideo newVideo = NewsVideo(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleController.text,
                        videoUrl: videoUrlController.text,
                        likes: 0,
                      );
                      await FirebaseService().addVideo(newVideo);
                      titleController.clear();
                      videoUrlController.clear();
                      showToastSuccess("Thêm tin tức thành công");
                    } catch (e) {
                      showToastError("Error: $e");
                    }
                  }
                },
                child: const Text('Thêm video tin tức'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
