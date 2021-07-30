import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/example_counter/cubit/counter_cubit.dart';
import 'package:learn_bloc/example_counter/view/counter_page.dart';
import 'package:learn_bloc/example_infinite_list/post_page.dart';
import 'package:learn_bloc/example_timer/timer_page.dart';

import 'counter_observer.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(109, 234, 255, 1),
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.dark,
      ),
      home: PostPage(),
    );
  }
}

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
