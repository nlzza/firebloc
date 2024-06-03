import 'user_data.dart';
import 'auth_status.dart';

class AuthState {
  final AuthStatus status;
  final UserData? user;

  const AuthState({
    required this.status,
    required this.user,
  });

  const AuthState.unauthenticated()
      : status = AuthStatus.unauthenticated,
        user = null;
}
