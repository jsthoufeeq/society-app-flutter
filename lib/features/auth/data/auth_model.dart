import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String token;
  const UserModel({required this.id, required this.token});

  @override
  List<Object?> get props => [id, token];
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String userId;
  final String societyId;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.societyId,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    accessToken:  json['access_token']  as String,
    refreshToken: json['refresh_token'] as String,
    userId:       json['user_id']       as String,
    societyId:    json['society_id']    as String,
  );
}
