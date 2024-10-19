import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task_models.g.dart';

@HiveType(typeId: 0)
class TaskModels extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final DateTime createdAt;
  @HiveField(3)
  final bool isCompleted;

  TaskModels copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return TaskModels(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  const TaskModels({
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

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        isCompleted,
      ];
}
