# CL Server Dart Client

A comprehensive Dart client library for interacting with CL Server microservices. This package provides type-safe clients for three core services:

- **Authentication Service** (Port 8000) - User management and token generation
- **Store Service** (Port 8001) - Entity and collection management
- **Compute Service** (Port 8002) - Job and worker management

## Features

- ✨ Three fully-featured service clients (Auth, Store, Compute)
- 🔒 Custom exception hierarchy for comprehensive error handling
- 📦 Immutable data models with full serialization support
- 🧪 115+ unit tests with excellent coverage
- 🎯 Manual token management (stateless clients)
- 📝 No code generation required (manual implementation)
- 🚀 Type-safe async/await API
- 🔌 HTTP client wrapper with intelligent error mapping

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  cl_server_dart_client: ^0.1.0
```

## Getting started

### Basic Usage

```dart
import 'package:cl_server_dart_client/cl_server_dart_client.dart';

// Create auth service client
final authService = AuthService();

// Login to get token
try {
  final token = await authService.generateToken(
    username: 'admin',
    password: 'admin',
  );

  // Use token with store service
  final storeService = StoreService(token: token.accessToken);

  // List entities
  final entities = await storeService.listEntities();
  print('Found ${entities.items.length} entities');
} on AuthException catch (e) {
  print('Authentication failed: $e');
} on ServerException catch (e) {
  print('Server error: $e');
}
```

### Service Clients

#### AuthService

Manage users and generate authentication tokens.

```dart
final authService = AuthService(baseUrl: 'http://localhost:8000');

// Generate token
final token = await authService.generateToken(
  username: 'user',
  password: 'password',
);

// Get current user
final user = await authService.getCurrentUser();

// List all users (admin only)
final users = await authService.listUsers(skip: 0, limit: 100);
```

#### StoreService

Manage entities and collections.

```dart
final storeService = StoreService(
  baseUrl: 'http://localhost:8001',
  token: authToken,
);

// List entities with pagination
final response = await storeService.listEntities(
  page: 1,
  pageSize: 20,
);

// Create entity
final entity = await storeService.createEntity(
  isCollection: false,
  label: 'My File',
  description: 'A test file',
);

// Get entity versions
final versions = await storeService.getVersions(entity.id);
```

#### ComputeService

Manage compute jobs and workers.

```dart
final computeService = ComputeService(
  baseUrl: 'http://localhost:8002',
  token: authToken,
);

// Create job
final job = await computeService.createJob(
  taskType: 'image_resize',
  metadata: {'width': 800, 'height': 600},
);

// Get job status
final status = await computeService.getJobStatus(job.jobId);

// List workers
final workers = await computeService.listWorkers();
```

## Error Handling

The client uses a custom exception hierarchy for clear error handling:

- `AuthException` - Authentication failed (401)
- `PermissionException` - Insufficient permissions (403)
- `ValidationException` - Invalid request data (422)
- `ResourceNotFoundException` - Resource not found (404)
- `ServerException` - Server error (5xx)
- `NetworkException` - Network/connection errors

```dart
try {
  final user = await authService.getUser(999);
} on ResourceNotFoundException catch (e) {
  print('User not found: $e');
} on AuthException catch (e) {
  print('Not authenticated: $e');
} on CLServerException catch (e) {
  print('Client error: $e');
}
```

## Data Models

All models are immutable and include full serialization support:

```dart
// Models support fromJson/toJson
final json = {'id': 1, 'username': 'admin'};
final user = User.fromJson(json);

// Models support fromMap/toMap
final map = user.toMap();

// Models support copyWith for immutable updates
final updatedUser = user.copyWith(username: 'newadmin');
```

## Token Management

This library does not implement token caching or automatic refresh. Callers are responsible for:

1. Generating tokens via `AuthService.generateToken()`
2. Storing tokens securely
3. Refreshing tokens when needed
4. Passing tokens to service constructors

Example with a simple token manager:

```dart
class TokenManager {
  String? _token;

  Future<String> getValidToken() async {
    if (_token == null) {
      final response = await AuthService().generateToken(
        username: 'user',
        password: 'pass',
      );
      _token = response.accessToken;
    }
    return _token!;
  }
}
```

## Testing

The package includes comprehensive unit tests (115+ tests) covering:

- All service clients and their endpoints
- Model serialization/deserialization
- Exception handling
- HTTP client error mapping

Run tests with:

```bash
dart test
```

## Known Limitations

- **No automatic token refresh**: Token refresh must be implemented by the calling application
- **No built-in caching**: Response caching should be implemented at the application level
- **Integration tests deferred**: Full integration tests with running services are planned for Phase 2

## Code Quality

This package adheres to the `very_good_analysis` lint rules and passes all linting checks without warnings. The code is 100% documented with no public members lacking documentation comments.

## Additional Information

### Architecture

The library follows a layered architecture:

- **Core Layer**: HTTP client, exceptions, base models
- **Models Layer**: Immutable data classes with serialization
- **Services Layer**: Service clients wrapping API endpoints

Each service is independent and can be used separately.

### Contributing

This is Phase 1 of the CL Server Dart Client project. Future phases will include:
- Integration tests with running services
- Higher-level integration modules
- Request/response caching
- Advanced error recovery strategies

### Version

Current version: **0.1.0** (Phase 1 - Core Client Implementation)
