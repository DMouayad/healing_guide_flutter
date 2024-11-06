import 'package:equatable/equatable.dart';

class Physician extends Equatable {
  final String id;
  final String name;
  final String city;
  final bool isMale;
  final DateTime? dateOfBirth;
  final List<String> languages;
  final double rating;

  const Physician({
    required this.id,
    required this.name,
    required this.city,
    required this.isMale,
    required this.dateOfBirth,
    this.languages = const [],
    this.rating = 0,
  });

  @override
  List<Object?> get props =>
      [id, name, city, isMale, dateOfBirth, languages, rating];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "city": city,
      "isMale": isMale,
      "dateOfBirth": dateOfBirth?.toIso8601String(),
      "rating": rating,
      "languages": languages,
    };
  }

  static Physician? fromJson(Map<String, dynamic> json) {
    if (json
        case {
          "id": String id,
          "name": String name,
          "city": String city,
          "dateOfBirth": String? dateOfBirthStr,
          "isMale": bool isMale,
          "rating": double rating,
          "languages": List<String> languages,
        }) {
      return Physician(
        id: id,
        name: name,
        city: city,
        rating: rating,
        languages: languages,
        isMale: isMale,
        dateOfBirth:
            dateOfBirthStr != null ? DateTime.tryParse(dateOfBirthStr) : null,
      );
    }
    return null;
  }
}
