import 'package:app_dashboard_news/models/category.dart';
import 'package:app_dashboard_news/models/news_video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/news_article.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCategory(Category category) async {
    await _firestore
        .collection('categories')
        .doc(category.id)
        .set(category.toMap());
  }

  Future<void> updateCategory(Category category) async {
    await _firestore
        .collection('categories')
        .doc(category.id)
        .update(category.toMap());
  }

  Future<void> deleteCategory(String categoryId) async {
    await _firestore.collection('categories').doc(categoryId).delete();
  }

  Stream<List<Category>> streamCategories() {
    return FirebaseFirestore.instance.collection('categories').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Category.fromMap(doc.data())).toList());
  }

  Future<List<Category>> getCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('categories').get();
      List<Category> categories = querySnapshot.docs.map((doc) {
        return Category.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return categories;
    } catch (e) {
      print("Error getting categories: $e");
      return [];
    }
  }

  Future<Category?> getCategoryById(String categoryId) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .get();

      if (docSnapshot.exists) {
        return Category.fromMap(docSnapshot.data() as Map<String, dynamic>);
      } else {
        print("Không tìm thấy danh mục với ID: $categoryId");
        return null;
      }
    } catch (e) {
      print("Lỗi khi lấy thông tin danh mục: $e");
      return null;
    }
  }

  //---------------------------------------
  Future<void> addArticle(NewsArticle article) async {
    await _firestore
        .collection('articles')
        .doc(article.id)
        .set(article.toMap());
  }

  Future<void> updateArticle(NewsArticle article) async {
    await _firestore
        .collection('articles')
        .doc(article.id)
        .update(article.toMap());
  }

  Future<void> deleteArticle(String articleId) async {
    await _firestore.collection('articles').doc(articleId).delete();
  }

  Stream<List<NewsArticle>> streamArticles() {
    return _firestore.collection('articles').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => NewsArticle.fromMap(doc.data())).toList());
  }

  Future<NewsArticle?> getArticleById(String articleId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('articles').doc(articleId).get();

      if (docSnapshot.exists) {
        return NewsArticle.fromMap(docSnapshot.data() as Map<String, dynamic>);
      } else {
        print("Không tìm thấy bài viết với ID: $articleId");
        return null;
      }
    } catch (e) {
      print("Lỗi khi lấy thông tin bài viết: $e");
      return null;
    }
  }

  //---------------------------------------
  // Hàm lấy số lượng người dùng
  Future<int> getUserCount() async {
    QuerySnapshot snapshot = await _firestore.collection('users').get();
    return snapshot.docs.length;
  }

  // Hàm lấy số lượng bài viết
  Future<int> getArticleCount() async {
    QuerySnapshot snapshot = await _firestore.collection('articles').get();
    return snapshot.docs.length;
  }

  // Hàm lấy số lượng danh mục
  Future<int> getCategoryCount() async {
    QuerySnapshot snapshot = await _firestore.collection('categories').get();
    return snapshot.docs.length;
  }

  Future<int> getVideoCount() async {
    QuerySnapshot snapshot = await _firestore.collection('videos').get();
    return snapshot.docs.length;
  }

  //----------------------
  Future<void> addVideo(NewsVideo video) async {
    await _firestore.collection('videos').doc(video.id).set(video.toMap());
  }

  Future<void> updateVideo(NewsVideo video) async {
    await _firestore.collection('videos').doc(video.id).update(video.toMap());
  }

  Future<void> deleteVideo(String videoId) async {
    await _firestore.collection('videos').doc(videoId).delete();
  }

  Stream<List<NewsVideo>> streamVideo() {
    return _firestore.collection('videos').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => NewsVideo.fromMap(doc.data())).toList());
  }

  Future<NewsVideo?> getVideoById(String videoId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('videos').doc(videoId).get();

      if (docSnapshot.exists) {
        return NewsVideo.fromMap(docSnapshot.data() as Map<String, dynamic>);
      } else {
        print("Không tìm thấy bài viết với ID: $videoId");
        return null;
      }
    } catch (e) {
      print("Lỗi khi lấy thông tin bài viết: $e");
      return null;
    }
  }
}
