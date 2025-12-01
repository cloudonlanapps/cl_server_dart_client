## 0.1.0

- Initial Phase 1 implementation with core client functionality
- Auth Service client with 9 endpoints for user management and authentication
- Store Service client with 11 endpoints for entity and collection management
- Compute Service client with 7 endpoints for job and worker management
- Immutable data models with manual serialization (fromJson, toJson, fromMap, toMap, copyWith)
- Custom exception hierarchy for proper error handling
- HTTP client wrapper with comprehensive error mapping
- 115 passing unit tests covering all services and models
- No code generation (build_runner) - manual implementation
- Stateless clients with manual token management
