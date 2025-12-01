import '../../core/exceptions.dart';
import '../../services/auth_service.dart';
import '../models/result_model.dart';

/// Command to update a user (partial update allowed)
class UpdateUserCommand {
  UpdateUserCommand(this._authService);

  final AuthService _authService;

  /// Execute update user operation
  ///
  /// [userId] - ID of user to update
  /// [password] - New password (optional)
  /// [permissions] - New permissions (optional)
  /// [isAdmin] - Update admin status (optional)
  /// [isActive] - Update active status (optional)
  ///
  /// Returns UserOperationResult with updated user or error
  Future<UserOperationResult<dynamic>> execute({
    required int userId,
    String? password,
    List<String>? permissions,
    bool? isAdmin,
    bool? isActive,
  }) async {
    try {
      final user = await _authService.updateUser(
        userId,
        password: password,
        permissions: permissions,
        isAdmin: isAdmin,
        isActive: isActive,
      );

      return UserOperationResult(
        success: 'User updated successfully',
        data: user,
      );
    } on PermissionException catch (e) {
      return UserOperationResult(
        error: 'Permission denied: ${e.message}',
      );
    } on ResourceNotFoundException catch (e) {
      return UserOperationResult(
        error: 'User not found: ${e.message}',
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
        error: 'Failed to update user: ${e.toString()}',
      );
    }
  }
}
