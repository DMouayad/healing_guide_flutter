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
    final results = <SearchResult>[];
    for (var item in resultsJson) {
      if (item
          case {
            "id": String id,
            "name": String name,
            "phoneNumber": String phoneNumber,
            "emergencyNumber": String emergencyNumber,
            "rating": int rating,
          }) {
        results.add(SearchResult(
          resourceId: id,
          category: SearchResultCategory.facility,
          title: name,
          subTitle: emergencyNumber,
          location: phoneNumber,
          stars: rating,
          avatarImgUrl: kDefaultMedicalFacilityAvatarUrl,
        ));
      }
    }
    return results;
  }

  List<SearchResult> _getPhysiciansResults(List<JsonObject> resultsJson) {
    final results = <SearchResult>[];
    for (var item in resultsJson) {
      if (item
          case {
            "\$id": String id,
            "name": String name,
            "languages": String languages,
            "city": String city,
            "rating": int rating,
            "biography": String biography,
            "isMale": bool isMale,
            "dateOfBirth": String dateOfBirth,
          }) {
        results.add(SearchResult(
          resourceId: id,
          category: SearchResultCategory.physician,
          title: name,
          subTitle: '',
          location: city,
          stars: rating,
          avatarImgUrl:
              isMale ? kMalePhysicianAvatarUrl : kFemalePhysicianAvatarUrl,
        ));
      }
    }
    return results;
  }
}
