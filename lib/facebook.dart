import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignIn {
  /// Static method to sign in using Facebook
  static Future<UserCredential?> signInWithFacebook() async {
    try {
      final token = "a0411264c7c68f5303f4b99c251db4bf";
      // Trigger the Facebook sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // If the login was successful and token is available
      if (loginResult.status == LoginStatus.success &&
          loginResult.accessToken != null) {
        final accessToken = loginResult.accessToken!;

        // Create Facebook credential for Firebase
        final OAuthCredential facebookCredential =
            FacebookAuthProvider.credential(token);

        // Sign in to Firebase with Facebook credential
        return await FirebaseAuth.instance.signInWithCredential(
          facebookCredential,
        );
      } else {
        print("Facebook login failed: ${loginResult.message}");
        return null;
      }
    } catch (e) {
      print("Facebook login error: $e");
      return null;
    }
  }

  /// Optional: sign out from both Firebase and Facebook
  static Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }
}
