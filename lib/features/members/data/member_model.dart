import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String email;
  @JsonKey(name: 'flat_number') final String flatNumber;
  final String role; // 'admin' | 'secretary' | 'member'
  @JsonKey(name: 'society_id') final String societyId;
  @JsonKey(name: 'family_id')  final String? familyId;
  @JsonKey(name: 'created_at') final DateTime createdAt;
  @JsonKey(name: 'is_active')  final bool isActive;

  const MemberModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.flatNumber,
    required this.role,
    required this.societyId,
    this.familyId,
    required this.createdAt,
    required this.isActive,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);
  Map<String, dynamic> toJson() => _$MemberModelToJson(this);

  @override
  List<Object?> get props => [id, name, flatNumber, societyId];
}

@JsonSerializable()
class FamilyModel extends Equatable {
  final String id;
  @JsonKey(name: 'flat_number') final String flatNumber;
  final List<MemberModel> members;
  @JsonKey(name: 'society_id') final String societyId;

  const FamilyModel({
    required this.id,
    required this.flatNumber,
    required this.members,
    required this.societyId,
  });

  factory FamilyModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyModelFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyModelToJson(this);

  @override
  List<Object?> get props => [id, flatNumber];
}
