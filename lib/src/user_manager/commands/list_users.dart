import '../../core/exceptions.dart';
import '../../services/auth_service.dart';
import '../models/result_model.dart';
import '../models/user_filter.dart';
import '../utils/user_prefix_utils.dart';

/// Command to list users with filtering support
class ListUsersCommand {
  ListUsersCommand(this._authService, this._prefix);

  final AuthService _authService;
  final String _prefix;

  /// Execute list users operation
  ///
  /// [options] - Filtering and pagination options
  ///
  /// Returns UserOperationResult with list of users or error
  Future<UserOperationResult<dynamic>> execute({
    required UserListOptions options,
  }) async {
    try {
      final users = await _authService.listUsers(
        skip: options.skip,
        limit: options.limit,
      );

      // Filter users based on options
      final displayedUsers = options.showAll
          ? users
          : users.where((u) {
              return UserPrefixUtils.isUtilityCreatedUser(
                u.username,
                _prefix,
              );
            }).toList();

      return UserOperationResult(
        success: 'Listed ${displayedUsers.length} users',
        data: displayedUsers,
      );
    } on PermissionException catch (e) {
      return UserOperationResult(
        error: 'Permission denied: ${e.message}',
      );
    } on CLServerException catch (e) {
      return UserOperationResult(
        error: 'Server error: ${e.message}',
      );
    } on Exception catch (e) {
      return UserOperationResult(
        error: 'Failed to list users: $e',
      );
    }
  }
}
