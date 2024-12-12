// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

@freezed
class TaskModel with _$TaskModel {
    const factory TaskModel({
        @JsonKey(name: "total_tasks") @Default(0)
        int totalTasks,
        @JsonKey(name: "pending_tasks")@Default(0)
        int pendingTasks,
        @JsonKey(name: "data")@Default([])
        List<TaskData> data,
    }) = _TaskModel;

    factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}

@freezed
class TaskData with _$TaskData {
    const factory TaskData({
        @JsonKey(name: "id")@Default(0)
        int id,
        @JsonKey(name: "name")@Default("")
        String name,
        @JsonKey(name: "description")@Default("")
        String description,
        @JsonKey(name: "percentage")@Default(0)
        int percentage,
        @JsonKey(name: "status")@Default("")
        String status,
           @JsonKey(name: "deadline")@Default("")
        String deadline,
    }) = _TaskData;

    factory TaskData.fromJson(Map<String, dynamic> json) => _$TaskDataFromJson(json);
}
