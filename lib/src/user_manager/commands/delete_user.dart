import '../../core/exceptions.dart';
import '../../services/auth_service.dart';
import '../models/result_model.dart';

/// Command to delete a user
class DeleteUserCommand {
  DeleteUserCommand(this._authService);

  final AuthService _authService;

  /// Execute delete user operation
  ///
  /// [userId] - ID of user to delete
  ///
  /// Returns UserOperationResult with success message or error
  Future<UserOperationResult<void>> execute({
    required int userId,
  }) async {
    try {
      await _authService.deleteUser(userId);

      return UserOperationResult(
        success: 'User deleted successfully',
        data: null,
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
        error: 'Failed to delete user: ${e.toString()}',
      );
    }
  }
}
