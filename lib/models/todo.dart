class Todo {
  final String id;
  final String title;
  final String? description;
  final DateTime? deadline;
  final DateTime? createdAt;
  Todo({
    required this.id,
    required this.title,
    this.description,
    this.deadline,
    this.createdAt,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? deadline,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['_id'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      deadline: map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, deadline: $deadline, createdAt: $createdAt)';
  }
}
