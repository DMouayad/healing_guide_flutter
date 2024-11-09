import 'package:healing_guide_flutter/api/config.dart';
import 'package:healing_guide_flutter/api/rest_client.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

import 'medical_specialty.dart';

typedef MedicalSpecialties = List<MedicalSpecialty>;

abstract class MedicalSpecialtyRepository {
  Future<MedicalSpecialties> getAll();
}

class ApiMedicalSpecialtyRepository extends MedicalSpecialtyRepository {
  @override
  Future<MedicalSpecialties> getAll() {
    return RestClient.instance
        .get(ApiConfig.getMedicalSpecialtiesEndpoint)
        .then(_decodeResponseBody)
        .catchError(_handleError);
  }

  Future<MedicalSpecialties> _handleError(Object error, StackTrace trace) {
    pLogger.e('$runtimeType', error: error, stackTrace: trace);
    return switch (error) {
      AppException.notFound => Future.value(MedicalSpecialties.empty()),
      _ => Future<MedicalSpecialties>.error(error)
    };
  }

  MedicalSpecialties _decodeResponseBody(JsonObject json) {
    if (json case {"\$values": List<JsonObject> items}) {
      return items.map(_fromJson).whereType<MedicalSpecialty>().toList();
    }
    return MedicalSpecialties.empty();
  }

  MedicalSpecialty? _fromJson(JsonObject json) {
    if (json
        case {
          "\$id": String _,
          "id": String id,
          "name": String name,
          "physicianSpecialties": JsonObject physicians
        }) {
      return MedicalSpecialty(
        id: id,
        name: name,
        physicianIds: _getPhysicianIds(physicians),
      );
    }

    return null;
  }

  List<String> _getPhysicianIds(JsonObject json) {
    final ids = List<String>.empty();
    if (json['\$values'] case List<JsonObject> items) {
      for (var item in items) {
        if (item['physicianId'] case String physicianId) {
          ids.add(physicianId);
        }
      }
    }
    return ids;
  }
}
