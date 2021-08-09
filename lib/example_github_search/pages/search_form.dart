import 'package:flutter/material.dart';
import 'package:learn_bloc/example_github_search/bloc/github_search_bloc.dart';
import 'package:learn_bloc/example_github_search/bloc/github_search_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/example_github_search/bloc/github_search_state.dart';
import 'package:learn_bloc/example_github_search/models/search_result_item.dart';

class SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SearchBar(),
        _SearchBody(),
      ],
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  late GithubSearchBloc _githubSearchBloc;

  @override
  void initState() {
    super.initState();
    _githubSearchBloc = context.read<GithubSearchBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        _githubSearchBloc.add(
          TextChanged(text: text),
        );
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: GestureDetector(
          onTap: _onClearTapped,
          child: const Icon(Icons.clear),
        ),
        border: InputBorder.none,
        hintText: 'Enter a search term',
      ),
    );
  }

  void _onClearTapped() {
    _textController.text = '';
    _githubSearchBloc.add(const TextChanged(text: ''));
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GithubSearchBloc, GithubSearchState>(
      builder: (context, state) {
        if (state is SearchStateLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is SearchStateError) {
          return Center(child: Text(state.error));
        }

        if (state is SearchStateSuccess) {
          return state.items.isEmpty
              ? Text('Not found')
              : Expanded(
                  child: _SearchResults(items: state.items),
                );
        }

        return const Text("Please Type text");
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.items});

  final List<SearchResultItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(
          item: items[index],
        );
      },
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  _SearchResultItem({required this.item});
  final SearchResultItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(item.owner.avatarUrl),
      ),
      title: Text(item.fullName),
      onTap: () {},
    );
  }
}
