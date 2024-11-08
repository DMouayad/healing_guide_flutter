import 'package:equatable/equatable.dart';

class MedicalFacility extends Equatable {
  final String id;
  final String name;
  final String description;
  final String location;
  final String phoneNumber;
  final String emergencyNumber;
  final double rating;

  const MedicalFacility({
    required this.id,
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.emergencyNumber,
    required this.location,
    required this.rating,
  });
  @override
  List<Object?> get props =>
      [id, name, description, location, rating, phoneNumber, emergencyNumber];
}
