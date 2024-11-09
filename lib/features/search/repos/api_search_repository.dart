part of '../repositories.dart';

final class ApiSearchRepository extends SearchRepository {
  @override
  Future<JsonObject> _searchAll(String searchTerm, SearchFilters filters) {
    // TODO: implement _searchAll
    throw UnimplementedError();
  }

  @override
  Future<JsonObject> _searchDoctors(String searchTerm, SearchFilters filters) {
    return _requestUrl(searchTerm, ApiConfig.searchPhysiciansEndpoint, filters);
  }

  @override
  Future<JsonObject> _searchFacilities(
      String searchTerm, SearchFilters filters) {
    return _requestUrl(searchTerm, ApiConfig.searchFacilitiesEndpoint, filters);
  }

  Future<JsonObject> _requestUrl(
    String searchTerm,
    String endpoint,
    SearchFilters filters,
  ) {
    final url = [
      endpoint,
      '?q=$searchTerm',
      if (filters.asUrlParam(withCategory: false) case final filterParams
          when filterParams.isNotEmpty)
        '&$filterParams',
    ];
    return RestClient.instance.get(url.join());
  }

  @override
  List<SearchResult> _decodeResponseBody(JsonObject json) {
    List<SearchResult> searchResults = [];
    if (json case {"\$values": final List<JsonObject> resultsJson}) {
      if (_getPhysiciansResults(resultsJson) case final physicianResults
          when physicianResults.isNotEmpty) {
        searchResults.addAll(physicianResults);
      }
      if (_getFacilityResults(resultsJson) case final facilityResults
          when facilityResults.isNotEmpty) {
        searchResults.addAll(facilityResults);
      }
    }
    return searchResults;
  }

  List<SearchResult> _getFacilityResults(List<JsonObject> resultsJson) {
    return resultsJson
        .map(_medialFacilityFromJson)
        .whereType<MedicalFacility>()
        .map(SearchResult.facility)
        .toList();
  }

  MedicalFacility? _medialFacilityFromJson(JsonObject json) {
    if (json
        case {
          "\$id": String id,
          "name": String name,
          "phoneNumber": String phoneNumber,
          "emergencyNumber": String emergencyNumber,
          "rating": double rating,
        }) {
      return MedicalFacility(
        id: id,
        name: name,
        description: '',
        phoneNumber: phoneNumber,
        emergencyPhoneNumber: emergencyNumber,
        mobilePhoneNumber: '',
        location: '',
        rating: rating,
      );
    }
    return null;
  }

  Physician? _physicianFromJson(JsonObject json) {
    if (json
        case {
          "\$id": String id,
          "name": String name,
          "languages": String languages,
          "city": String location,
          "rating": double rating,
          "biography": String biography,
          "isMale": bool isMale,
          "dateOfBirth": String dateOfBirth,
          "specialties": JsonObject specialties,
          "shifts": JsonObject shifts,
        }) {
      return Physician(
        id: id,
        name: name,
        biography: biography,
        location: location,
        isMale: isMale,
        mobilePhoneNumber: '',
        dateOfBirth: DateTime.tryParse(dateOfBirth),
        languages: languages.split(', '),
        specialties: _getSpecialtiesFromJson(specialties),
        rating: rating,
      );
    }
    return null;
  }

  List<String> _getSpecialtiesFromJson(JsonObject json) {
    if (json['\$value'] case Iterable<String> items) {
      return items.toList();
    }
    return [];
  }

  List<SearchResult> _getPhysiciansResults(List<JsonObject> resultsJson) {
    return resultsJson
        .map(_physicianFromJson)
        .whereType<Physician>()
        .map(SearchResult.physician)
        .toList();
  }
}
