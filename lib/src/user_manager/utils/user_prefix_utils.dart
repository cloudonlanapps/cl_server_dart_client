/// Utilities for managing user name prefixes
///
/// The user manager automatically prefixes usernames created through this
/// utility to distinguish them from system users and users created manually.
class UserPrefixUtils {
  /// Common prefix patterns used by this utility and predecessors
  static const List<String> commonPrefixes = ['t#', 'test_', 'cli_', 'util_'];

  /// Add prefix to a username
  ///
  /// Example: addPrefix('alice', 't#') returns 't#alice'
  static String addPrefix(String username, String prefix) {
    if (username.isEmpty) return prefix;
    return '$prefix$username';
  }

  /// Remove prefix from a username
  ///
  /// Removes any of the common prefixes if present.
  /// Example: removePrefix('t#alice') returns 'alice'
  /// Example: removePrefix('alice') returns 'alice' (no change if not prefixed)
  static String removePrefix(String username) {
    for (final prefix in commonPrefixes) {
      if (username.startsWith(prefix)) {
        return username.substring(prefix.length);
      }
    }
    return username;
  }

  /// Check if a user was created by this utility
  ///
  /// Checks if the username has the current prefix
  /// or any common alternative prefix.
  static bool isUtilityCreatedUser(String username, String prefix) {
    // First check current prefix
    if (username.startsWith(prefix)) {
      return true;
    }

    // Then check common alternative prefixes
    for (final altPrefix in commonPrefixes) {
      if (altPrefix != prefix && username.startsWith(altPrefix)) {
        return true;
      }
    }

    return false;
  }

  /// Get list of common prefixes
  static List<String> getCommonPrefixes() => List.unmodifiable(commonPrefixes);

  /// Check if a username starts with any known prefix
  static bool hasAnyPrefix(String username) {
    for (final prefix in commonPrefixes) {
      if (username.startsWith(prefix)) {
        return true;
      }
    }
    return false;
  }

  /// Extract the prefix from a username, if any
  ///
  /// Returns the prefix if found, or empty string if username has no prefix
  static String extractPrefix(String username) {
    for (final prefix in commonPrefixes) {
      if (username.startsWith(prefix)) {
        return prefix;
      }
    }
    return '';
  }
}
