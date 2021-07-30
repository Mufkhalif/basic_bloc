import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/example_infinite_list/models/post.dart';
import 'package:http/http.dart' as http;

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 20;

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState());

  final http.Client httpClient;

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostFatched) {
      yield await _mapPostFatchedToState(state);
    }
  }

  Future<PostState> _mapPostFatchedToState(PostState state) async {
    if (state.hasReachedMax) return state;

    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        );
      }

      final posts = await _fetchPosts(state.posts.length);
      print("fetching more");
      print(posts);
      return posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              posts: List.of(state.posts)..addAll(posts),
              status: PostStatus.success,
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: PostStatus.failure);
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Post(
          id: json['id'] as int,
          title: json['title'] as String,
          body: json['body'] as String,
        );
      }).toList();
    }

    throw Exception('error fetching posts');
  }
}