import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NewsArticleItem extends StatelessWidget {
  final String id;
  final String title;
  final String authorName;
  final DateTime dateTime;
  final String description;
  final String photoUrl;
  final int likes;

  const NewsArticleItem({
    Key? key,
    required this.id,
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
              onPressed: (context) {},
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              icon: Icons.edit,
              label: 'Sửa',
            ),
            const SizedBox(width: 1),
            SlidableAction(
              onPressed: (context) {},
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
            color: Theme.of(context).hintColor,
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
