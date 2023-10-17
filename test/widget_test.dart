import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:watchlist_task6/Api/base_client.dart';
import 'package:http/http.dart' as http;

void main() {
  group('BaseClient API tests', () {
    test('get returns data when successful', () async {
      final mockClient = MockClient((request) async {
        final responseJson = [
          {
            "id": "1",
            "name": "name 1",
            "Contacts": "1-355-184-1639",
            "url":
                "https://s3.amazonaws.com/uifaces/faces/twitter/jpscribbles/128.jpg"
          }
        ];

        final responseString = json.encode(responseJson);
        print('Successful API Response: $responseString'); // Print the response

        return http.Response(responseString, 200);
      });

      final baseClient = BaseClient();
      baseClient.client = mockClient;
      final result = await baseClient.get('msf/getContacts');
      print('Result: $result');

      final parsedResult = json.decode(result);

      expect(parsedResult, isA<List>());

      final item = parsedResult[0];
      expect(item['id'], '1');
      expect(item['name'], 'name 1');
      expect(item['Contacts'], '1-355-184-1639');
      expect(item['url'],
          'https://s3.amazonaws.com/uifaces/faces/twitter/jpscribbles/128.jpg');
    });

    test('get throws an exception on error', () async {
      final mockClient = MockClient((request) async {
        print('Error API Response');
        return http.Response('Error occurred', 404);
      });

      final baseClient = BaseClient();
      baseClient.client = mockClient;

      try {
        await baseClient.get('msf/getContacts1');
        fail('Expected an exception');
      } catch (e) {
        print('Exception: $e');
        expect(e, isA<Exception>());
      }
    });
  });
}
