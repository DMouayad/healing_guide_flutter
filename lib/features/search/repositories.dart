import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:healing_guide_flutter/api/config.dart';
import 'package:healing_guide_flutter/api/rest_client.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/medical_facility/models.dart';
import 'package:healing_guide_flutter/features/physician/models/physician.dart';
import 'package:healing_guide_flutter/features/search/models/search_filters.dart';
import 'package:healing_guide_flutter/features/search/models/search_result.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

part './repos/search_repository.dart';
part 'repos/api_search_repository.dart';
part 'repos/fake_search_repository.dart';
