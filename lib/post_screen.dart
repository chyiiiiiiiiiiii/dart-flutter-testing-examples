import 'package:flutter/material.dart';
import 'package:test/data/posts.dart';
import 'package:test/models/post.dart';
import 'package:test/service/api_service.dart';

ApiService apiService = ApiService();

class PostScreen extends StatefulWidget {
  const PostScreen({
    super.key,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // 模擬發送讚請求到伺服器
  Future<void> _toggleLike(int index, Post post) async {
    bool newLikeStatus = !post.isLiked;
    int newLikeCount = post.likeCount + (newLikeStatus ? 1 : -1);

    setState(() {
      final newPostInfo = (
        true,
        post.copyWith(isLiked: newLikeStatus, likeCount: newLikeCount)
      );
      postData[index] = newPostInfo;
    });

    try {
      final response = await apiService.likePost(
        postName: post.postName,
        newLikeStatus: newLikeStatus,
      );
      if (response.statusCode != 200) {
        newLikeStatus = post.isLiked;
        newLikeCount = post.likeCount;

        setState(() {
          final newPostInfo = (
            false,
            post.copyWith(isLiked: newLikeStatus, likeCount: newLikeCount)
          );
          postData[index] = newPostInfo;
        });
      }
    } catch (error) {
      newLikeStatus = post.isLiked;
      newLikeCount = post.likeCount;

      setState(() {
        final newPostInfo = (
          false,
          post.copyWith(isLiked: newLikeStatus, likeCount: newLikeCount)
        );
        postData[index] = newPostInfo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('貼文列表')),
      body: Center(
          child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: postData.length,
        itemBuilder: (BuildContext context, int index) {
          final data = postData.elementAt(index);
          final isLoading = data.$1;
          final post = data.$2;

          return Row(
            key: ValueKey('item-$index'),
            children: [
              Text(post.postName),
              const SizedBox(width: 20),
              Text(
                key: ValueKey('like-count-$index'),
                '讚數：${post.likeCount}',
              ),
              const SizedBox(width: 20),
              IconButton(
                key: ValueKey('icon-button-$index'),
                icon: Icon(
                  key: ValueKey('icon-$index'),
                  post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: post.isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: () => isLoading ? null : _toggleLike(index, post),
              ),
            ],
          );
        },
      )),
    );
  }
}
