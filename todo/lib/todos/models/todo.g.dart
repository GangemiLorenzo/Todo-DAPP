// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: BigInt.parse(json['id'] as String),
      owner: json['owner'] as String,
      text: json['text'] as String,
      isDone: json['isDone'] as bool,
      color: json['color'] as String,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id.toString(),
      'owner': instance.owner,
      'text': instance.text,
      'isDone': instance.isDone,
      'color': instance.color,
    };
