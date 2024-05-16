import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantie/services/auth_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(Unauthenticated());
        } else {
          debugPrint("user: $user");
          emit(Authenticated(user: user));
        }
      } catch (e) {
        print(e);
      }
    });
    on<LoggedOut>((event, emit) async {
      await signOutWithGoogle();
      await FirebaseAuth.instance.signOut();
      emit(Unauthenticated());
    });
    on<LoggedIn>((event, emit) async {
      emit(Loading());
      await signInWithGoogle();
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(Unauthenticated());
      } else
        emit(Authenticated(user: user));
    });
  }
}
