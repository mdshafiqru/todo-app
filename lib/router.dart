import 'package:go_router/go_router.dart';
import 'package:todoapp/screens/create_todo_screen.dart';
import 'package:todoapp/screens/home_screen.dart';

class AppRouter {
  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'create-todo',
            builder: (context, state) => const CreateToDoScreen(),
          ),
        ],
      ),
    ],
  );

  GoRouter get router => _router;
}
