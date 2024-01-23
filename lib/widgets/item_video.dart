import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:video_player/video_player.dart';

import '../apps/helper/show_toast.dart';
import '../apps/route/route_name.dart';
import '../services/firebase_service.dart';

class NewsVideoItem extends StatefulWidget {
  final String videoId;
  final String title;
  final String videoUrl;
  final int likes;

  const NewsVideoItem({
    Key? key,
    required this.videoId,
    required this.title,
    required this.videoUrl,
    required this.likes,
  }) : super(key: key);

  @override
  State<NewsVideoItem> createState() => _NewsVideoItemState();
}

class _NewsVideoItemState extends State<NewsVideoItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                Navigator.pushNamed(context, RouteName.manageEditNewsVideoPage,
                    arguments: widget.videoId);
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
                  _showDeleteConfirmationDialog(context, widget.videoId),
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
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(
                        height: 195,
                        color: Colors.grey,
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
                      "Tiêu đề: ${widget.title ?? ""}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
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

void _showDeleteConfirmationDialog(BuildContext context, String videoId) {
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
                FirebaseService().deleteVideo(videoId);
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
