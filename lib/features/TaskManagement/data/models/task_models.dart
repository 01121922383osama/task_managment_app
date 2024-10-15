import 'package:hive/hive.dart';

part 'task_models.g.dart';

@HiveType(typeId: 0)
class TaskModels {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  DateTime createdAt;
  @HiveField(3)
  bool isCompleted;

  TaskModels({
    required this.id,
    required this.title,
    required this.createdAt,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  static TaskModels fromMap(Map<String, dynamic> map) {
    return TaskModels(
      id: map['id'],
      title: map['title'],
      createdAt: DateTime.parse(map['createdAt']),
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
