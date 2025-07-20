import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignIn {
  /// Static method to sign in using Facebook
  static Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the Facebook sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.nativeWithFallback,
        loginTracking: LoginTracking.limited,
      );

      // If the login was successful and token is available
      if (loginResult.status == LoginStatus.success &&
          loginResult.accessToken != null) {
        final accessToken = loginResult.accessToken!;
        //final token = "a0411264c7c68f5303f4b99c251db4bf";
        // Create Facebook credential for Firebase
        final OAuthCredential facebookCredential =
            FacebookAuthProvider.credential(accessToken.tokenString);

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

  static Future<UserCredential> signInFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
