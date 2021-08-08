import 'package:learn_bloc/example_github_search/models/search_result_item.dart';

class SearchResult {
  SearchResult({required this.items});

  final List<SearchResultItem> items;

  static SearchResult fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map(
          (dynamic e) => SearchResultItem.fromJson(e as Map<String, dynamic>),
        )
        .toList();

    return SearchResult(items: items);
  }
}
