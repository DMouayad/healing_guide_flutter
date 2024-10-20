import 'package:faker/faker.dart';

import 'role.dart';
import 'user.dart';

class UserBuilder {
  const UserBuilder();

  // Method to build the User object
  User build({
    int? id,
    Role role = Role.guest,
    String? email,
    String? phoneNumber,
    String? fullName,
    DateTime? emailVerifiedAt,
    DateTime? phoneNumberVerifiedAt,
    DateTime? createdAt,
  }) {
    final faker = Faker();

    return User(
      id: id ??
          faker.randomGenerator.integer(999) + faker.randomGenerator.integer(5),
      role: role,
      email: email ?? faker.internet.email(),
      phoneNumber: phoneNumber ?? faker.phoneNumber.us(),
      fullName: fullName ?? faker.person.name(),
      emailVerifiedAt: emailVerifiedAt ?? getRandomDate(faker),
      phoneNumberVerifiedAt: phoneNumberVerifiedAt ?? getRandomDate(faker),
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  DateTime getRandomDate(Faker faker) {
    return faker.date.dateTimeBetween(
      DateTime.now().subtract(const Duration(days: 365)),
      DateTime.now(),
    );
  }
}
