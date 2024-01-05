import 'package:flutter/material.dart';

class ItemAdminPage extends StatelessWidget {
  String nameItem;
  Function() ontap;
  ItemAdminPage({
    super.key,
    required this.nameItem,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 137, 126, 218),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Text(nameItem),
              ),
              IconButton(
                onPressed: ontap,
                icon: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
