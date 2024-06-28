import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantie/models/user.dart';
import 'package:plantie/services/auth_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(const Unauthenticated());
        } else {
          debugPrint("user: $user");
          emit(Authenticated(user: user));
        }
      } catch (e) {
        emit(const Unauthenticated());
      }
    });
    on<LoggedOut>((event, emit) async {
      emit(Loading());
      await signOutWithGoogle();
      emit(const Unauthenticated());
    });
    on<LoggedInWithGoogle>((event, emit) async {
      emit(Loading());
      UserModel? user = await signInWithGoogle();
      if (user == null && user!.userStatus == UserStatus.loggedOut) {
        emit(const Unauthenticated());
      } else {
        emit(Authenticated(user: FirebaseAuth.instance.currentUser!));
      }
    });
    on<SignUp>((event, emit) async {
      UserModel result = await signUpWithEmailAndPassword(
          event.email, event.password, event.name);
      final user = FirebaseAuth.instance.currentUser;
      if (result.userError == UserError.none &&
          result.userStatus == UserStatus.loggedIn &&
          user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated(message: errorMassages[result.userError]!));
      }
    });
    on<LoggedIn>((event, emit) async {
      emit(Loading());
      UserModel result =
          await signInWithEmailAndPassword(event.email, event.password);
      final user = FirebaseAuth.instance.currentUser;
      if (result.userError == UserError.none && user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated(message: errorMassages[result.userError]!));
      }
    });
  }
}
