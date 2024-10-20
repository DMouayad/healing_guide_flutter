import '../models/user.dart';

abstract interface class UserRepository {
  Future<User?> getUser();
  Future<User?> saveUser(User user);
  Future<bool> deleteUser();
}
