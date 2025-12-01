import '../../core/exceptions.dart';
import '../../services/store_service.dart';
import '../models/result_model.dart';

/// Command to update store read authentication configuration
class UpdateReadAuthCommand {
  UpdateReadAuthCommand(this._storeService);

  final StoreService _storeService;

  /// Execute update read auth operation
  ///
  /// [enabled] - Whether to enable read authentication
  ///
  /// Returns UserOperationResult with updated config or error
  Future<UserOperationResult<dynamic>> execute({
    required bool enabled,
  }) async {
    try {
      final config = await _storeService.updateReadAuthConfig(enabled: enabled);

      final status = enabled ? 'enabled' : 'disabled';
      return UserOperationResult(
        success: 'Read authentication has been $status',
        data: config,
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
        error: 'Failed to update read auth config: ${e.toString()}',
      );
    }
  }
}
