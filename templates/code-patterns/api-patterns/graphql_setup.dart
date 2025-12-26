import 'package:graphql/client.dart';
import 'package:flutter/foundation.dart';

/// GraphQL Client Setup Template for Flutter Apps
/// This template provides a robust GraphQL client configuration with:
/// - Apollo-style query and mutation management
/// - Automatic authentication token management
/// - Request/response logging
/// - Error handling and retry logic
/// - Caching configuration

class GraphQLClientService {
  static const String _graphQLEndpoint = 'https://api.example.com/graphql'; // Replace with your GraphQL endpoint
  static const String _wsEndpoint = 'wss://api.example.com/graphql'; // WebSocket endpoint for subscriptions

  late final GraphQLClient _client;
  late final GraphQLCache _cache;

  GraphQLClientService() {
    _cache = GraphQLCache(store: InMemoryStore());
    _client = GraphQLClient(
      link: _createLink(),
      cache: _cache,
    );
  }

  Link _createLink() {
    // Authentication link
    final authLink = AuthLink(
      getToken: () async => await _getAuthToken(),
    );

    // HTTP link with error handling
    final httpLink = HttpLink(_graphQLEndpoint);

    // WebSocket link for subscriptions (optional)
    final wsLink = WebSocketLink(
      _wsEndpoint,
      config: const SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
      ),
    );

    // Split link to route queries/mutations to HTTP and subscriptions to WebSocket
    final splitLink = Link.split(
      (request) => request.isSubscription,
      wsLink,
      authLink.concat(httpLink),
    );

    return splitLink;
  }

  Future<String?> _getAuthToken() async {
    // TODO: Implement token retrieval from secure storage
    // Example: return 'Bearer ${await SecureStorage.getToken()}';
    return null;
  }

  // Query execution with error handling
  Future<QueryResult> query({
    required String query,
    Map<String, dynamic> variables = const {},
    FetchPolicy? fetchPolicy,
    ErrorPolicy? errorPolicy,
    CacheRereadPolicy? cacheRereadPolicy,
    Duration? pollInterval,
  }) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables,
      fetchPolicy: fetchPolicy ?? FetchPolicy.cacheFirst,
      errorPolicy: errorPolicy ?? ErrorPolicy.all,
      cacheRereadPolicy: cacheRereadPolicy,
      pollInterval: pollInterval,
    );

    try {
      final result = await _client.query(options);
      _logResult('QUERY', query, variables, result);
      return result;
    } catch (e) {
      _logError('QUERY', query, variables, e);
      rethrow;
    }
  }

  // Mutation execution with error handling
  Future<QueryResult> mutate({
    required String mutation,
    Map<String, dynamic> variables = const {},
    FetchPolicy? fetchPolicy,
    ErrorPolicy? errorPolicy,
    CacheRereadPolicy? cacheRereadPolicy,
    OptimisticResult? optimisticResult,
  }) async {
    final options = MutationOptions(
      document: gql(mutation),
      variables: variables,
      fetchPolicy: fetchPolicy ?? FetchPolicy.cacheAndNetwork,
      errorPolicy: errorPolicy ?? ErrorPolicy.all,
      cacheRereadPolicy: cacheRereadPolicy,
      optimisticResult: optimisticResult,
    );

    try {
      final result = await _client.mutate(options);
      _logResult('MUTATION', mutation, variables, result);
      return result;
    } catch (e) {
      _logError('MUTATION', mutation, variables, e);
      rethrow;
    }
  }

  // Subscription setup
  Stream<QueryResult> subscribe({
    required String subscription,
    Map<String, dynamic> variables = const {},
    FetchPolicy? fetchPolicy,
    ErrorPolicy? errorPolicy,
  }) {
    final options = SubscriptionOptions(
      document: gql(subscription),
      variables: variables,
      fetchPolicy: fetchPolicy ?? FetchPolicy.cacheAndNetwork,
      errorPolicy: errorPolicy ?? ErrorPolicy.all,
    );

    final stream = _client.subscribe(options);

    return stream.map((result) {
      _logResult('SUBSCRIPTION', subscription, variables, result);
      return result;
    }).handleError((error) {
      _logError('SUBSCRIPTION', subscription, variables, error);
    });
  }

  // Cache management
  void clearCache() {
    _cache.store.reset();
  }

  void clearCacheForId(String id) {
    _cache.evict(CacheId(id));
  }

  // Logging helpers
  void _logResult(String type, String operation, Map<String, dynamic> variables, QueryResult result) {
    if (kDebugMode) {
      print('📡 $type SUCCESS: ${operation.substring(0, min(50, operation.length))}...');
      if (variables.isNotEmpty) {
        print('Variables: $variables');
      }
      if (result.hasException) {
        print('GraphQL Errors: ${result.exception}');
      }
      if (result.data != null) {
        print('Data: ${result.data}');
      }
    }
  }

  void _logError(String type, String operation, Map<String, dynamic> variables, dynamic error) {
    if (kDebugMode) {
      print('❌ $type ERROR: ${operation.substring(0, min(50, operation.length))}...');
      if (variables.isNotEmpty) {
        print('Variables: $variables');
      }
      print('Error: $error');
    }
  }

  // Get the client for advanced usage
  GraphQLClient get client => _client;

  // Helper function (Dart doesn't have min function like other languages)
  int min(int a, int b) => a < b ? a : b;
}

