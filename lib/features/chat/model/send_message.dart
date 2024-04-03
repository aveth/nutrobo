import 'package:json_annotation/json_annotation.dart';

part 'send_message.g.dart';

@JsonSerializable()
class SendMessage {
  final String threadId;
  final String content;
  final Map<String, String>? data;

  SendMessage({
    required this.threadId,
    required this.content,
    this.data
  });

  factory SendMessage.fromJson(Map<String, dynamic> json) => _$SendMessageFromJson(json);
  Map<String, dynamic> toJson() => _$SendMessageToJson(this);

}