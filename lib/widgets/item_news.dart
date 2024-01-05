import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../apps/helper/show_toast.dart';
import '../apps/route/route_name.dart';
import '../services/firebase_service.dart';

class NewsArticleItem extends StatelessWidget {
  final String articleId;
  final String title;
  final String authorName;
  final DateTime dateTime;
  final String description;
  final String photoUrl;
  final int likes;

  const NewsArticleItem({
    Key? key,
    required this.articleId,
    required this.title,
    required this.authorName,
    required this.dateTime,
    required this.description,
    required this.photoUrl,
    required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            const SizedBox(width: 2),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, RouteName.manageEditNewsPage,
                    arguments: articleId);
              },
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              icon: Icons.edit,
              label: 'Sửa',
            ),
            const SizedBox(width: 1),
            SlidableAction(
              onPressed: (context) =>
                  _showDeleteConfirmationDialog(context, articleId),
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              icon: Icons.delete,
              label: 'Xoá',
            ),
          ],
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 195,
                  color: Colors.redAccent,
                  child: Image.network(
                    photoUrl ??
                        "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tiêu đề: ${title ?? ""}",
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Tên tác giả: ${authorName ?? ""}",
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Mô tả: ${description ?? ""}",
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDeleteConfirmationDialog(BuildContext context, String articleId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Xác Nhận Xoá',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        content: const Text('Bạn có chắc chắn muốn xoá danh mục này không?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Huỷ'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Xoá'),
            onPressed: () {
              try {
                FirebaseService().deleteArticle(articleId);
                Navigator.of(context).pop();
                showToastSuccess("Xoá thành công");
              } catch (e) {}
            },
          ),
        ],
      );
    },
  );
}
