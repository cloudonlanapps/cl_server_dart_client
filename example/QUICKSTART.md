# Quick Start Guide - User Manager CLI

## Installation & Setup

```bash
cd example
dart pub get
```

## Run Examples

### List All Users

```bash
echo -e "admin\nadmin" | dart run bin/user_manager.dart list-users
```

Output:
```
🔐 Logging in as admin...
✓ Logged in successfully as: admin

📋 Fetching users...

======================================================================
All Users
======================================================================
ID    | Username             | Status          | Admin
----------------------------------------------------------------------
1     | admin                | ✓ Active        | ✓ Yes
2     | testuser_17643146353 | ✓ Active        | No
...
----------------------------------------------------------------------
Total: 11 users
```

### Interactive Mode

```bash
dart run bin/user_manager.dart
```

Then enter admin credentials when prompted:
```
Admin Username: admin
Admin Password: ****
```

You'll see a menu with options:
```
==================================================
CL Server User Manager - Admin Dashboard
==================================================
Logged in as: admin

User Management:
  1. Create User
  2. Get User Details
  3. List Users
  4. Update User
  5. Delete User
  6. Get User Permissions

Store Configuration:
  7. View Store Config
  8. Update Read Authentication

Other:
  9. Logout & Exit

Select option (1-9):
```

### Create a User (Interactive)

```bash
dart run bin/user_manager.dart create-user
```

Then follow the prompts:
```
--- Create New User ---
Username: newuser
Password: ****
Is Admin? (y/n, default: n): n

✓ User created successfully!
  - ID: 1
  - Username: newuser
  - Admin: No
  - Active: Yes
```

**Note:** Users are automatically prefixed with `t#` (e.g., `t#newuser` internally) for easy identification.

## Features Demonstrated

✅ **SessionManager Authentication**
- Automatic login and token management
- Token refresh on expiry
- Session persistence

✅ **Service Integration**
- AuthService for user management
- StoreService for store operations
- Pre-authenticated service creation

✅ **Error Handling**
- AuthException handling
- Network error handling
- Graceful degradation for missing endpoints

✅ **CLI Best Practices**
- Command-line argument parsing
- Interactive prompts
- Password masking (when terminal supports it)
- Formatted output with colors and tables

## Server Requirements

Make sure these services are running:

- **Auth Service**: `http://localhost:8000` (default)
- **Store Service**: `http://localhost:8001` (default)
- **Compute Service**: `http://localhost:8002` (default, optional)

Test connectivity:
```bash
curl http://localhost:8000/
curl http://localhost:8001/
curl http://localhost:8002/
```

## Common Commands

### List users (default: utility-created only)
```bash
dart run bin/user_manager.dart --admin-user admin --admin-password admin list-users
```

### List all users (including system users)
```bash
dart run bin/user_manager.dart --admin-user admin --admin-password admin list-users --all
```

### Create user with script mode (no prompts)
```bash
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password admin \
  create-user --username newuser --password pass123
```

### Get user details
```bash
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password admin \
  get-user --id 1
```

### Update user
```bash
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password admin \
  update-user --id 1 --password newpass --activate
```

### Create user with custom prefix
```bash
dart run bin/user_manager.dart \
  --admin-user admin \
  --admin-password admin \
  --prefix "automation_" \
  create-user --username bot --password botpass
```

### Create user with piped input (legacy mode)
```bash
echo -e "admin\nadmin" | dart run bin/user_manager.dart create-user
```

### Run in interactive mode
```bash
dart run bin/user_manager.dart
# Prompts for username/password, then shows menu
```

## Key Features

✅ **User Prefixing** - Users created by this utility are automatically prefixed (default: `t#`)
   - Transparent to users (they see `alice`, not `t#alice`)
   - Easily identify utility-created users
   - Customizable with `--prefix` option

✅ **Smart Filtering** - List only utility-created users by default
   - Use `--all` flag to see all system users
   - Users marked with `*` to show creation source

✅ **Script Mode** - Full automation support with `--admin-user` and `--admin-password`
   - No interactive prompts
   - Perfect for CI/CD, cron jobs, orchestration
   - Use environment variables for credentials

✅ **Complete User Management**
   - Create, read, update, delete users
   - Manage permissions
   - Control admin status
   - Enable/disable users

✅ **Store Configuration**
   - Get store configuration
   - Update read authentication settings

For detailed documentation and examples, see [README.md](./README.md).
