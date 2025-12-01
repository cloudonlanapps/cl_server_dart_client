import 'package:meta/meta.dart';

/// User model
@immutable
class User {
  const User({
    required this.id,
    required this.username,
    required this.isAdmin,
    required this.isActive,
    required this.createdAt,
    required this.permissions,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      isAdmin: json['is_admin'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] is String
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      permissions: List<String>.from(
        (json['permissions'] as List<dynamic>? ?? []).cast<String>(),
      ),
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User.fromJson(map);
  }
  final int id;
  final String username;
  final bool isAdmin;
  final bool isActive;
  final DateTime createdAt;
  final List<String> permissions;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'is_admin': isAdmin,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'permissions': permissions,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  User copyWith({
    int? id,
    String? username,
    bool? isAdmin,
    bool? isActive,
    DateTime? createdAt,
    List<String>? permissions,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      isAdmin: isAdmin ?? this.isAdmin,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      permissions: permissions ?? this.permissions,
    );
  }
}

/// Token response model
@immutable
class TokenResponse {
  const TokenResponse({
    required this.accessToken,
    required this.tokenType,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
    );
  }

  factory TokenResponse.fromMap(Map<String, dynamic> map) {
    return TokenResponse.fromJson(map);
  }
  final String accessToken;
  final String tokenType;

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  TokenResponse copyWith({
    String? accessToken,
    String? tokenType,
  }) {
    return TokenResponse(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
    );
  }
}

/// Public key response model
@immutable
class PublicKeyResponse {
  const PublicKeyResponse({
    required this.publicKey,
    required this.algorithm,
  });

  factory PublicKeyResponse.fromJson(Map<String, dynamic> json) {
    return PublicKeyResponse(
      publicKey: json['public_key'] as String,
      algorithm: json['algorithm'] as String? ?? 'ES256',
    );
  }

  factory PublicKeyResponse.fromMap(Map<String, dynamic> map) {
    return PublicKeyResponse.fromJson(map);
  }
  final String publicKey;
  final String algorithm;

  Map<String, dynamic> toJson() {
    return {
      'public_key': publicKey,
      'algorithm': algorithm,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  PublicKeyResponse copyWith({
    String? publicKey,
    String? algorithm,
  }) {
    return PublicKeyResponse(
      publicKey: publicKey ?? this.publicKey,
      algorithm: algorithm ?? this.algorithm,
    );
  }
}

/// User creation request model
@immutable
class UserCreateRequest {
  const UserCreateRequest({
    required this.username,
    required this.password,
    this.isAdmin = false,
    this.permissions = const [],
  });

  factory UserCreateRequest.fromJson(Map<String, dynamic> json) {
    return UserCreateRequest(
      username: json['username'] as String,
      password: json['password'] as String,
      isAdmin: json['is_admin'] as bool? ?? false,
      permissions: List<String>.from(
        (json['permissions'] as List<dynamic>? ?? []).cast<String>(),
      ),
    );
  }

  factory UserCreateRequest.fromMap(Map<String, dynamic> map) {
    return UserCreateRequest.fromJson(map);
  }
  final String username;
  final String password;
  final bool isAdmin;
  final List<String> permissions;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'is_admin': isAdmin,
      'permissions': permissions,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  UserCreateRequest copyWith({
    String? username,
    String? password,
    bool? isAdmin,
    List<String>? permissions,
  }) {
    return UserCreateRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      isAdmin: isAdmin ?? this.isAdmin,
      permissions: permissions ?? this.permissions,
    );
  }
}

/// User update request model
@immutable
class UserUpdateRequest {
  const UserUpdateRequest({
    this.password,
    this.permissions,
    this.isActive,
    this.isAdmin,
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) {
    return UserUpdateRequest(
      password: json['password'] as String?,
      permissions: json['permissions'] != null
          ? List<String>.from(
              (json['permissions'] as List<dynamic>).cast<String>(),
            )
          : null,
      isActive: json['is_active'] as bool?,
      isAdmin: json['is_admin'] as bool?,
    );
  }

  factory UserUpdateRequest.fromMap(Map<String, dynamic> map) {
    return UserUpdateRequest.fromJson(map);
  }
  final String? password;
  final List<String>? permissions;
  final bool? isActive;
  final bool? isAdmin;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (password != null) json['password'] = password;
    if (permissions != null) json['permissions'] = permissions;
    if (isActive != null) json['is_active'] = isActive;
    if (isAdmin != null) json['is_admin'] = isAdmin;
    return json;
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  UserUpdateRequest copyWith({
    String? password,
    List<String>? permissions,
    bool? isActive,
    bool? isAdmin,
  }) {
    return UserUpdateRequest(
      password: password ?? this.password,
      permissions: permissions ?? this.permissions,
      isActive: isActive ?? this.isActive,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
