import '../models/user.dart';
import 'user_repository.dart';

class FakeUserRepository implements UserRepository {
  User? _user;

  @override
  Future<User?> getUser() async {
    return _user;
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
