import 'package:json_annotation/json_annotation.dart';
part 'message_model.g.dart';

@JsonSerializable()
class Message {
  final String message, senderUsername;
  final DateTime sentAt;

  Message(
      {required this.message,
      required this.senderUsername,
      required this.sentAt});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
