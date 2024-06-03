import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/auth_state.dart';
import '../entities/auth_status.dart';
import '../entities/user_data.dart';

sealed class AuthEvent {}

class AuthFetchEvent extends AuthEvent {
  final String uid;

  AuthFetchEvent({required this.uid});
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(
          const AuthState.unauthenticated(),
        ) {
    on<AuthFetchEvent>(_fetchUser);
  }

  FutureOr<void> _fetchUser(AuthFetchEvent event, Emitter<AuthState> emit) async {
    final data = await FirebaseFirestore.instance.collection('users').doc(event.uid).get();
    final user = UserData.fromMap(data.data()!);
    emit(
      AuthState(
        status: AuthStatus.authenticated,
        user: user,
      ),
    );
  }
}
