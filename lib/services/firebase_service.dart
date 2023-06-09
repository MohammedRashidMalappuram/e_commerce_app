import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final _googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() async {
    FirebaseAuth.instance;
    await _googleSignIn.signOut();
    FirebaseAuth.instance.signOut(); 
  }
}

class Firestore {
  Future adduserdetails(String name,String email,String password) async {
    await FirebaseFirestore.instance
        .collection('samples')
        .add({"name": name, "email": email,"password":password});
  }
}
