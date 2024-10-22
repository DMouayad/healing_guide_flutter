import 'dart:io';
import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/features/theme/text_theme.dart';
import 'package:logger/logger.dart';

part 'src/context_extensions.dart';
part 'src/bloc_observer.dart';

/// A logger with simple output printer
final sLogger = Logger(printer: SimplePrinter());

/// A logger with pretty output printer
final pLogger = Logger(printer: PrettyPrinter());
