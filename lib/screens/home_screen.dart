import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/controllers/todo_controller.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/widgets/unfocus_ontap.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _editKey = GlobalKey<FormState>();

  final _editTitleController = TextEditingController();
  final _editDescriptionController = TextEditingController();

  void save(String id) async {
    if (_editKey.currentState != null) {
      if (_editKey.currentState!.validate()) {
        ref.read(todoControllerProvider.notifier).editTodo(
              id: id,
              title: _editTitleController.text.trim(),
              description: _editDescriptionController.text.trim(),
              context: context,
            );
      }
    }
  }

  @override
  void dispose() {
    _editTitleController.dispose();
    _editDescriptionController.dispose();
    super.dispose();
  }

  void delete({required Todo todo}) {
    ref.read(todoControllerProvider.notifier).deleteTodo(id: todo.id, context: context);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(todoControllerProvider.notifier).getTodos(context);
    return UnfocusOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Todo App"),
          actions: [
            IconButton(
              onPressed: () {
                context.go('/create-todo');
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: FutureBuilder(
              future: ref.watch(todoControllerProvider.notifier).getTodos(context),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error Loading Data"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (data != null) {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final Todo todo = data[index];

                        return Dismissible(
                          key: Key(todo.id),
                          onDismissed: (value) => delete(todo: todo),
                          child: GestureDetector(
                            onDoubleTap: () => _showBottomSheet(context, todo),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todo.title,
                                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      todo.description ?? "",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Error Loading Data"),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Todo todo) {
    _editTitleController.text = todo.title;
    _editDescriptionController.text = todo.description ?? "";

    bool isLoading = ref.watch(todoControllerProvider);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _editKey,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Update Todo',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Write a title",
                      labelText: "Title",
                    ),
                    controller: _editTitleController,
                    validator: RequiredValidator(errorText: "Title is Required"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      hintText: "Write a title",
                      labelText: "Description",
                    ),
                    controller: _editDescriptionController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => save(todo.id),
                    child: isLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
