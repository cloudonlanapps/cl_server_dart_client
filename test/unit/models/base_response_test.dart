import 'package:cl_server_dart_client/cl_server_dart_client.dart';
import 'package:test/test.dart';

void main() {
  group('Base Response Models Tests', () {
    group('PaginationInfo Model', () {
      final samplePaginationJson = {
        'page': 1,
        'page_size': 20,
        'total_items': 50,
        'total_pages': 3,
        'has_next': true,
        'has_prev': false,
      };

      test('PaginationInfo.fromJson creates instance correctly', () {
        final pagination = PaginationInfo.fromJson(samplePaginationJson);

        expect(pagination.page, 1);
        expect(pagination.pageSize, 20);
        expect(pagination.totalItems, 50);
        expect(pagination.totalPages, 3);
        expect(pagination.hasNext, true);
        expect(pagination.hasPrev, false);
      });

      test('PaginationInfo.fromMap creates instance correctly', () {
        final pagination = PaginationInfo.fromMap(samplePaginationJson);
        expect(pagination.page, 1);
      });

      test('PaginationInfo.toJson serializes correctly', () {
        final pagination = PaginationInfo.fromJson(samplePaginationJson);
        final json = pagination.toJson();

        expect(json['page'], 1);
        expect(json['page_size'], 20);
        expect(json['total_items'], 50);
      });

      test('PaginationInfo.toMap returns same as toJson', () {
        final pagination = PaginationInfo.fromJson(samplePaginationJson);
        expect(pagination.toMap(), pagination.toJson());
      });

      test('PaginationInfo.copyWith creates new instance with changes', () {
        final pagination = PaginationInfo.fromJson(samplePaginationJson);
        final updated = pagination.copyWith(page: 2, hasNext: false);

        expect(updated.page, 2);
        expect(updated.pageSize, pagination.pageSize);
        expect(updated.hasNext, false);
      });

      test('PaginationInfo handles missing fields with defaults', () {
        final minimalJson = <String, dynamic>{};
        final pagination = PaginationInfo.fromJson(minimalJson);

        expect(pagination.page, 1);
        expect(pagination.pageSize, 20);
        expect(pagination.totalItems, 0);
        expect(pagination.hasNext, false);
      });
    });

    group('ErrorResponse Model', () {
      final sampleErrorJson = {
        'detail': 'User not found',
      };

      test('ErrorResponse.fromJson creates instance correctly', () {
        final error = ErrorResponse.fromJson(sampleErrorJson);

        expect(error.detail, 'User not found');
      });

      test('ErrorResponse.fromMap creates instance correctly', () {
        final error = ErrorResponse.fromMap(sampleErrorJson);
        expect(error.detail, 'User not found');
      });

      test('ErrorResponse.toJson serializes correctly', () {
        final error = ErrorResponse.fromJson(sampleErrorJson);
        final json = error.toJson();

        expect(json['detail'], 'User not found');
      });

      test('ErrorResponse.copyWith creates new instance', () {
        final error = ErrorResponse.fromJson(sampleErrorJson);
        final updated = error.copyWith(
          detail: 'New error message',
          statusCode: 404,
        );

        expect(updated.detail, 'New error message');
        expect(updated.statusCode, 404);
      });

      test('ErrorResponse handles missing detail with default', () {
        final minimalJson = <String, dynamic>{};
        final error = ErrorResponse.fromJson(minimalJson);

        expect(error.detail, 'Unknown error');
      });
    });

    group('PaginatedResponse Model', () {
      test('PaginatedResponse creates instance correctly', () {
        final pagination = PaginationInfo.fromJson(const {
          'page': 1,
          'page_size': 10,
          'total_items': 10,
          'total_pages': 1,
          'has_next': false,
          'has_prev': false,
        });

        final response = PaginatedResponse<String>(
          items: const ['item1', 'item2'],
          pagination: pagination,
        );

        expect(response.items, hasLength(2));
        expect(response.pagination.page, 1);
      });

      test('PaginatedResponse.copyWith creates new instance', () {
        final pagination = PaginationInfo.fromJson(const {
          'page': 1,
          'page_size': 10,
          'total_items': 10,
          'total_pages': 1,
        });

        final response = PaginatedResponse<String>(
          items: const ['item1'],
          pagination: pagination,
        );

        final updated = response.copyWith(
          items: ['item1', 'item2', 'item3'],
        );

        expect(updated.items, hasLength(3));
        expect(updated.pagination, response.pagination);
      });
    });
  });
}
