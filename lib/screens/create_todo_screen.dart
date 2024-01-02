import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controllers/todo_controller.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/widgets/unfocus_ontap.dart';

class CreateToDoScreen extends ConsumerStatefulWidget {
  const CreateToDoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateToDoScreenState();
}

class _CreateToDoScreenState extends ConsumerState<CreateToDoScreen> {
  final _titleController = TextEditingController();
  final _desctriptionController = TextEditingController();
  final _deadlineController = TextEditingController();

  DateTime? deadline;

  final _createKey = GlobalKey<FormState>();

  final format = DateFormat("dd-MM-yyyy");

  @override
  void dispose() {
    _titleController.dispose();
    _desctriptionController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  void save() async {
    if (_createKey.currentState != null) {
      if (_createKey.currentState!.validate()) {
        ref.read(todoControllerProvider.notifier).createTodo(
              title: _titleController.text.trim(),
              description: _desctriptionController.text.trim(),
              deadline: deadline?.toIso8601String(),
              context: context,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool loading = ref.watch(todoControllerProvider);
    return UnfocusOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Todo"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Form(
              key: _createKey,
              child: ListView(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Write a title",
                      labelText: "Title",
                    ),
                    controller: _titleController,
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
                    controller: _desctriptionController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  DateTimeField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Deadline",
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    onChanged: (value) {
                      deadline = value;
                    },
                    controller: _deadlineController,
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: save,
                    child: loading
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
        ),
      ),
    );
  }
}
