// ignore_for_file: avoid_redundant_argument_values, this is for testing

import 'package:cl_server_dart_client/cl_server_dart_client.dart';
import 'package:test/test.dart';

void main() {
  group('Exception Classes Tests', () {
    test('AuthException has correct message and status code', () {
      final exception = AuthException(
        message: 'Invalid credentials',
        statusCode: 401,
      );

      expect(exception.message, 'Invalid credentials');
      expect(exception.statusCode, 401);
    });

    test('PermissionException has correct message and status code', () {
      final exception = PermissionException(
        message: 'Not enough permissions',
        statusCode: 403,
      );

      expect(exception.message, 'Not enough permissions');
      expect(exception.statusCode, 403);
    });

    test('ValidationException has correct message and details', () {
      final details = {'field': 'username', 'error': 'required'};
      final exception = ValidationException(
        message: 'Validation failed',
        statusCode: 422,
        details: details,
      );

      expect(exception.message, 'Validation failed');
      expect(exception.statusCode, 422);
      expect(exception.details, details);
    });

    test('ResourceNotFoundException has correct message and status code', () {
      final exception = ResourceNotFoundException(
        message: 'User not found',
        statusCode: 404,
      );

      expect(exception.message, 'User not found');
      expect(exception.statusCode, 404);
    });

    test('ServerException has correct message and status code', () {
      final exception = ServerException(
        message: 'Internal server error',
        statusCode: 500,
      );

      expect(exception.message, 'Internal server error');
      expect(exception.statusCode, 500);
    });

    test('NetworkException has correct message', () {
      final exception = NetworkException(
        message: 'Connection timeout',
      );

      expect(exception.message, 'Connection timeout');
    });

    test('Exception toString returns message', () {
      final exception = AuthException(message: 'Test error');
      expect(exception.toString(), 'Test error');
    });
  });
}
