import 'package:json_annotation/json_annotation.dart';
import 'package:nutrobo/features/chat/model/message.dart';

part 'thread.g.dart';

@JsonSerializable()
class Thread {
  final String id;
  final List<Message> messages;

  Thread({required this.id, required this.messages});

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);
  Map<String, dynamic> toJson() => _$ThreadToJson(this);
}