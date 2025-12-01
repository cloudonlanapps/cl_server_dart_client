import '../../core/exceptions.dart';
import '../../services/auth_service.dart';
import '../models/result_model.dart';

/// Command to retrieve a single user by ID
class GetUserCommand {
  GetUserCommand(this._authService);

  final AuthService _authService;

  /// Execute get user operation
  ///
  /// [userId] - ID of user to retrieve
  ///
  /// Returns UserOperationResult with user data or error
  Future<UserOperationResult<dynamic>> execute({
    required int userId,
  }) async {
    try {
      final user = await _authService.getUser(userId);

      return UserOperationResult(
        success: 'User retrieved successfully',
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
    } on CLServerException catch (e) {
      return UserOperationResult(
        error: 'Server error: ${e.message}',
      );
    } catch (e) {
      return UserOperationResult(
        error: 'Failed to retrieve user: ${e.toString()}',
      );
    }
  }
}
