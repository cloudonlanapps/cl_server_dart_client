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
    super.message = 'Invalid user data',
    super.statusCode = 422,
  });
}

/// User not found (404)
class UserNotFoundException extends UserManagerException {
  UserNotFoundException({
    super.message = 'User not found',
    super.statusCode = 404,
  });
}

/// Operation not allowed
class OperationNotAllowedException extends UserManagerException {
  OperationNotAllowedException({
    super.message = 'Operation not allowed',
  }) : super(statusCode: null);
}
