// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      token: json['token'] as String? ?? "",
      image: json['image'] as String? ?? "",
      name: json['name'] as String? ?? "",
      position: json['position'] as String? ?? "",
      noOfTask: (json['no_of_task'] as num?)?.toInt() ?? 0,
      percentage: (json['percentage'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'image': instance.image,
      'name': instance.name,
      'position': instance.position,
      'no_of_task': instance.noOfTask,
      'percentage': instance.percentage,
    };
