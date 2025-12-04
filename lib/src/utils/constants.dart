/// Auth Service Endpoints
class AuthServiceEndpoints {
  static const String health = '/';
  static const String generateToken = '/auth/token';
  static const String refreshToken = '/auth/token/refresh';
  static const String getPublicKey = '/auth/public-key';
  static const String getCurrentUser = '/users/me';
  static const String listUsers = '/users/';
  static const String getUser = '/users/{user_id}';
  static const String createUser = '/users/';
  static const String updateUser = '/users/{user_id}';
  static const String deleteUser = '/users/{user_id}';
}

/// Store Service Endpoints
class StoreServiceEndpoints {
  static const String health = '/';
  static const String listEntities = '/entities';
  static const String createEntity = '/entities';
  static const String getEntity = '/entities/{entity_id}';
  static const String updateEntity = '/entities/{entity_id}';
  static const String patchEntity = '/entities/{entity_id}';
  static const String deleteEntity = '/entities/{entity_id}';
  static const String deleteCollection = '/entities';
  static const String getVersions = '/entities/{entity_id}/versions';
  static const String getConfig = '/admin/config';
  static const String updateReadAuthConfig = '/admin/config/read-auth';
}

/// Compute Service Endpoints
class ComputeServiceEndpoints {
  static const String createJob = '/compute/jobs/{task_type}';
  static const String getJobStatus = '/compute/jobs/{job_id}';
  static const String deleteJob = '/compute/jobs/{job_id}';
  static const String getCapabilities = '/compute/capabilities';
  static const String getStorageSize = '/admin/compute/jobs/storage/size';
  static const String cleanupOldJobs = '/admin/compute/jobs/cleanup';
}

/// HTTP Headers
class HttpHeaders {
  static const String contentType = 'content-type';
  static const String authorization = 'authorization';
  static const String applicationJson = 'application/json';
  static const String applicationFormUrlEncoded =
      'application/x-www-form-urlencoded';
}

/// Common Query Parameters
class QueryParameters {
  static const String page = 'page';
  static const String pageSize = 'page_size';
  static const String skip = 'skip';
  static const String limit = 'limit';
  static const String version = 'version';
  static const String searchQuery = 'search_query';
  static const String days = 'days';
}
