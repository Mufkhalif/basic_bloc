import 'package:equatable/equatable.dart';
import 'package:learn_bloc/example_github_search/models/search_result_item.dart';

abstract class GithubSearchState extends Equatable {
  const GithubSearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends GithubSearchState {}

class SearchStateLoading extends GithubSearchState {}

class SearchStateSuccess extends GithubSearchState {
  const SearchStateSuccess(this.items);

  final List<SearchResultItem> items;

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

class SearchStateError extends GithubSearchState {
  const SearchStateError(this.error);

  final String error;
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SearchStateError { error: $error }';
}
