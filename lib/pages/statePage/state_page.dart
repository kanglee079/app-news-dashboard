import 'package:flutter/material.dart';

import '../../services/firebase_service.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int numUsers = 0;
  int numArticles = 0;
  int numCategories = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    numUsers = await FirebaseService().getUserCount();
    numArticles = await FirebaseService().getArticleCount();
    numCategories = await FirebaseService().getCategoryCount();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mục thống kê",
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard("Người dùng hiện tại", numUsers),
                const SizedBox(width: 30),
                _buildStatCard("Số bài viết hiện tại", numArticles),
                const SizedBox(width: 30),
                _buildStatCard("Số danh mục hiện tại", numCategories),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatCard(String title, int count) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF6252DA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Center(
          child: Text("$title: $count"),
        ),
      ),
    ),
  );
}
