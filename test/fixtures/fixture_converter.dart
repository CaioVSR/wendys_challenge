import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> fixtureConverter(String path) async {
  final file = File(path);

  final jsonString = await file.readAsString();

  return json.decode(jsonString) as Map<String, dynamic>;
}
