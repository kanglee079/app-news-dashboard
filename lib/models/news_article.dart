class NewsArticle {
  String id;
  String idCategory;
  bool isFeatured;
  String title;
  String authorName;
  DateTime dateTime;
  String description;
  String content;
  List<Comment> comments;
  String photoUrl;
  int likes;

  NewsArticle({
    required this.id,
    required this.idCategory,
    required this.isFeatured,
    required this.title,
    required this.authorName,
    required this.dateTime,
    required this.description,
    required this.content,
    required this.comments,
    required this.photoUrl,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idCategory': idCategory,
      'isFeatured': isFeatured,
      'title': title,
      'authorName': authorName,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'description': description,
      'content': content,
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'photoUrl': photoUrl,
      'likes': likes,
    };
  }

  factory NewsArticle.fromMap(Map<String, dynamic> map) {
    return NewsArticle(
      id: map['id'],
      idCategory: map['idCategory'],
      isFeatured: map['isFeatured'],
      title: map['title'],
      authorName: map['authorName'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      description: map['description'],
      content: map['content'],
      comments:
          List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
      photoUrl: map['photoUrl'],
      likes: map['likes'],
    );
  }
}

class Comment {
  String authorName;
  String content;
  List<Reply> replies;

  Comment({
    required this.authorName,
    required this.content,
    required this.replies,
  });

  Map<String, dynamic> toMap() {
    return {
      'authorName': authorName,
      'content': content,
      'replies': replies.map((reply) => reply.toMap()).toList(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      authorName: map['authorName'],
      content: map['content'],
      replies: List<Reply>.from(map['replies']?.map((x) => Reply.fromMap(x))),
    );
  }
}

class Reply {
  String authorName;
  String content;

  Reply({required this.authorName, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'authorName': authorName,
      'content': content,
    };
  }

  factory Reply.fromMap(Map<String, dynamic> map) {
    return Reply(
      authorName: map['authorName'],
      content: map['content'],
    );
  }
}
