part of '../repositories.dart';

final class ApiAuthRepository extends AuthRepository {
  ApiAuthRepository(super.userRepository);

  @override
  Future<void> logIn(UserLoginDTO dto) async {
    return RestClient.instance.post(ApiConfig.loginEndpoint, {
      "loginIdentifier": dto.email,
      "password": dto.password,
      "rememberMe": true
    }).then((res) {
      return Future.value();
    });
  }

  @override
  Future<void> logOut() async {
    return RestClient.instance
        .post(ApiConfig.logoutEndpoint)
        .then((res) => _userRepository.deleteUser());
  }

  @override
  Future<void> completeRegistration(CompleteRegistrationDTO dto) async {
    return RestClient.instance.post(
        dto.role == Role.physician
            ? ApiConfig.completeRegistrationAsPhysician
            : ApiConfig.completeRegistrationAsPatient,
        {
          "confirmEmail": dto.email,
          "confirmPhoneNumber": dto.phoneNumber,
          "confirmPassword": dto.password,
          "firstName": dto.fullName.split(' ').firstOrNull ?? '',
          "lastName": dto.fullName.split(' ').lastOrNull ?? '',
          "address": "",
          "profilePicture": "",
        }).then((_) {});
  }

  @override
  Future<void> startRegistration(StartRegistrationDTO dto) async {
    return RestClient.instance.post(
        dto.role == Role.physician
            ? ApiConfig.startRegistrationAsPhysician
            : ApiConfig.startRegistrationAsPatient,
        {
          "email": dto.email,
          "phoneNumber": dto.phoneNumber,
          "password": dto.password,
        }).then((_) {});
  }
}
