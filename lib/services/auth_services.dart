import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plantie/models/Post.dart';
import 'package:plantie/models/user.dart';
import 'package:plantie/services/firestore_services.dart';

Future<UserModel?> signInWithGoogle() async {
  // Trigger the authentication flow
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      var user = await FirebaseAuth.instance.signInWithCredential(credential);
      addUser(PostUser(
          id: user.user!.uid,
          name: user.user!.displayName!,
          email: user.user!.email!,
          imageUrl: user.user!.photoURL!));
      return const UserModel(userStatus: UserStatus.loggedIn);
    }
  } catch (e) {
    return const UserModel(userError: UserError.invalidCredentials);
  }
  return null;
}

Future<UserModel?> signOutWithGoogle() async {
  try {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    return const UserModel(userStatus: UserStatus.loggedOut);
  } catch (e) {
    return const UserModel(userError: UserError.invalidCredentials);
  }
}

Future<UserModel> signUpWithEmailAndPassword(
    String email, String password, String name) async {
  try {
    UserCredential result =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.user!.sendEmailVerification();
    result.user!.updateDisplayName(name);
    addUser(PostUser(
        id: result.user!.uid,
        name: result.user!.displayName!,
        email: result.user!.email!,
        imageUrl: result.user!.photoURL!));
    return const UserModel(
        userError: UserError.none, userStatus: UserStatus.loggedOut);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'wrong-password') {
      return const UserModel(
          userError: UserError.wrongPassword, userStatus: UserStatus.loggedOut);
    } else if (e.code == 'invalid-email') {
      return const UserModel(
          userError: UserError.invalidEmail, userStatus: UserStatus.loggedOut);
    } else if (e.code == 'email-already-in-use') {
      return const UserModel(
          userError: UserError.emailAlreadyInUse,
          userStatus: UserStatus.loggedOut);
    } else if (e.code == 'weak-password') {
      return const UserModel(
          userError: UserError.weakPassword, userStatus: UserStatus.loggedOut);
    }
    return const UserModel(
        userError: UserError.invalidCredentials,
        userStatus: UserStatus.loggedOut);
  }
}

Future<UserModel> signInWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (result.user!.emailVerified == false) {
      return const UserModel(
          userError: UserError.none, userStatus: UserStatus.loggedOut);
    }
    return const UserModel(
        userError: UserError.none, userStatus: UserStatus.loggedIn);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'wrong-password') {
      return const UserModel(
          userError: UserError.wrongPassword, userStatus: UserStatus.loggedOut);
    } else if (e.code == 'invalid-email') {
      return const UserModel(
          userError: UserError.invalidEmail, userStatus: UserStatus.loggedOut);
    }
    return const UserModel(
        userError: UserError.invalidCredentials,
        userStatus: UserStatus.loggedOut);
  }
}
