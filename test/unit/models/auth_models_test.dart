// ignore_for_file: avoid_redundant_argument_values, this  must be explicit

import 'package:cl_server_dart_client/cl_server_dart_client.dart';
import 'package:test/test.dart';

void main() {
  group('Auth Models Tests', () {
    group('User Model', () {
      final sampleUserJson = {
        'id': 1,
        'username': 'admin',
        'is_admin': true,
        'is_active': true,
        'created_at': '2024-01-15T10:30:00',
        'permissions': ['*'],
      };

      test('User.fromJson creates instance correctly', () {
        final user = User.fromJson(sampleUserJson);

        expect(user.id, 1);
        expect(user.username, 'admin');
        expect(user.isAdmin, true);
        expect(user.isActive, true);
        expect(user.permissions, ['*']);
      });

      test('User.fromMap creates instance correctly', () {
        final user = User.fromMap(sampleUserJson);

        expect(user.id, 1);
        expect(user.username, 'admin');
      });

      test('User.toJson serializes correctly', () {
        final user = User.fromJson(sampleUserJson);
        final json = user.toJson();

        expect(json['id'], 1);
        expect(json['username'], 'admin');
        expect(json['is_admin'], true);
      });

      test('User.toMap returns same as toJson', () {
        final user = User.fromJson(sampleUserJson);
        final json = user.toJson();
        final map = user.toMap();

        expect(map, json);
      });

      test('User.copyWith creates new instance with changes', () {
        final user = User.fromJson(sampleUserJson);
        final updated = user.copyWith(username: 'newadmin', isAdmin: false);

        expect(updated.id, user.id);
        expect(updated.username, 'newadmin');
        expect(updated.isAdmin, false);
        expect(updated.permissions, user.permissions);
      });

      test('User is immutable', () {
        final user = User.fromJson(sampleUserJson);
        expect(user, isA<User>());
      });
    });

    group('TokenResponse Model', () {
      final sampleTokenJson = {
        'access_token': 'eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9...',
        'token_type': 'bearer',
      };

      test('TokenResponse.fromJson creates instance correctly', () {
        final token = TokenResponse.fromJson(sampleTokenJson);

        expect(token.accessToken, 'eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9...');
        expect(token.tokenType, 'bearer');
      });

      test('TokenResponse.toJson serializes correctly', () {
        final token = TokenResponse.fromJson(sampleTokenJson);
        final json = token.toJson();

        expect(json['access_token'], token.accessToken);
        expect(json['token_type'], 'bearer');
      });

      test('TokenResponse.copyWith creates new instance', () {
        final token = TokenResponse.fromJson(sampleTokenJson);
        final updated = token.copyWith(tokenType: 'Bearer');

        expect(updated.accessToken, token.accessToken);
        expect(updated.tokenType, 'Bearer');
      });
    });

    group('PublicKeyResponse Model', () {
      final sampleKeyJson = {
        'public_key': '-----BEGIN PUBLIC KEY-----\nMFkwEwYH...',
        'algorithm': 'ES256',
      };

      test('PublicKeyResponse.fromJson creates instance correctly', () {
        final key = PublicKeyResponse.fromJson(sampleKeyJson);

        expect(key.publicKey, '-----BEGIN PUBLIC KEY-----\nMFkwEwYH...');
        expect(key.algorithm, 'ES256');
      });

      test('PublicKeyResponse.toJson serializes correctly', () {
        final key = PublicKeyResponse.fromJson(sampleKeyJson);
        final json = key.toJson();

        expect(json['public_key'], key.publicKey);
        expect(json['algorithm'], 'ES256');
      });

      test('PublicKeyResponse.copyWith creates new instance', () {
        final key = PublicKeyResponse.fromJson(sampleKeyJson);
        final updated = key.copyWith(algorithm: 'RS256');

        expect(updated.publicKey, key.publicKey);
        expect(updated.algorithm, 'RS256');
      });
    });

    group('UserCreateRequest Model', () {
      test('UserCreateRequest.toJson serializes correctly', () {
        const request = UserCreateRequest(
          username: 'newuser',
          password: 'secure123',
          isAdmin: false,
          permissions: ['read:data'],
        );

        final json = request.toJson();

        expect(json['username'], 'newuser');
        expect(json['password'], 'secure123');
        expect(json['is_admin'], false);
        expect(json['permissions'], ['read:data']);
      });

      test('UserCreateRequest.copyWith creates new instance', () {
        const request = UserCreateRequest(
          username: 'user1',
          password: 'pass123',
        );

        final updated = request.copyWith(isAdmin: true);

        expect(updated.username, 'user1');
        expect(updated.password, 'pass123');
        expect(updated.isAdmin, true);
      });
    });

    group('UserUpdateRequest Model', () {
      test('UserUpdateRequest.toJson omits null fields', () {
        const request = UserUpdateRequest(
          password: 'newpass',
          isAdmin: true,
        );

        final json = request.toJson();

        expect(json.containsKey('password'), true);
        expect(json.containsKey('is_admin'), true);
        expect(json.containsKey('permissions'), false);
        expect(json.containsKey('is_active'), false);
      });

      test('UserUpdateRequest.copyWith creates new instance', () {
        const request = UserUpdateRequest(
          password: 'oldpass',
        );

        final updated = request.copyWith(
          password: 'newpass',
          isActive: false,
        );

        expect(updated.password, 'newpass');
        expect(updated.isActive, false);
      });
    });
  });
}
