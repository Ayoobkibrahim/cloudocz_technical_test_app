// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      totalTasks: (json['total_tasks'] as num?)?.toInt() ?? 0,
      pendingTasks: (json['pending_tasks'] as num?)?.toInt() ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => TaskData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'total_tasks': instance.totalTasks,
      'pending_tasks': instance.pendingTasks,
      'data': instance.data,
    };

_$TaskDataImpl _$$TaskDataImplFromJson(Map<String, dynamic> json) =>
    _$TaskDataImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      percentage: (json['percentage'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? "",
      deadline: json['deadline'] as String? ?? "",
    );

Map<String, dynamic> _$$TaskDataImplToJson(_$TaskDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'percentage': instance.percentage,
      'status': instance.status,
      'deadline': instance.deadline,
    };
