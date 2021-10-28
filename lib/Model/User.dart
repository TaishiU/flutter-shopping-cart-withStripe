import 'package:freezed_annotation/freezed_annotation.dart';

part 'User.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    @Default('') String userId,
    @Default('') String name,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
