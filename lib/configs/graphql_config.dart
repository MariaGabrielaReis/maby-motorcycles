import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static final HttpLink httpLink = HttpLink("https://api-sa-east-1.hygraph.com/v2/cli30jpvl12w401t7glnecxnv/master");

  final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
     defaultPolicies: DefaultPolicies(
        watchQuery: Policies(fetch: FetchPolicy.noCache),
        query: Policies(fetch: FetchPolicy.noCache),
        mutate: Policies(fetch: FetchPolicy.noCache),
      ),
  );
}