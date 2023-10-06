// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      message: json['message'] as String,
      senderUsername: json['senderUsername'] as String,
      sentAt: DateTime.fromMillisecondsSinceEpoch(json['sentAt']),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'message': instance.message,
      'senderUsername': instance.senderUsername,
      'sentAt': instance.sentAt.toIso8601String(),
    };
