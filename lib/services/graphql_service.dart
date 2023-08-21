import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:react_conf/utils/app_onstants.dart';

class GraphQLService {
  late GraphQLClient _client;

  GraphQLService() {
    final Link link = HttpLink(AppConstants.baseUrl);

    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }

  Future<QueryResult> performQuery(String query, Map<String, dynamic> variables) async {
    final WatchQueryOptions options = WatchQueryOptions(
      document: gql(query),
      variables: variables, // Include the variables in the options
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      debugPrint('GraphQL Exception: ${result.exception.toString()}');
    }
    return result;
  }
}
