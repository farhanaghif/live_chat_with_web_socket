// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResp _$MessageRespFromJson(Map<String, dynamic> json) => MessageResp(
      message: json['message'] as String,
      status: json['status'] as String,
      result: (json['result'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageRespToJson(MessageResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result,
    };
