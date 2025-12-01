import 'package:meta/meta.dart';

/// Entity model for Store service
@immutable
class Entity {
  const Entity({
    required this.id,
    required this.isCollection,
    required this.addedDate,
    required this.updatedDate,
    required this.isDeleted,
    required this.createDate,
    this.label,
    this.description,
    this.parentId,
    this.addedBy,
    this.updatedBy,
    this.fileSize,
    this.height,
    this.width,
    this.duration,
    this.mimeType,
    this.type,
    this.extension,
    this.md5,
    this.filePath,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      id: json['id'] as int,
      isCollection: json['is_collection'] as bool? ?? false,
      label: json['label'] as String?,
      description: json['description'] as String?,
      parentId: json['parent_id'] as int?,
      addedDate: _parseDateTime(json['added_date']),
      updatedDate: _parseDateTime(json['updated_date']),
      isDeleted: json['is_deleted'] as bool? ?? false,
      createDate: _parseDateTime(json['create_date']),
      addedBy: json['added_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      fileSize: json['file_size'] as int?,
      height: json['height'] as int?,
      width: json['width'] as int?,
      duration: json['duration'] as int?,
      mimeType: json['mime_type'] as String?,
      type: json['type'] as String?,
      extension: json['extension'] as String?,
      md5: json['md5'] as String?,
      filePath: json['file_path'] as String?,
    );
  }

  factory Entity.fromMap(Map<String, dynamic> map) {
    return Entity.fromJson(map);
  }
  final int id;
  final bool isCollection;
  final String? label;
  final String? description;
  final int? parentId;
  final DateTime addedDate;
  final DateTime updatedDate;
  final bool isDeleted;
  final DateTime createDate;
  final String? addedBy;
  final String? updatedBy;
  final int? fileSize;
  final int? height;
  final int? width;
  final int? duration;
  final String? mimeType;
  final String? type;
  final String? extension;
  final String? md5;
  final String? filePath;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_collection': isCollection,
      'label': label,
      'description': description,
      'parent_id': parentId,
      'added_date': addedDate.millisecondsSinceEpoch,
      'updated_date': updatedDate.millisecondsSinceEpoch,
      'is_deleted': isDeleted,
      'create_date': createDate.millisecondsSinceEpoch,
      'added_by': addedBy,
      'updated_by': updatedBy,
      'file_size': fileSize,
      'height': height,
      'width': width,
      'duration': duration,
      'mime_type': mimeType,
      'type': type,
      'extension': extension,
      'md5': md5,
      'file_path': filePath,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  Entity copyWith({
    int? id,
    bool? isCollection,
    String? label,
    String? description,
    int? parentId,
    DateTime? addedDate,
    DateTime? updatedDate,
    bool? isDeleted,
    DateTime? createDate,
    String? addedBy,
    String? updatedBy,
    int? fileSize,
    int? height,
    int? width,
    int? duration,
    String? mimeType,
    String? type,
    String? extension,
    String? md5,
    String? filePath,
  }) {
    return Entity(
      id: id ?? this.id,
      isCollection: isCollection ?? this.isCollection,
      label: label ?? this.label,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
      addedDate: addedDate ?? this.addedDate,
      updatedDate: updatedDate ?? this.updatedDate,
      isDeleted: isDeleted ?? this.isDeleted,
      createDate: createDate ?? this.createDate,
      addedBy: addedBy ?? this.addedBy,
      updatedBy: updatedBy ?? this.updatedBy,
      fileSize: fileSize ?? this.fileSize,
      height: height ?? this.height,
      width: width ?? this.width,
      duration: duration ?? this.duration,
      mimeType: mimeType ?? this.mimeType,
      type: type ?? this.type,
      extension: extension ?? this.extension,
      md5: md5 ?? this.md5,
      filePath: filePath ?? this.filePath,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    return DateTime.now();
  }
}

/// Entity list response model
@immutable
class EntityListResponse {
  const EntityListResponse({
    required this.items,
    required this.pagination,
  });

  factory EntityListResponse.fromJson(Map<String, dynamic> json) {
    return EntityListResponse(
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => Entity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: EntityPagination.fromJson(
        json['pagination'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  factory EntityListResponse.fromMap(Map<String, dynamic> map) {
    return EntityListResponse.fromJson(map);
  }
  final List<Entity> items;
  final EntityPagination pagination;

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  EntityListResponse copyWith({
    List<Entity>? items,
    EntityPagination? pagination,
  }) {
    return EntityListResponse(
      items: items ?? this.items,
      pagination: pagination ?? this.pagination,
    );
  }
}

/// Entity pagination model (different from base pagination)
@immutable
class EntityPagination {
  const EntityPagination({
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory EntityPagination.fromJson(Map<String, dynamic> json) {
    return EntityPagination(
      page: json['page'] as int? ?? 1,
      pageSize: json['page_size'] as int? ?? 20,
      totalItems: json['total_items'] as int? ?? 0,
      totalPages: json['total_pages'] as int? ?? 1,
      hasNext: json['has_next'] as bool? ?? false,
      hasPrev: json['has_prev'] as bool? ?? false,
    );
  }

  factory EntityPagination.fromMap(Map<String, dynamic> map) {
    return EntityPagination.fromJson(map);
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

  EntityPagination copyWith({
    int? page,
    int? pageSize,
    int? totalItems,
    int? totalPages,
    bool? hasNext,
    bool? hasPrev,
  }) {
    return EntityPagination(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      hasNext: hasNext ?? this.hasNext,
      hasPrev: hasPrev ?? this.hasPrev,
    );
  }
}

/// Entity version model
@immutable
class EntityVersion {
  const EntityVersion({
    required this.version,
    required this.transactionId,
    required this.operationType,
    this.endTransactionId,
    this.label,
    this.description,
  });

  factory EntityVersion.fromJson(Map<String, dynamic> json) {
    return EntityVersion(
      version: json['version'] as int,
      transactionId: json['transaction_id'] as int,
      endTransactionId: json['end_transaction_id'] as int?,
      operationType: json['operation_type'] as int,
      label: json['label'] as String?,
      description: json['description'] as String?,
    );
  }

  factory EntityVersion.fromMap(Map<String, dynamic> map) {
    return EntityVersion.fromJson(map);
  }
  final int version;
  final int transactionId;
  final int? endTransactionId;
  final int operationType;
  final String? label;
  final String? description;

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'transaction_id': transactionId,
      'end_transaction_id': endTransactionId,
      'operation_type': operationType,
      'label': label,
      'description': description,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  EntityVersion copyWith({
    int? version,
    int? transactionId,
    int? endTransactionId,
    int? operationType,
    String? label,
    String? description,
  }) {
    return EntityVersion(
      version: version ?? this.version,
      transactionId: transactionId ?? this.transactionId,
      endTransactionId: endTransactionId ?? this.endTransactionId,
      operationType: operationType ?? this.operationType,
      label: label ?? this.label,
      description: description ?? this.description,
    );
  }
}

/// Store configuration model
@immutable
class StoreConfig {
  const StoreConfig({
    required this.readAuthEnabled,
    required this.updatedAt,
    this.updatedBy,
  });

  factory StoreConfig.fromJson(Map<String, dynamic> json) {
    return StoreConfig(
      readAuthEnabled: json['read_auth_enabled'] as bool? ?? false,
      updatedAt: json['updated_at'] is String
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.fromMillisecondsSinceEpoch(json['updated_at'] as int),
      updatedBy: json['updated_by'] as String?,
    );
  }

  factory StoreConfig.fromMap(Map<String, dynamic> map) {
    return StoreConfig.fromJson(map);
  }
  final bool readAuthEnabled;
  final DateTime updatedAt;
  final String? updatedBy;

  Map<String, dynamic> toJson() {
    return {
      'read_auth_enabled': readAuthEnabled,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'updated_by': updatedBy,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  StoreConfig copyWith({
    bool? readAuthEnabled,
    DateTime? updatedAt,
    String? updatedBy,
  }) {
    return StoreConfig(
      readAuthEnabled: readAuthEnabled ?? this.readAuthEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
