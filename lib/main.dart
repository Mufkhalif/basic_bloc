import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/example_snackbar/bloc/data_bloc.dart';
import 'package:learn_bloc/example_snackbar/snackbar_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc(),
      child: MaterialApp(
        home: SnackbarPage(),
      ),
    );
  }
}

/// Void main for github search
// void main() {
//   final GithubRepository githubRepository = GithubRepository(
//     GithubCache(),
//     GithubClient(),
//   );
//
//   runApp(MyApp(
//     githubRepository: githubRepository,
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   MyApp({required this.githubRepository});
//
//   final GithubRepository githubRepository;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Github Search',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Github Search'),
//         ),
//         body: BlocProvider(
//           create: (_) => GithubSearchBloc(githubRepository: githubRepository),
//           child: SearchForm(),
//         ),
//       ),
//     );
//   }
// }

// ======================== /// ======================== //

/// MyApp for example_infinite_list
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Color.fromRGBO(109, 234, 255, 1),
//         accentColor: Color.fromRGBO(72, 74, 126, 1),
//         brightness: Brightness.dark,
//       ),
//       home: PostPage(),
//     );
//   }
// }

// ======================== /// ======================== //


/// MyApp for example_timer;
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Color.fromRGBO(109, 234, 255, 1),
//         accentColor: Color.fromRGBO(72, 74, 126, 1),
//         brightness: Brightness.dark,
//       ),
//       home: TimerPage(),
//     );
//   }
// }

// ======================== /// ======================== //

/// MyApp for example_counter;
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocProvider(
//         create: (_) => CounterCubit(0),
//         child: CounterPage(),
//       ),
//     );
//   }
// }
