// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@freezed
class UserModel with _$UserModel {
    const factory UserModel({
        @JsonKey(name: "token")@Default("")
        String token,
        @JsonKey(name: "image")@Default("")
        String image,
        @JsonKey(name: "name")@Default("")
        String name,
        @JsonKey(name: "position")@Default("")
        String position,
        @JsonKey(name: "no_of_task")@Default(0)
        int noOfTask,
        @JsonKey(name: "percentage")@Default(0)
        int percentage,
    }) = _UserModel;

    factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
