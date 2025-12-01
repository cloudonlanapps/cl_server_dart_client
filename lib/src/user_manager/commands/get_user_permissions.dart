import '../../core/exceptions.dart';
import '../../services/auth_service.dart';
import '../models/result_model.dart';

/// Command to get user permissions
class GetUserPermissionsCommand {
  GetUserPermissionsCommand(this._authService);

  final AuthService _authService;

  /// Execute get user permissions operation
  ///
  /// [userId] - ID of user to get permissions for
  ///
  /// Returns UserOperationResult with list of permissions or error
  Future<UserOperationResult<dynamic>> execute({
    required int userId,
  }) async {
    try {
      final user = await _authService.getUser(userId);

      return UserOperationResult(
        success: 'Permissions retrieved successfully',
        data: user.permissions,
      );
    } on PermissionException catch (e) {
      return UserOperationResult(
        error: 'Permission denied: ${e.message}',
      );
    } on ResourceNotFoundException catch (e) {
      return UserOperationResult(
        error: 'User not found: ${e.message}',
      );
    } on CLServerException catch (e) {
      return UserOperationResult(
        error: 'Server error: ${e.message}',
      );
    } on Exception catch (e) {
      return UserOperationResult(
        error: 'Failed to retrieve permissions: ${e.toString()}',
      );
    }
  }
}
