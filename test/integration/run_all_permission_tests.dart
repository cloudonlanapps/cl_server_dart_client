import 'package:test/test.dart';

import 'health_check_test.dart' as health_check;
import 'user_permission_levels_test.dart' as user_perms;
import 'store_permission_levels_test.dart' as store_perms;
import 'read_auth_scenarios_test.dart' as read_auth;

/// Consolidated test runner for all permission level integration tests
///
/// This runner orchestrates execution of all 4 test suites in sequence:
/// 1. Health Checks - Verifies both services are available
/// 2. User Permission Levels - Tests admin operations via UserManager
/// 3. Store Permission Levels - Tests store permission combinations
/// 4. ReadAuth Scenarios - Tests guest access with ReadAuth enabled/disabled
///
/// Usage:
///   dart test test/integration/run_all_permission_tests.dart
///
/// Or run all tests:
///   dart test test/integration/
///
/// Requirements:
/// - Auth service running at http://localhost:8000
/// - Store service running at http://localhost:8001

void main() {
  group('Comprehensive Permission Test Suite', () {
    group('1. Health Checks', health_check.main);
    group('2. User Permission Levels - Admin Operations', user_perms.main);
    group('3. Store Permission Levels - Permission Combinations',
        store_perms.main);
    group('4. ReadAuth Scenarios - Guest Access Control', read_auth.main);
  });
}
