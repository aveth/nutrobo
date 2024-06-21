import 'package:json_annotation/json_annotation.dart';
import 'package:nutrobo/features/profile/model/user_profile.dart';

part 'nutrobo_user.g.dart';

@JsonSerializable()
class NutroboUser {
  final String id;
  final List<String> threads;
  final UserProfile? profile;

  NutroboUser({
    required this.id,
    required this.threads,
    this.profile
  });

  factory NutroboUser.fromJson(Map<String, dynamic> json) => _$NutroboUserFromJson(json);
  Map<String, dynamic> toJson() => _$NutroboUserToJson(this);
}