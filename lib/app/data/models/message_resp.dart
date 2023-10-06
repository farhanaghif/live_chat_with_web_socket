import 'package:json_annotation/json_annotation.dart';
import 'package:neumedira_farhan_test/app/data/models/message_model.dart';
part 'message_resp.g.dart';

@JsonSerializable()
class MessageResp {
  final String status, message;
  final List<Message> result;

  MessageResp(
      {required this.message, required this.status, required this.result});

  factory MessageResp.fromJson(Map<String, dynamic> json) =>
      _$MessageRespFromJson(json);

  Map<String, dynamic> toJson() => _$MessageRespToJson(this);
}
