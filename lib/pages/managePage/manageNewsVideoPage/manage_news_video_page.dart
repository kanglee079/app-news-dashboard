import 'package:app_dashboard_news/models/news_video.dart';
import 'package:flutter/material.dart';

import '../../../apps/route/route_name.dart';
import '../../../services/firebase_service.dart';
import '../../../widgets/item_video.dart';

class ManageNewsVideoPage extends StatelessWidget {
  const ManageNewsVideoPage({super.key});
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
            "Quản lí tin tức video",
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
                StreamBuilder<List<NewsVideo>>(
                  stream: FirebaseService().streamVideo(),
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
                        final video = snapshot.data![index];
                        return NewsVideoItem(
                          videoId: video.id,
                          title: video.title,
                          videoUrl: video.videoUrl,
                          likes: video.likes,
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
            Navigator.pushNamed(context, RouteName.manageAddNewsVideoPage);
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