// Custom exceptions for GraphQL operations
class GraphQLException implements Exception {
  final String message;
  final List<GraphQLError>? errors;

  GraphQLException(this.message, [this.errors]);

  @override
  String toString() {
    String result = 'GraphQLException: $message';
    if (errors != null && errors!.isNotEmpty) {
      result += '\nErrors: ${errors!.map((e) => e.message).join(', ')}';
    }
    return result;
  }
}

// Common GraphQL queries and mutations
class GraphQLQueries {
  // Example query
  static const String getUsers = r'''
    query GetUsers($limit: Int, $offset: Int) {
      users(limit: $limit, offset: $offset) {
        id
        name
        email
        createdAt
      }
    }
  ''';

  // Example mutation
  static const String createUser = r'''
    mutation CreateUser($input: CreateUserInput!) {
      createUser(input: $input) {
        id
        name
        email
        createdAt
      }
    }
  ''';

  // Example subscription
  static const String userCreated = r'''
    subscription UserCreated {
      userCreated {
        id
        name
        email
        createdAt
      }
    }
  ''';
}

// Usage examples:
/*
void main() async {
  final graphQLClient = GraphQLClientService();

  try {
    // Query example
    final queryResult = await graphQLClient.query(
      query: GraphQLQueries.getUsers,
      variables: {'limit': 10, 'offset': 0},
    );

    if (queryResult.hasException) {
      throw GraphQLException('Query failed', queryResult.exception?.graphqlErrors);
    }

    final users = queryResult.data?['users'];
    print('Users: $users');

    // Mutation example
    final mutationResult = await graphQLClient.mutate(
      query: GraphQLQueries.createUser,
      variables: {
        'input': {
          'name': 'John Doe',
          'email': 'john@example.com',
        }
      },
    );

    if (mutationResult.hasException) {
      throw GraphQLException('Mutation failed', mutationResult.exception?.graphqlErrors);
    }

    final newUser = mutationResult.data?['createUser'];
    print('Created user: $newUser');

    // Subscription example
    final subscription = graphQLClient.subscribe(
      subscription: GraphQLQueries.userCreated,
    );

    subscription.listen((result) {
      if (result.hasException) {
        print('Subscription error: ${result.exception}');
      } else {
        print('New user created: ${result.data}');
      }
    });

  } catch (e) {
    print('GraphQL Error: $e');
  }
}
*/