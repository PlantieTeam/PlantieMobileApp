import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> signInWithGoogle() async {
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

      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  } catch (e) {
    return null;
  }
}

Future<void> signOutWithGoogle() async {
  try {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  } catch (e) {
    print("Failed to sign out with Google. Error: $e");
  }
}
