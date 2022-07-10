import 'package:mynote/services/auth/auth_user.dart';
import 'package:mynote/services/auth/auth_provider.dart';
import 'package:mynote/services/auth/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email, 
    required String password,
  }) async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password
        );
        final user = currentUser;
        if (user != null){
          return user;
        }
        else{
          throw UserNotLoggedInAuthExceotion();
        }
    } on FirebaseAuthException catch(e) {
                  if (e.code == 'weak-password'){
                    throw WeakPasswordAuthExceotion();
                  }
                  else if(e.code=='email-already-in-use'){
                    throw EmailAlreadyInUseAuthExceotion();
                  }
                  else if(e.code=='invalid-email'){
                    throw InvaidEmailAuthExceotion();
                  }
                  else{
                    throw GenericAuthExceotion();
                  }

    } catch (_) {
      throw GenericAuthExceotion();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else{
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password);
        final user = currentUser;
        if (user != null){
          return user;
        }
        else{
          throw UserNotLoggedInAuthExceotion();
        }

    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found'){
          throw UserNotFoundAuthException();     
                  }
                  else if(e.code=='wrong-password'){
                    throw WrongPasswordAuthExcpetion();
                  }
                  else {
                    throw GenericAuthExceotion();
                  }
                }
                catch (_) {
                 throw GenericAuthExceotion();
                }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      await FirebaseAuth.instance.signOut();
    }
    else{
      throw UserNotLoggedInAuthExceotion();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthExceotion();
    }
  }
  
}
