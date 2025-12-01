/// Base exception for user manager operations
abstract class UserManagerException implements Exception {
  UserManagerException({
    required this.message,
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

/// Invalid user data (validation error)
class InvalidUserException extends UserManagerException {
  InvalidUserException({
    String message = 'Invalid user data',
    int? statusCode = 422,
  }) : super(message: message, statusCode: statusCode);
}

/// User not found (404)
class UserNotFoundException extends UserManagerException {
  UserNotFoundException({
    String message = 'User not found',
    int? statusCode = 404,
  }) : super(message: message, statusCode: statusCode);
}

/// Operation not allowed
class OperationNotAllowedException extends UserManagerException {
  OperationNotAllowedException({
    String message = 'Operation not allowed',
  }) : super(message: message, statusCode: null);
}
