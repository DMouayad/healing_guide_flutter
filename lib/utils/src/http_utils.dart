import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:healing_guide_flutter/api/rest_client.dart';
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

extension JsonDecodeBodyStreamed on Response {
  /// Calls [jsonDecode] on the request body if the status code is `2xx`, otherwise
  /// throws an [AppException] based on the status code.
  ///
  /// see `[AppException.fromHttpResponse]`
  JsonObject json() {
    if (isSuccess) {
      return statusCode == HttpStatus.noContent
          ? JsonObject.from({})
          : _tryDecodingResponse();
    }
    throw AppException.fromHttpResponse(statusCode);
  }

  JsonObject _tryDecodingResponse() {
    try {
      return switch (jsonDecode(body)) {
        String str => JsonObject.from({"message": str}),
        JsonObject jsonObj => jsonObj,
        _ => {}
      };
    } catch (e) {
      throw AppException.decodingJsonFailed;
    }
  }
}
