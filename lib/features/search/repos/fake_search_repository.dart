part of '../repositories.dart';

final class FakeSearchRepository extends SearchRepository {
  @override
  List<SearchResult> _decodeResponseBody(JsonObject json) {
    List<SearchResult> results = [];
    if (json case {"facilities": List<JsonObject> facilitiesJson}) {
      for (var facilityJson in facilitiesJson) {
        if (facilityJson
            case {
              'id': String id,
              'name': String name,
              'location': String location,
              'emergencyNumber': String emergencyNumber,
              'phoneNumber': String phoneNumber,
              'rating': int rating
            }) {
          results.add(SearchResult(
            resourceId: id,
            category: SearchResultCategory.facility,
            title: name,
            subTitle: '$phoneNumber | $emergencyNumber',
            location: location,
            stars: rating,
            avatarImgUrl: kDefaultMedicalFacilityAvatarUrl,
          ));
        }
      }
    }
    if (json case {"physicians": List<JsonObject> physiciansJson}) {
      for (var physicianJson in physiciansJson) {
        if (physicianJson
            case {
              'id': String id,
              'name': String name,
              'location': String location,
              'dateOfBirth': String dateOfBirth,
              'isMale': bool isMale,
              'languages': String languages,
              'rating': int rating
            }) {
          results.add(SearchResult(
            resourceId: id,
            category: SearchResultCategory.physician,
            title: name,
            subTitle: '',
            location: location,
            stars: rating,
            avatarImgUrl:
                isMale ? kMalePhysicianAvatarUrl : kFemalePhysicianAvatarUrl,
          ));
        }
      }
    }
    return results;
  }

  @override
  Future<JsonObject> _searchAll(String searchTerm, SearchFilters filters) {
    return Future.delayed(const Duration(seconds: 2), () {
      return {
        "physicians": _generatePhysicians(10),
        "facilities": _generateMedicalFacilities(10),
      };
    });
  }

  @override
  Future<JsonObject> _searchDoctors(String searchTerm, SearchFilters filters) {
    return Future.delayed(const Duration(seconds: 2), () {
      return {"physicians": _generatePhysicians(10)};
    });
  }

  @override
  Future<JsonObject> _searchFacilities(
    String searchTerm,
    SearchFilters filters,
  ) {
    return Future.delayed(const Duration(seconds: 2), () {
      return {"facilities": _generateMedicalFacilities(10)};
    });
  }

  List<Map<String, dynamic>> _generateMedicalFacilities(int count) {
    final random = Random();
    final names = [
      'مستشفى العروبة',
      'مجمع الشفاء الطبي',
      'مركز البركة الصحي',
      'عيادة الأمل',
      'مستشفى الحياة',
      'مركز الدواء',
      'عيادة الأسرة',
      'مجمع النور الطبي'
    ];
    final cities = [
      'دمشق',
      'حلب',
      'حمص',
      'ادلب',
      'الرقة',
      'دير الزور',
      'الحسكة'
    ];
    final addresses = [
      'شارع المستقبل',
      'حي النور',
      'شارع الحمراء',
      'شارع بغداد',
      'حي الزهور'
    ];

    return List.generate(count, (index) {
      return {
        'id': index + 1,
        'name': names[random.nextInt(names.length)],
        'location':
            '${cities[random.nextInt(cities.length)]}, ${addresses[random.nextInt(addresses.length)]}',
        'emergencyNumber': '0${random.nextInt(999999999)}',
        'phoneNumber': '0${random.nextInt(999999999)}',
        'rating': random.nextDouble() * 5,
      };
    });
  }

  List<Map<String, dynamic>> _generatePhysicians(int count) {
    final random = Random();
    final names = [
      'علي',
      'محمد',
      'فهد',
      'سالم',
      'عبدالله',
      'أحمد',
      'خالد',
      'سعيد',
      'يوسف',
      'زايد'
    ];
    final cities = [
      'دمشق',
      'حلب',
      'حمص',
      'طرطوس',
      'اللاذقية',
      'ريف دمشق',
    ];
    final languages = [
      ['العربية', 'الإنجليزية'],
      ['العربية', 'الفرنسية'],
      ['العربية', 'الألمانية'],
      ['العربية', 'الإسبانية'],
      ['العربية', 'التركية']
    ];

    return List.generate(count, (index) {
      return {
        'id': index + 1,
        'name': names[random.nextInt(names.length)],
        'location': cities[random.nextInt(cities.length)],
        'dateOfBirth': DateTime(random.nextInt(100) + 1923,
                random.nextInt(12) + 1, random.nextInt(28) + 1)
            .toString(),
        'isMale': random.nextBool(),
        'rating': random.nextDouble() * 5,
        'languages': languages[random.nextInt(languages.length)],
      };
    });
  }
}
