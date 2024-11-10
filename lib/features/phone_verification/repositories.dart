import 'package:healing_guide_flutter/api/config.dart';
import 'package:healing_guide_flutter/api/rest_client.dart';
import 'package:healing_guide_flutter/features/user/models.dart';

class ApiPhoneVerificationRepository {
  static const _code = '123456';
  Future<void> verify(String phoneNumber, Role role) {
    return RestClient.instance.post(
      role == Role.physician
          ? ApiConfig.verifyPhysicianPhoneNumberEndpoint
          : ApiConfig.verifyPatientPhoneNumberEndpoint,
      {"code": _code, "phoneNumber": phoneNumber},
    ).then((_) {});
  }
}
