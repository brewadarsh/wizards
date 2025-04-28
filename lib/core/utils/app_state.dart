/// To make the generic fetch states of Bloc simpler.
sealed class AppState<T> {
  const AppState();
}

/// The process is in loading state.
final class Loading<T> extends AppState<T> {
  const Loading();
}

/// The process has completed successfully.
final class Loaded<T> extends AppState<T> {
  /// The expected data on process completion.
  final T data;

  const Loaded(this.data);
}

/// The process aborted with error.
final class Error<T> extends AppState<T> {
  /// The error.
  final String error;

  const Error(this.error);
}
