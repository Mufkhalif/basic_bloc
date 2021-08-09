import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/example_github_search/bloc/github_search_event.dart';
import 'package:learn_bloc/example_github_search/bloc/github_search_state.dart';
import 'package:learn_bloc/example_github_search/models/search_result_error.dart';
import 'package:learn_bloc/example_github_search/service/github_repository.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/rxdart.dart';

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  GithubSearchBloc({
    required this.githubRepository,
  }) : super(SearchStateEmpty());

  final GithubRepository githubRepository;

  @override
  Stream<Transition<GithubSearchEvent, GithubSearchState>> transformEvents(
      Stream<GithubSearchEvent> events,
      TransitionFunction<GithubSearchEvent, GithubSearchState> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 300)),
      transitionFn,
    );
  }

  @override
  Stream<GithubSearchState> mapEventToState(GithubSearchEvent event) async* {
    if (event is TextChanged) {
      final searchTerm = event.text;

      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          final results = await githubRepository.search(searchTerm);
          yield SearchStateSuccess(results.items);
        } catch (error) {
          yield error is SearchResultError
              ? SearchStateError(error.message)
              : SearchStateError("Something error");
        }
      }
    }
  }
}
