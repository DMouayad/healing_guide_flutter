import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/theme/text_theme.dart';
import 'package:logger/logger.dart';

part 'src/context_extensions.dart';
part 'src/bloc_observer.dart';

/// A logger with simple output printer
final sLogger = Logger(printer: SimplePrinter());

/// A logger with pretty output printer
final pLogger = Logger(printer: PrettyPrinter());
