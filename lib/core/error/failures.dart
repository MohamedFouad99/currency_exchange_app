// date: 6 March 2025
// by: Fouad
// last modified at: 7 March 2025

/// Failure is an abstract class that holds a message of the failure.
/// All failures should extend this class.
abstract class Failure {
  /// The message of the failure.
  final String message;

  /// Creates a new [Failure] with the given message.
  const Failure(this.message);
}

// General failures
class ServerFailure extends Failure {
  ServerFailure([String? message])
    : super(message ?? "Something went wrong. Please try again later.");
}

class NetworkFailure extends Failure {
  NetworkFailure()
    : super("No internet connection. Please check your network.");
}

class CacheFailure extends Failure {
  CacheFailure() : super("No cached data available. Please try again later.");
}

class ValidationFailure extends Failure {
  ValidationFailure([String? message])
    : super(message ?? "Validation error occurred.");
}
