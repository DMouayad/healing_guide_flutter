import 'package:equatable/equatable.dart';

class Physician extends Equatable {
  final String id;
  final String name;
  final String biography;
  final String location;
  final bool isMale;
  final DateTime? dateOfBirth;
  final List<String> languages;
  final List<String> specialties;
  final double rating;

  const Physician({
    required this.id,
    required this.name,
    required this.biography,
    required this.location,
    required this.isMale,
    required this.dateOfBirth,
    required this.rating,
    required this.specialties,
    this.languages = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        biography,
        isMale,
        dateOfBirth,
        languages,
        rating,
        specialties
      ];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "biography": biography,
      "location": location,
      "isMale": isMale,
      "dateOfBirth": dateOfBirth?.toIso8601String(),
      "rating": rating,
      "languages": languages,
      "specialties": specialties,
    };
  }

  static Physician? fromJson(Map<String, dynamic> json) {
    if (json
        case {
          "id": String id,
          "name": String name,
          "biography": String biography,
          "location": String location,
          "dateOfBirth": String? dateOfBirthStr,
          "isMale": bool isMale,
          "rating": double rating,
          "languages": List<String> languages,
          "specialties": List<String> specialties,
        }) {
      return Physician(
        id: id,
        name: name,
        biography: biography,
        location: location,
        rating: rating,
        languages: languages,
        specialties: specialties,
        isMale: isMale,
        dateOfBirth:
            dateOfBirthStr != null ? DateTime.tryParse(dateOfBirthStr) : null,
      );
    }
    return null;
  }
}
