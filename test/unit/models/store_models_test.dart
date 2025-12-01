import 'package:cl_server_dart_client/cl_server_dart_client.dart';
import 'package:test/test.dart';

void main() {
  group('Store Models Tests', () {
    group('Entity Model', () {
      final sampleEntityJson = {
        'id': 1,
        'is_collection': false,
        'label': 'Vacation Photo',
        'description': 'Beach sunset',
        'parent_id': null,
        'added_date': 1704067200000,
        'updated_date': 1704067200000,
        'is_deleted': false,
        'create_date': 1704067200000,
        'added_by': 'admin',
        'updated_by': 'admin',
        'file_size': 2048576,
        'height': 1920,
        'width': 1080,
        'duration': null,
        'mime_type': 'image/jpeg',
        'type': 'image',
        'extension': 'jpg',
        'md5': '5d41402abc4b2a76b9719d911017c592',
        'file_path': '/media/2024/01/vacation.jpg',
      };

      test('Entity.fromJson creates instance correctly', () {
        final entity = Entity.fromJson(sampleEntityJson);

        expect(entity.id, 1);
        expect(entity.isCollection, false);
        expect(entity.label, 'Vacation Photo');
        expect(entity.description, 'Beach sunset');
        expect(entity.mimeType, 'image/jpeg');
        expect(entity.type, 'image');
      });

      test('Entity.toJson serializes correctly', () {
        final entity = Entity.fromJson(sampleEntityJson);
        final json = entity.toJson();

        expect(json['id'], 1);
        expect(json['label'], 'Vacation Photo');
        expect(json['mime_type'], 'image/jpeg');
      });

      test('Entity.copyWith creates new instance with changes', () {
        final entity = Entity.fromJson(sampleEntityJson);
        final updated = entity.copyWith(label: 'Updated Label');

        expect(updated.id, entity.id);
        expect(updated.label, 'Updated Label');
        expect(updated.description, entity.description);
      });

      test('Entity.toMap returns same as toJson', () {
        final entity = Entity.fromJson(sampleEntityJson);
        expect(entity.toMap(), entity.toJson());
      });
    });

    group('EntityListResponse Model', () {
      final sampleListJson = {
        'items': [
          {
            'id': 1,
            'is_collection': false,
            'label': 'Photo 1',
            'added_date': 1704067200000,
            'updated_date': 1704067200000,
            'is_deleted': false,
            'create_date': 1704067200000,
          },
        ],
        'pagination': {
          'page': 1,
          'page_size': 20,
          'total_items': 1,
          'total_pages': 1,
          'has_next': false,
          'has_prev': false,
        },
      };

      test('EntityListResponse.fromJson creates instance correctly', () {
        final response = EntityListResponse.fromJson(sampleListJson);

        expect(response.items, hasLength(1));
        expect(response.items[0].label, 'Photo 1');
        expect(response.pagination.page, 1);
        expect(response.pagination.totalItems, 1);
      });

      test('EntityListResponse.toJson serializes correctly', () {
        final response = EntityListResponse.fromJson(sampleListJson);
        final json = response.toJson();

        expect(json['items'], hasLength(1));
        expect((json['pagination'] as Map<String, dynamic>)['page'], 1);
      });

      test('EntityListResponse.copyWith creates new instance', () {
        final response = EntityListResponse.fromJson(sampleListJson);
        final updated = response.copyWith(
          items: [],
        );

        expect(updated.items, isEmpty);
        expect(updated.pagination, response.pagination);
      });
    });

    group('EntityVersion Model', () {
      final sampleVersionJson = {
        'version': 1,
        'transaction_id': 1,
        'end_transaction_id': null,
        'operation_type': 0,
        'label': 'Initial Label',
        'description': 'Initial Description',
      };

      test('EntityVersion.fromJson creates instance correctly', () {
        final version = EntityVersion.fromJson(sampleVersionJson);

        expect(version.version, 1);
        expect(version.transactionId, 1);
        expect(version.label, 'Initial Label');
      });

      test('EntityVersion.toJson serializes correctly', () {
        final version = EntityVersion.fromJson(sampleVersionJson);
        final json = version.toJson();

        expect(json['version'], 1);
        expect(json['label'], 'Initial Label');
      });

      test('EntityVersion.copyWith creates new instance', () {
        final version = EntityVersion.fromJson(sampleVersionJson);
        final updated = version.copyWith(label: 'Updated Label');

        expect(updated.version, version.version);
        expect(updated.label, 'Updated Label');
      });
    });

    group('StoreConfig Model', () {
      final sampleConfigJson = {
        'read_auth_enabled': false,
        'updated_at': 1704067200000,
        'updated_by': 'admin',
      };

      test('StoreConfig.fromJson creates instance correctly', () {
        final config = StoreConfig.fromJson(sampleConfigJson);

        expect(config.readAuthEnabled, false);
        expect(config.updatedBy, 'admin');
      });

      test('StoreConfig.toJson serializes correctly', () {
        final config = StoreConfig.fromJson(sampleConfigJson);
        final json = config.toJson();

        expect(json['read_auth_enabled'], false);
        expect(json['updated_by'], 'admin');
      });

      test('StoreConfig.copyWith creates new instance', () {
        final config = StoreConfig.fromJson(sampleConfigJson);
        final updated = config.copyWith(readAuthEnabled: true);

        expect(updated.readAuthEnabled, true);
        expect(updated.updatedBy, config.updatedBy);
      });
    });

    group('EntityPagination Model', () {
      final samplePaginationJson = {
        'page': 2,
        'page_size': 50,
        'total_items': 100,
        'total_pages': 2,
        'has_next': false,
        'has_prev': true,
      };

      test('EntityPagination.fromJson creates instance correctly', () {
        final pagination = EntityPagination.fromJson(samplePaginationJson);

        expect(pagination.page, 2);
        expect(pagination.pageSize, 50);
        expect(pagination.totalItems, 100);
        expect(pagination.hasNext, false);
        expect(pagination.hasPrev, true);
      });

      test('EntityPagination.copyWith creates new instance', () {
        final pagination = EntityPagination.fromJson(samplePaginationJson);
        final updated = pagination.copyWith(page: 3);

        expect(updated.page, 3);
        expect(updated.pageSize, pagination.pageSize);
      });
    });
  });
}
