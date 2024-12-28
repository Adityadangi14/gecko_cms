import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:gecko_cms/core/logging/console_log.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  static Map<String, String> header = {
    "Content-Type": "application/json",
    "Token":
        " eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MzcyODAyNDUsInN1YiI6IjUzNmY0NmJlMjcwODQ1NDA4NmU1NGJlMTk5MTE1MTFmIn0.FZ_MGloLFBbVKTXSlCuk0BfdlszqnXAbL-_wWpdlVhs"
  };
  static Future<Map<String, dynamic>> getData(String endpoint) async {
    ConsoleLog.add(logType: LogType.inprogress, data: "Getting url: $endpoint");
    try {
      http.Response response =
          await http.get(Uri.parse(endpoint), headers: header);

      if (response.statusCode == 200) {
        String data = response.body;
        ConsoleLog.add(
            logType: LogType.success, data: "Response: ${response.body}");
        return jsonDecode(data);
      } else {
        ConsoleLog.add(logType: LogType.error, data: " Error:${response.body}");
        throw 'Failed to fetch data';
      }
    } on Exception catch (e) {
      ConsoleLog.add(logType: LogType.error, data: " Error:${e}");
      throw (e);
    }
  }

  static Future<Map<String, dynamic>> postData(
      String endpoint, Map<String, dynamic> body) async {
    try {
      ConsoleLog.add(
          logType: LogType.inprogress,
          data: "Posting url: $endpoint data $body");

      http.Response response = await http.post(
        Uri.parse(endpoint),
        headers: header,
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        String data = response.body;
        ConsoleLog.add(logType: LogType.success, data: "Resposne: $data");
        return jsonDecode(data);
      } else {
        ConsoleLog.add(
            logType: LogType.error, data: "Error res: ${response.body}");
        throw 'Failed to post data';
      }
    } catch (e) {
      ConsoleLog.add(logType: LogType.error, data: " Error:${e}");
      throw (e);
    }
  }

  static Future<Map<String, dynamic>> deleteData(
      {required String endpoint, required Map<String, dynamic> body}) async {
    ConsoleLog.add(
        logType: LogType.inprogress, data: "Delete url: $endpoint , $body");
    try {
      log(body.toString());
      http.Response response = await http.delete(
        headers: header,
        body: jsonEncode(body),
        Uri.parse(endpoint),
      );

      if (response.statusCode == 200) {
        String data = response.body;
        ConsoleLog.add(logType: LogType.success, data: "Resposne: $data");
        return jsonDecode(data);
      } else {
        ConsoleLog.add(
            logType: LogType.error, data: "Error res: ${response.body}");
        throw 'Failed to delete data';
      }
    } on Exception catch (e) {
      ConsoleLog.add(logType: LogType.error, data: " Error:${e}");
      throw (e);
    }
  }

  static Future<Map<String, dynamic>> putData(
      {required String endpoint, required Map<String, dynamic> body}) async {
    ConsoleLog.add(
        logType: LogType.inprogress, data: "Delete url: $endpoint , $body");
    try {
      http.Response response = await http.put(
        Uri.parse(endpoint),
        headers: header,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        ConsoleLog.add(
            logType: LogType.error, data: "Error res: ${response.body}");
        throw 'Failed to put data';
      }
    } on Exception catch (e) {
      ConsoleLog.add(logType: LogType.error, data: " Error:${e}");
      throw (e);
    }
  }

  static Future<Map<String, dynamic>> uploadImage(
      Uint8List file, String url) async {
    // Create multipart request
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.files.add(
        http.MultipartFile.fromBytes('image', file,
            filename: DateTime.now().microsecondsSinceEpoch.toString()),
      );

      // Send request and handle response
      final response = await request.send();

      if (response.statusCode == 200) {
        var apiResponse = jsonDecode(await response.stream.bytesToString())
            as Map<String, dynamic>;
        return apiResponse;
      } else {
        print('Error uploading image: ${response.reasonPhrase}');
        throw ("'Error uploading image: ${response.statusCode}'");
        // Handle error
      }
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
