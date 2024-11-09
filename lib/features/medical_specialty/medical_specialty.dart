class MedicalSpecialty {
  final String name;
  final String id;
  final List<String> physicianIds;

  const MedicalSpecialty({
    required this.id,
    required this.name,
    this.physicianIds = const [],
  });
}
