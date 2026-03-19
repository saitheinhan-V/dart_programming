//handle exception
abstract class AppException implements Exception {
  final String message;
  final DateTime timestamp;

  AppException(this.message) : timestamp = DateTime.now();

  @override
  String toString() => "$runtimeType: $message";
}

// Authentication exceptions
class AuthException extends AppException {
  AuthException(super.message);
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException() : super("Email or password is incorrect");
}

class AccountLockedException extends AuthException {
  final Duration lockDuration;

  AccountLockedException(this.lockDuration)
    : super("Account locked for ${lockDuration.inMinutes} minutes");
}

class SessionExpiredException extends AuthException {
  SessionExpiredException() : super("Your session has expired");
}

// Data validation exceptions
class ValidationException extends AppException {
  final Map<String, String> fieldErrors;

  ValidationException(super.message, this.fieldErrors);
}

// Usage with granular handling
void handleLogin(String email, String password) {
  try {
    authenticateUser(email, password);
  } on InvalidCredentialsException catch (e) {
    // Show "wrong password" UI
    print("Show error: ${e.message}");
    print("UI: Shake the login form");
  } on AccountLockedException catch (e) {
    // Show lockout timer
    print("Show lockout: ${e.message}");
    print("UI: Display countdown timer");
  } on SessionExpiredException catch (e) {
    // Redirect to login
    print("Redirect to: /login");
  } on ValidationException catch (e) {
    // Show field-specific errors
    e.fieldErrors.forEach((field, error) {
      print("$field error: $error");
    });
  } on AuthException catch (e) {
    // Catch-all for any auth error
    print("General auth error: ${e.message}");
  } catch (e) {
    // Unexpected error
    print("Unexpected error: $e");
  }
}

void authenticateUser(String email, String password) {
  // Simulate different failure scenarios
  if (password.isEmpty) {
    throw ValidationException("Validation failed", {
      'password': 'Password is required',
    });
  }

  if (password.length < 6 || email.isEmpty) {
    throw InvalidCredentialsException();
  }

  // Success case
  print("Login successful!");
}

void main() {
  handleLogin('sai@gmail.com', '123456');
}
