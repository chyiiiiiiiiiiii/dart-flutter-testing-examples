import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class Post {
  final String postName;
  final bool isLiked;
  final int likeCount;

  const Post(
      {required this.postName, required this.isLiked, required this.likeCount});

  @override
  String toString() {
    return 'Post(postName: $postName, isLiked: $isLiked, likeCount: $likeCount)';
  }

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postName: json['postName'] as String? ?? '',
        isLiked: json['isLiked'] as bool? ?? false,
        likeCount: json['likeCount'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'postName': postName,
        'isLiked': isLiked,
        'likeCount': likeCount,
      };

  Post copyWith({
    String? postName,
    bool? isLiked,
    int? likeCount,
  }) {
    return Post(
      postName: postName ?? this.postName,
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Post) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => postName.hashCode ^ isLiked.hashCode ^ likeCount.hashCode;
}
