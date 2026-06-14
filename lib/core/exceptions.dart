/// Base exception class for the application.
abstract class AppExceptions implements Exception {
  final String message;
  AppExceptions(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when there is a network connectivity issue.
class NetworkException extends AppExceptions {
  NetworkException([super.message = 'Network connection error. Please check your internet.']);
}

/// Exception thrown when the API returns an error response.
class ApiException extends AppExceptions {
  ApiException([super.message = 'Failed to fetch data from the server.']);
}

/// Exception thrown when there is an error parsing data (e.g., JSON).
class ParseException extends AppExceptions {
  ParseException([super.message = 'Error parsing data.']);
}
