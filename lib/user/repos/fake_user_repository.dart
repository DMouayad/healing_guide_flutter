import 'package:healing_guide_flutter/user/models/user_builder.dart';

import '../models/user.dart';
import 'user_repository.dart';

class FakeUserRepository implements UserRepository {
  User? _user;

  @override
  Future<User?> getUser() async {
    if (_user != null) {
      return _user;
    }
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = const UserBuilder().build(),
    );
  }

  @override
  Future<bool> deleteUser() async {
    _user = null;
    return true;
  }

  @override
  Future<User?> saveUser(User user) async {
    _user = user;
    return _user;
  }
}
