import 'dart:convert';

import '../models/conf_info_model.dart';
import '../models/conf_list_model.dart';
import '../models/sponsors_model.dart';
import '../services/graphql_service.dart';
import '../utils/app_onstants.dart';

class ApiMethods {
  final GraphQLService _graphQLService = GraphQLService();

  Future<List<Conference>?> fetchPosts() async {
    List<Conference> conferenceList = [];
    final result = await _graphQLService.performQuery(AppConstants.queryAllConferences, {});

    if (!result.hasException) {
      conferenceList = (result.data!['allConferences'] as List<dynamic>).map((conferenceJson) => Conference.fromJson(conferenceJson)).toList();

      return conferenceList;
    }
    return null;
  }

  Future<ConferenceInfoModel> fetchConferenceById(String id) async {
    final result = await _graphQLService.performQuery(AppConstants.conferenceByIdQuery, {'id': id});

    ConferenceInfoModel conferenceInfoModel = ConferenceInfoModel();

    if (!result.hasException) {
      conferenceInfoModel = ConferenceInfoModel.fromJson(result.data?['conference'] ?? {});
    }
    return conferenceInfoModel;
  }

  // Future<SponsorModel> fetchSponsors() async {
  //   final result = await _graphQLService.performQuery(AppConstants.queryAllSponsors, {});
  //
  //   SponsorModel sponsor = SponsorModel();
  //
  //   if (!result.hasException) {
  //     final jsonData = json.decode(result.data?['data']);
  //     sponsor = SponsorModel.fromJson(jsonData);
  //   }
  //   return sponsor;
  // }

  Future<List<SponsorModel>?> fetchSponsors() async {
    List<SponsorModel> sponsorList = [];
    final result = await _graphQLService.performQuery(AppConstants.queryAllSponsors, {});

    if (!result.hasException) {
      sponsorList = (result.data!['sponsors'] as List<dynamic>).map((sponsorsJson) => SponsorModel.fromJson(sponsorsJson)).toList();

      return sponsorList;
    }
    return null;
  }


}
