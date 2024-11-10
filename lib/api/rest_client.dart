import "dart:async";
import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:http/http.dart" as http;

import "package:healing_guide_flutter/api/config.dart";
import "package:healing_guide_flutter/utils/src/http_utils.dart";

typedef JsonObject = Map<String, dynamic>;
typedef Cache = Map<String, Completer<JsonObject>>;

class RestClient {
  final http.BaseClient httpClient;

  static RestClient? _instance;

  const RestClient(this.httpClient);

  static RestClient get instance => _instance!;

  static RestClient init(http.BaseClient httpClient) {
    return _instance ??= RestClient(httpClient);
  }

  Future<JsonObject> get(dynamic pathOrParts) {
    final path =
        pathOrParts is List ? joinPath(pathOrParts) : pathOrParts.toString();
    return request("GET", path);
  }

  Future<JsonObject> post(dynamic pathOrParts, [JsonObject body = const {}]) =>
      request("POST", pathOrParts, body);

  Future<JsonObject> patch(dynamic pathOrParts, [JsonObject body = const {}]) =>
      request("PATCH", pathOrParts, body);

  Future<JsonObject> delete(
    dynamic pathOrParts, [
    JsonObject body = const {},
  ]) =>
      request("DELETE", pathOrParts, body);

  Future<JsonObject> request(
    String method,
    dynamic pathOrParts, [
    JsonObject? body,
  ]) async {
    final path =
        pathOrParts is List ? joinPath(pathOrParts) : pathOrParts.toString();

    final uri = Uri.parse("${ApiConfig.url}/$path");

    final request = http.Request(method, uri);
    request.headers.addAll(_headers);
    request.body = jsonEncode(body);

    log("$method $uri", name: 'Request Logger');

    return httpClient
        .send(request)
        .then(http.Response.fromStream)
        .then((response) => response.json());
  }

  Map<String, String> get _headers {
    return {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.acceptHeader: "application/json",
    };
  }

  static R runCached<R>(R Function() body) {
    final Cache cache = Zone.current[#_restClientCache] ?? {};
    return runZoned(body, zoneValues: {#_restClientCache: cache});
  }

  Future<JsonObject> _runCached(
    String endpoint,
    Future<JsonObject> Function() body,
  ) async {
    final Cache? cache = Zone.current[#_restClientCache];

    if (cache == null) return await body();

    if (cache.containsKey(endpoint)) {
      final message = cache[endpoint]!.isCompleted
          ? "cache hit"
          : "cache hit (already running)";
      log("$message: $endpoint");

      return await cache[endpoint]!.future;
    }

    return await (cache[endpoint] = wrapInCompleter(body())).future;
  }
}
