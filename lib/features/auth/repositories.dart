import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/api/config.dart';
import 'package:healing_guide_flutter/api/rest_client.dart';
import 'package:healing_guide_flutter/features/user/models.dart';
import 'package:healing_guide_flutter/features/user/models/user_builder.dart';
import 'package:healing_guide_flutter/features/user/repositories.dart';

import 'models/auth_state.dart';

part 'repos/api_auth_repository.dart';
part 'repos/auth_repository.dart';
part 'repos/fake_auth_repository.dart';
