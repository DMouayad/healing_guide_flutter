import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as io_client;

const _maxCacheSize = 2 * 1024 * 1024;

class HttpHelper {
  static http.BaseClient getClient() {
    if (Platform.isAndroid) {
      WidgetsFlutterBinding.ensureInitialized();
      final engine = CronetEngine.build(
        cacheMode: CacheMode.memory,
        cacheMaxSize: _maxCacheSize,
        userAgent: 'HGuide Agent',
      );
      return CronetClient.fromCronetEngine(engine);
    } else {
      return io_client.IOClient(HttpClient()..userAgent = 'HGuide Agent');
    }
  }
}
