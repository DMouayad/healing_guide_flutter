import 'dart:async';
import 'dart:convert';

import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:http/http.dart';

/// Converts the given elements to strings and joins them with slashes, ensuring
/// there is no consecutive or leading/trailing slashes
String joinPath(List<dynamic> parts) => parts
    .expand((part) =>
        part.toString().split("/").where((innerPart) => innerPart.isNotEmpty))
    .join("/");

Completer<T> wrapInCompleter<T>(Future<T> future) {
  final completer = Completer<T>();
  future.then(completer.complete).catchError(completer.completeError);
  return completer;
}

extension StatusClasses on BaseResponse {
  /// True for 2xx status codes
  bool get isSuccess => statusCode < 300 && statusCode >= 200;
}

extension JsonDecodeBody on Response {
  /// Calls [jsonDecode] on the request body if the status code is `2xx`, otherwise
  /// throws [InvalidResponseStatus]
  dynamic json() {
    if (isSuccess) return jsonDecode(body);
    throw AppException.fromHttpResponse(statusCode);
  }
}

extension JsonDecodeBodyStreamed on StreamedResponse {
  /// Calls [jsonDecode] on the request body if the status code is `2xx`, otherwise
  /// throws [InvalidResponseStatus]
  Future<dynamic> json() async {
    if (isSuccess) return jsonDecode(await stream.bytesToString());
    throw AppException.fromHttpResponse(statusCode);
  }
}
