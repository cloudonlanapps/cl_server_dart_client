import 'package:meta/meta.dart';

/// Pagination information for paginated responses
@immutable
class PaginationInfo {
  const PaginationInfo({
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: json['page'] as int? ?? 1,
      pageSize: json['page_size'] as int? ?? 20,
      totalItems: json['total_items'] as int? ?? 0,
      totalPages: json['total_pages'] as int? ?? 1,
      hasNext: json['has_next'] as bool? ?? false,
      hasPrev: json['has_prev'] as bool? ?? false,
    );
  }

  factory PaginationInfo.fromMap(Map<String, dynamic> map) {
    return PaginationInfo.fromJson(map);
  }
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'page_size': pageSize,
      'total_items': totalItems,
      'total_pages': totalPages,
      'has_next': hasNext,
      'has_prev': hasPrev,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  PaginationInfo copyWith({
    int? page,
    int? pageSize,
    int? totalItems,
    int? totalPages,
    bool? hasNext,
    bool? hasPrev,
  }) {
    return PaginationInfo(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      hasNext: hasNext ?? this.hasNext,
      hasPrev: hasPrev ?? this.hasPrev,
    );
  }
}

/// Generic paginated list response
@immutable
class PaginatedResponse<T> {
  const PaginatedResponse({
    required this.items,
    required this.pagination,
  });
  final List<T> items;
  final PaginationInfo pagination;

  PaginatedResponse<T> copyWith({
    List<T>? items,
    PaginationInfo? pagination,
  }) {
    return PaginatedResponse(
      items: items ?? this.items,
      pagination: pagination ?? this.pagination,
    );
  }
}

/// Generic error response
@immutable
class ErrorResponse {
  const ErrorResponse({
    required this.detail,
    this.statusCode,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      detail: json['detail'] as String? ?? 'Unknown error',
    );
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse.fromJson(map);
  }
  final String detail;
  final int? statusCode;

  Map<String, dynamic> toJson() {
    return {
      'detail': detail,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  ErrorResponse copyWith({
    String? detail,
    int? statusCode,
  }) {
    return ErrorResponse(
      detail: detail ?? this.detail,
      statusCode: statusCode ?? this.statusCode,
    );
  }
}
