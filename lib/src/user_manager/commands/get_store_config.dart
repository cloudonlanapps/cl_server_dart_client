import '../../core/exceptions.dart';
import '../../services/store_service.dart';
import '../models/result_model.dart';

/// Command to get store configuration
class GetStoreConfigCommand {
  GetStoreConfigCommand(this._storeService);

  final StoreService _storeService;

  /// Execute get store config operation
  ///
  /// Returns UserOperationResult with store config or error
  Future<UserOperationResult<dynamic>> execute() async {
    try {
      final config = await _storeService.getConfig();

      return UserOperationResult(
        success: 'Store config retrieved successfully',
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
        error: 'Failed to retrieve store config: ${e.toString()}',
      );
    }
  }
}
