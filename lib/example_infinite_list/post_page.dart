import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/example_infinite_list/bloc/post_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:learn_bloc/example_infinite_list/models/post.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post page bloc'),
      ),
      body: BlocProvider(
        create: (_) => PostBloc(httpClient: http.Client())
          ..add(
            PostFatched(),
          ),
        child: PostList(),
      ),
    );
  }
}

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();
  late PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = context.read<PostBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      switch (state.status) {
        case PostStatus.failure:
          return Center(
            child: Text('Terjadi kesalah ketika get data'),
          );

        case PostStatus.success:
          if (state.posts.isEmpty) {
            return Center(
              child: Text('Tidak ada data'),
            );
          }

          return ListView.builder(
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? BottomLoader()
                  : PostListItem(post: state.posts[index]);
            },
          );

        default:
          return const Center(
            child: CircularProgressIndicator(),
          );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _postBloc.add(PostFatched());
  }

  bool get _isBottom {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      return true;
    } else {
      return false;
    }
  }
}

class PostListItem extends StatelessWidget {
  final Post post;

  PostListItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: Text('${post.id}'),
        isThreeLine: true,
        title: Text(post.title),
        subtitle: Text(post.body),
        dense: true,
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      child: Center(
        child: Text(
          'Memuat lebih banyak',
        ),
      ),
    );
  }
}
