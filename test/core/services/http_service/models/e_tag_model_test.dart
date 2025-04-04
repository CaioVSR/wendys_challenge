import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/core/services/http_service/models/e_tag_model.dart';

void main() {
  group('ETagModel', () {
    const testETag = 'W/"a123-456def"';
    const testPayloadMap = <String, dynamic>{'name': 'Test Item', 'id': 123};
    const testPayloadList = <dynamic>[1, 2, 3];
    const testPayloadString = 'Test response body';

    group('Construction & Equality', () {
      test('should create model with required parameters', () {
        const model = ETagModel(eTag: testETag, payload: testPayloadMap);
        expect(model.eTag, testETag);
        expect(model.payload, testPayloadMap);
      });

      test('instances with identical properties should be equal', () {
        const model1 = ETagModel(eTag: testETag, payload: testPayloadMap);
        const model2 = ETagModel(eTag: testETag, payload: testPayloadMap);
        expect(
          model1,
          equals(model2),
          reason: 'Two models with the same eTag and payload should be equal.',
        );
      });

      test('instances with different eTag should not be equal', () {
        const model1 = ETagModel(eTag: testETag, payload: testPayloadMap);
        const model2 = ETagModel(
          eTag: 'different-etag',
          payload: testPayloadMap,
        );
        expect(
          model1,
          isNot(equals(model2)),
          reason: 'Changing the eTag should affect equality.',
        );
      });

      test('instances with different payload should not be equal', () {
        const model1 = ETagModel(eTag: testETag, payload: testPayloadMap);
        const model2 = ETagModel(eTag: testETag, payload: testPayloadList);
        expect(
          model1,
          isNot(equals(model2)),
          reason: 'Different payload types should result in inequality.',
        );
      });
    });

    group('Serialization', () {
      test('should serialize to JSON correctly', () {
        const model = ETagModel(eTag: testETag, payload: testPayloadMap);
        final json = model.toJson();

        expect(json, containsPair('eTag', testETag));
        expect(json, containsPair('payload', testPayloadMap));
      });

      test('should deserialize from JSON correctly', () {
        final json = <String, dynamic>{
          'eTag': testETag,
          'payload': testPayloadMap,
        };
        final model = ETagModel.fromJson(json);

        expect(model.eTag, testETag);
        expect(model.payload, testPayloadMap);
      });

      test('should handle string payload', () {
        const model = ETagModel(eTag: testETag, payload: testPayloadString);
        final json = model.toJson();
        final deserializedModel = ETagModel.fromJson(json);

        expect(deserializedModel.payload, testPayloadString);
      });

      test('should handle list payload', () {
        const model = ETagModel(eTag: testETag, payload: testPayloadList);
        final json = model.toJson();
        final deserializedModel = ETagModel.fromJson(json);

        expect(deserializedModel.payload, testPayloadList);
      });

      test('should handle nested complex payload structures', () {
        final complexPayload = {
          'items': [
            {
              'id': 1,
              'name': 'Item 1',
              'tags': ['a', 'b'],
            },
            {
              'id': 2,
              'name': 'Item 2',
              'tags': ['c', 'd'],
            },
          ],
          'metadata': {'count': 2, 'lastUpdated': '2023-01-01'},
        };

        final model = ETagModel(eTag: testETag, payload: complexPayload);
        final json = model.toJson();
        final deserializedModel = ETagModel.fromJson(json);

        expect(deserializedModel.payload, complexPayload);
      });
    });

    group('copyWith', () {
      test('should create a new instance with updated values', () {
        const model = ETagModel(eTag: testETag, payload: testPayloadMap);
        final updated = model.copyWith(eTag: 'new-etag');

        expect(
          updated.eTag,
          'new-etag',
          reason: 'copyWith should update the eTag field.',
        );
        expect(
          updated.payload,
          testPayloadMap,
          reason: 'copyWith should preserve the original payload.',
        );
        expect(
          model.eTag,
          testETag,
          reason: 'Original instance should remain unchanged.',
        );
      });
    });
  });
}
