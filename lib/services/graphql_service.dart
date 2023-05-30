import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_app/configs/graphql_config.dart';
import 'package:flutter_app/models/term.dart';

class GetTermResponse {
  Term term;
  List<TermOption> options;

  GetTermResponse({required this.term, required this.options });
}

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.client;

  Future<GetTermResponse> getTerm() async {
    final String GET_NEWEST_TERM_QUERY = """
      query GetNewestTerm {
        terms(orderBy: version_DESC, first: 1) {
          id
          createdAt
          version
          description
        }
      }
    """;

    final String GET_NEWEST_TERM_OPTIONS_QUERY = """
      query GetNewestTermOptions(\$termId: ID!) {
        termOptions(where: {term: {id: \$termId}}) {
          id
          option {
            id
            title
            description
          }
        }
      }
    """;


    try {
      QueryResult resultTerm = await client.query(QueryOptions(document: gql(GET_NEWEST_TERM_QUERY)));
      if(resultTerm.hasException) throw Exception(resultTerm.hasException);
      List<Term> term = List<Term>.from(resultTerm.data?['terms'].map((item) => Term.fromMap(item)).toList());

      QueryResult resultOptions = await client.query(
        QueryOptions(
          document: gql(GET_NEWEST_TERM_OPTIONS_QUERY),
          variables: { "termId": term.first.id },
        ),
      );
      if(resultOptions.hasException) throw Exception(resultOptions.hasException);
      List<TermOption> options = List<TermOption>.from(resultOptions.data?['termOptions'].map((item) => TermOption.fromMap(item)).toList());

      return new GetTermResponse(term: term.first, options: options);    
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<bool> acceptTerm({required bool isAccepted, required String userId, required String termOptionId}) async {
    final String ACCEPT_TERM_OPTIONS_QUERY = """
      mutation AcceptTermOptions(\$isAccepted: Boolean!, \$userId: ID!, \$termOptionId: ID!) {
        createTermUserLog(
            data: {accepted: \$isAccepted, customer: {connect: {id: \$userId}}, termOption: {connect: {id: \$termOptionId}}}
        ) {
          id
        }
      }
    """;

    try {
       QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(ACCEPT_TERM_OPTIONS_QUERY),
          variables: { "isAccepted": isAccepted, "userId": userId, "termOptionId": termOptionId }
        ),
      );
      if(result.hasException) throw Exception(result.hasException);
      return true;    
    } catch (error) {
      return false; 
    }
  }

  Future<List<UserPreference>> getUserPreferences({required String userId, required String termId, required List<String> optionIds}) async {
    final String GET_USER_PREFERENCES_QUERY = """
      query GetPreferences(\$userId: ID!, \$termId: ID!, \$optionId: ID!) {
        termUserLogs(
          orderBy: createdAt_DESC
          where: {customer: {id: \$userId}, termOption: {term: {id: \$termId}, option: {id: \$optionId}}}
          first: 1
        ) {
          accepted
          termOption {
            id
            option {
              id
              title
              description
            }
          }
        }
      }
    """;

    List<UserPreference> preferences = [];

    try {
      for (String optionId in optionIds) {
        QueryResult result = await client.query(
          QueryOptions(
            document: gql(GET_USER_PREFERENCES_QUERY),
            variables: { "userId": userId, "termId": termId, "optionId": optionId },
          ),
        );
        if(result.hasException) throw Exception(result.hasException);
        List<UserPreference> userPreferences = List<UserPreference>.from(result.data?['termUserLogs'].map((item) => UserPreference.fromMap(item)).toList());
        if (userPreferences.isNotEmpty) preferences.add(userPreferences.first);
      }
      return preferences;    
    } catch (error) {
      throw Exception(error);
    }
  }
}