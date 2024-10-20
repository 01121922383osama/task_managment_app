// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelsAdapter extends TypeAdapter<TaskModels> {
  @override
  final int typeId = 0;

  @override
  TaskModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModels(
      id: fields[0] as String,
      title: fields[1] as String,
      createdAt: fields[2] as DateTime,
      isCompleted: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModels obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
