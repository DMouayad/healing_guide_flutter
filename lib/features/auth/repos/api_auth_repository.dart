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
      _controller.add(AuthState.authenticated());
      return Future.value();
    });
  }

  @override
  Future<void> logOut() async {
    return RestClient.instance
        .post(ApiConfig.logoutEndpoint)
        .then((res) => _controller.add(AuthState.unauthenticated()));
  }

  @override
  Future<void> completePatientRegistration(
    CompletePatientRegistrationDTO dto,
  ) async {
    return RestClient.instance.post(ApiConfig.completeRegistrationAsPatient, {
      "confirmEmail": dto.email,
      "confirmPhoneNumber": dto.phoneNumber,
      "confirmPassword": dto.password,
      "firstName": dto.fullName.split(' ').firstOrNull ?? '',
      "lastName": dto.fullName.split(' ').lastOrNull ?? '',
      "Address": faker.address.city(),
      "city": "",
      "profilePicture": "",
    }).then((res) {
      print(res);
    });
  }

  @override
  Future<void> completePhysicianRegistration(
    CompletePhysicianRegistrationDTO dto,
  ) async {
    return RestClient.instance.post(ApiConfig.completeRegistrationAsPhysician, {
      "confirmEmail": dto.email,
      "confirmPhoneNumber": dto.phoneNumber,
      "confirmPassword": dto.password,
      "firstName": dto.fullName.split(' ').firstOrNull ?? '',
      "lastName": dto.fullName.split(' ').lastOrNull ?? '',
      "Address": dto.location,
      "City": dto.location,
      "Biography": dto.biography,
      "Languages": dto.languages.join(", "),
      "profilePicture": "",
    }).then((res) {
      print(res);
    });
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
