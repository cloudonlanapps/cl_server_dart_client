/// User Manager operation result wrapper
///
/// All responses from the user_manager module use this result type.
/// Either contains a success message and data, or an error message.
class UserOperationResult<T> {
  UserOperationResult({
    this.success,
    this.error,
    this.data,
  });

  /// Success message from operation
  final String? success;

  /// Error message if operation failed
  final String? error;

  /// Result data (user, list of users, permissions, etc.)
  final T? data;

  /// Check if operation was successful
  bool get isSuccess => success != null && error == null;

  /// Check if operation failed
  bool get isError => error != null;

  /// Get success value or throw if error
  T get valueOrThrow {
    if (isError) {
      throw UserOperationException(error ?? 'Unknown error');
    }
    return data as T;
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'UserOperationResult.success($success)';
    } else {
      return 'UserOperationResult.error($error)';
    }
  }
}

/// Exception thrown when accessing valueOrThrow on error result
class UserOperationException implements Exception {
  UserOperationException(this.message);

  final String message;

  @override
  String toString() => 'UserOperationException: $message';
}
