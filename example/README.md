# CL Server User Manager CLI

A comprehensive command-line utility for managing users in CL Server with admin privileges. This example demonstrates how to use the `cl_server_dart_client` package to build production applications.

## Features

✨ **Admin Authentication** - Secure login as admin user with script-friendly options
👥 **User Management** - Create, read, update, and delete users with detailed control
🔐 **Admin-Only Operations** - Protected operations requiring admin privileges
📋 **Smart User Listing** - View utility-created users (default) or all users with filtering
🔒 **Store Configuration** - Manage read authentication and store settings
💻 **Interactive & Script Modes** - Both interactive menu and full automation support
🔄 **SessionManager Integration** - Automatic token management and refresh
🏷️ **User Prefixing** - Automatically prefix users created by this utility (default: t#)
🎯 **Permission Management** - View and manage user permissions with granular controls

## Getting Started

### Prerequisites

- Dart SDK 3.0.0 or higher
- CL Server services running locally (or configured URLs)
  - Auth Service (default: http://localhost:8000)
  - Store Service (default: http://localhost:8001)

### Installation

```bash
cd example
dart pub get
```

## Usage

### Interactive Mode

Run without arguments to open the interactive menu:

```bash
dart run bin/user_manager.dart
```

This will:
1. Prompt for admin username and password
2. Display an interactive menu with options
3. Guide you through each operation

### Command-Line Mode

#### List all users

```bash
dart run bin/user_manager.dart list-users
```

#### Create a new user

```bash
# Interactive input
dart run bin/user_manager.dart create-user

# With arguments
dart run bin/user_manager.dart create-user \
  --username newuser \
  --password mypassword \
  --email user@example.com
```

#### Update a user

```bash
# Interactive input
dart run bin/user_manager.dart update-user

# With arguments
dart run bin/user_manager.dart update-user \
  --id 123 \
  --password newpassword \
  --email newemail@example.com \
  --admin
```

#### Delete a user

```bash
# Interactive input (with confirmation)
dart run bin/user_manager.dart delete-user

# With arguments (requires confirmation)
dart run bin/user_manager.dart delete-user --id 123
```

#### Update store read authentication

```bash
dart run bin/user_manager.dart update-read-auth
```

### Command-Line Options

Global options for all commands:

```
--auth-url         Auth service URL (default: http://localhost:8000)
--store-url        Store service URL (default: http://localhost:8001)
--username         Admin username (will prompt if not provided)
--admin-user       Admin username (alias for --username, for scripts)
--password         Admin password (will prompt if not provided)
--admin-password   Admin password (alias for --password, for scripts)
--prefix           User prefix for this utility (default: t#)
--help             Show help message
```

## Examples

### Example 1: Create Multiple Users

```bash
# User 1
dart run bin/user_manager.dart create-user \
  --username alice \
  --password alice123 \
  --email alice@example.com

# User 2
dart run bin/user_manager.dart create-user \
  --username bob \
  --password bob123 \
  --email bob@example.com \
  --admin
```

### Example 2: List Users and Update One

```bash
# List to find user ID
dart run bin/user_manager.dart list-users

# Update user with ID 5
dart run bin/user_manager.dart update-user \
  --id 5 \
  --email newemail@company.com
```

### Example 3: Delete User with Confirmation

```bash
dart run bin/user_manager.dart delete-user --id 123
# Prompts: "Are you sure? (type YES to confirm): "
```

### Example 4: Custom Service URLs

```bash
dart run bin/user_manager.dart \
  --auth-url http://auth.example.com:8000 \
  --store-url http://store.example.com:8001 \
  list-users
```

### Example 5: Script/Automation Mode (No Interactive Prompts)

Using `--admin-user` and `--admin-password` for fully automated operations:

```bash
# Create users without any prompts
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password mypassword \
  create-user --username automation_user --password secure_pass

# List only utility-created users
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password mypassword \
  list-users

# List all users including system users
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password mypassword \
  list-users --all
```

### Example 6: User Prefix Management

Create users with custom prefix for organization:

```bash
# Create users with custom "automation_" prefix
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password mypassword \
  --prefix "automation_" \
  create-user --username bot --password botpass

# Users appear without prefix in listings (seamless)
# Internally stored as "automation_bot"
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password mypassword \
  list-users
# Shows: Username: bot (not automation_bot)
```

### Example 7: Get User Information and Permissions

```bash
# Get details of a specific user
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password mypassword \
  get-user --id 5

# Get user permissions
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password mypassword \
  get-user-permissions --id 5
```

### Example 8: Update User with Advanced Options

```bash
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password mypassword \
  update-user \
  --id 5 \
  --password newpassword \
  --permissions "read,write,delete" \
  --admin \
  --activate
```

## Architecture

This example demonstrates several key features of the `cl_server_dart_client` package:

### 1. Session Management
```dart
// Initialize and login
final sessionManager = SessionManager.initialize();
await sessionManager.login('admin', 'password', authBaseUrl: 'http://localhost:8000');

// Access authenticated services
final authService = await sessionManager.createAuthService();
```

### 2. Service Usage
```dart
// List users
final response = await authService.listUsers(skip: 0, limit: 100);
for (final user in response.items) {
  print('${user.id}: ${user.username}');
}
```

### 3. Error Handling
```dart
try {
  await sessionManager.login(username, password);
} on AuthException catch (e) {
  print('Login failed: $e');
} on NetworkException catch (e) {
  print('Network error: $e');
}
```

### 4. Async/Await Pattern
```dart
// All operations are async
await createUser(username, password);
await sessionManager.logout();
```

## Implementation Details

### User Prefixing System

This utility automatically prefixes users it creates to distinguish them from manually-created users:

- **Default Prefix**: `t#` (e.g., `t#alice`)
- **Custom Prefix**: Use `--prefix` to set a different prefix
- **Seamless Display**: Prefixes are transparent to users - they see `alice`, not `t#alice`
- **Recognition**: Utility-created users are marked with `*` in listings

#### How It Works

```
User Input:       alice
Stored as:        t#alice        (prefixed internally)
Displayed as:     alice          (prefix removed)
Default List:     Shows only utility-created users (with t# prefix)
--all Flag:       Shows all users, marks utility-created with *
```

### User Listing Behavior

- **Default**: Shows only users created by this utility
- **With --all flag**: Shows all users in the system
- **Marking**: Utility-created users are marked with `*` for easy identification

### Command Structure

All commands follow this pattern:

```bash
dart run user_manager.dart [global-options] <command> [command-options]
```

Where:
- **Global Options**: `--admin-user`, `--admin-password`, `--prefix`, `--auth-url`, `--store-url`
- **Commands**: `create-user`, `get-user`, `list-users`, `update-user`, `delete-user`, `get-user-permissions`, `get-store-config`, `update-read-auth`
- **Command Options**: Vary by command (e.g., `--username`, `--password`, `--id`, `--admin`, etc.)

### Adding New Operations

To extend the utility with new operations:

1. Create a handler function and command function
2. Add case to the switch statement in `main()`
3. Add to `knownCommands` list for proper argument parsing
4. Add to interactive menu in `showInteractiveMenu()` if needed
5. Update help text in `printHelp()`

Example:
```dart
case 'my-command':
  await myCommandHandler(allRest.skip(1).toList());

// In handler:
Future<void> myCommandHandler(List<String> args) async {
  try {
    final result = await authService.someOperation();
    print('✓ Success: $result');
  } catch (e) {
    print('✗ Error: $e');
  }
}
```

## Script and Automation Usage

The utility is designed for both interactive and automated use:

### Interactive Mode
- Prompts for credentials if not provided
- Hides password input from terminal
- Perfect for manual administration

### Script/Automation Mode
- Use `--admin-user` and `--admin-password` for credentials
- No interactive prompts - suitable for cron jobs, CI/CD, orchestration
- All output is deterministic and parseable
- Exit codes indicate success/failure

Example CI/CD pipeline:
```bash
#!/bin/bash
set -e

# Setup environment
ADMIN_USER="ci_user"
ADMIN_PASS="${CI_ADMIN_PASSWORD}"  # From environment variable
AUTH_URL="${CL_AUTH_URL:-http://localhost:8000}"

# Create batch of users
dart run bin/user_manager.dart \
  --admin-user "$ADMIN_USER" \
  --admin-password "$ADMIN_PASS" \
  --auth-url "$AUTH_URL" \
  create-user --username user1 --password pass1

# List to verify
dart run bin/user_manager.dart \
  --admin-user "$ADMIN_USER" \
  --admin-password "$ADMIN_PASS" \
  --auth-url "$AUTH_URL" \
  list-users
```

## Security Considerations

⚠️ **Password Input** - Passwords are hidden from terminal echo when prompted interactively

⚠️ **Script Credentials** - For automated use, pass credentials via environment variables or secure vaults (never hardcode)

⚠️ **Token Management** - SessionManager automatically handles token refresh and storage

⚠️ **Admin-Only Operations** - All operations are restricted to authenticated admin users

⚠️ **User Prefixing** - Internal prefix prevents accidental name conflicts with other user creation methods

⚠️ **Error Messages** - Detailed error messages are shown for debugging (consider filtering for production logs)

## Troubleshooting

### Connection Errors

```
Error: Connection refused at http://localhost:8000
```

Solution: Ensure CL Server services are running and accessible at the specified URLs.

```bash
dart run bin/user_manager.dart \
  --auth-url http://your-server:8000 \
  list-users
```

### Authentication Errors

```
Error: 401 - Unauthorized
```

Solution: Verify admin credentials are correct:

```bash
dart run bin/user_manager.dart \
  --username admin \
  --password correctpassword
```

### Service Not Found

```
Error: 404 - Not Found
```

Solution: Ensure endpoints are implemented on the server and the client library is up to date.

## Development

### Run Tests

```bash
cd ..
dart test
```

### Build Release

```bash
dart compile exe bin/user_manager.dart -o user_manager
./user_manager
```

## Contributing

Enhancements and improvements are welcome! Areas for expansion:

- Batch operations (create multiple users from CSV)
- User role management
- Audit logging
- Configuration file support
- Export/import user data

## License

Same as the parent `cl_server_dart_client` package.

## Resources

- [cl_server_dart_client Documentation](../README.md)
- [CL Server API Documentation](http://localhost:8000/docs)
- [Dart Language Guide](https://dart.dev/guides)
