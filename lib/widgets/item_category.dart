import 'package:app_dashboard_news/apps/helper/show_toast.dart';
import 'package:app_dashboard_news/apps/route/route_name.dart';
import 'package:app_dashboard_news/models/category.dart';
import 'package:app_dashboard_news/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemCategory extends StatelessWidget {
  String? idCategory;
  String? nameCategory;
  int index;

  ItemCategory({
    super.key,
    required this.index,
    required this.nameCategory,
    required this.idCategory,
  });

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
                Navigator.pushNamed(
                  context,
                  RouteName.manageEditCategoryPage,
                  arguments: Category(
                    id: idCategory!,
                    name: nameCategory!,
                    description: "",
                  ),
                );
              },
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              icon: Icons.edit,
              label: 'Sửa',
            ),
            const SizedBox(width: 2),
            SlidableAction(
              onPressed: (context) =>
                  _showDeleteConfirmationDialog(context, idCategory!),
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              icon: Icons.delete,
              label: 'Xoá',
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.primaries[index % 12],
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Text(nameCategory ?? ""),
          ),
        ),
      ),
    );
  }
}

void _showDeleteConfirmationDialog(BuildContext context, String categoryId) {
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
                FirebaseService().deleteCategory(categoryId);
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
