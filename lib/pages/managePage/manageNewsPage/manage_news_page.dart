import 'package:flutter/material.dart';

import '../../../apps/route/route_name.dart';
import '../../../models/news_article.dart';
import '../../../services/firebase_service.dart';
import '../../../widgets/item_news.dart';

class ManageNewsPage extends StatelessWidget {
  const ManageNewsPage({super.key});
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
            "Sách",
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  "Danh sách tin tức",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<NewsArticle>>(
                  stream: FirebaseService().streamArticles(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Không có tin tức nào'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final article = snapshot.data![index];
                        return NewsArticleItem(
                          id: article.id,
                          title: article.title,
                          authorName: article.authorName,
                          dateTime: article.dateTime,
                          description: article.description,
                          photoUrl: article.photoUrl,
                          likes: article.likes,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.manageAddNewsPage);
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
