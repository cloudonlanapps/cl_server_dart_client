import '../../core/exceptions.dart';
import '../../services/auth_service.dart';
import '../models/result_model.dart';
import '../utils/user_prefix_utils.dart';

/// Command to create a new user
class CreateUserCommand {
  CreateUserCommand(this._authService, this._prefix);

  final AuthService _authService;
  final String _prefix;

  /// Execute create user operation
  ///
  /// [username] - Username for new user (will be prefixed internally)
  /// [password] - User password
  /// [isAdmin] - Whether user should be admin (default: false)
  /// [permissions] - Optional list of permissions
  ///
  /// Returns UserOperationResult with created user or error
  Future<UserOperationResult<dynamic>> execute({
    required String username,
    required String password,
    bool isAdmin = false,
    List<String>? permissions,
  }) async {
    try {
      // Add prefix to username for internal storage
      final prefixedUsername = UserPrefixUtils.addPrefix(username, _prefix);

      final user = await _authService.createUser(
        username: prefixedUsername,
        password: password,
        isAdmin: isAdmin,
        permissions: permissions ?? [],
      );

      return UserOperationResult(
        success: 'User created successfully',
        data: user,
      );
    } on PermissionException catch (e) {
      return UserOperationResult(
        error: 'Permission denied: ${e.message}',
      );
    } on ValidationException catch (e) {
      return UserOperationResult(
        error: 'Validation failed: ${e.message}',
      );
    } on CLServerException catch (e) {
      return UserOperationResult(
        error: 'Server error: ${e.message}',
      );
    } on Exception catch (e) {
      return UserOperationResult(
        error: 'Failed to create user: ${e.toString()}',
      );
    }
  }
}
