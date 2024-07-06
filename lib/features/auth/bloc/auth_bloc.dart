import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kabotr/app.dart';
import 'package:kabotr/core/local_db/shared_pref_manager.dart';
import 'package:kabotr/features/auth/bloc/auth_event.dart';
import 'package:kabotr/features/auth/bloc/auth_state.dart';
import 'package:kabotr/features/auth/model/user_model.dart';
import 'package:kabotr/features/auth/repo/auth_repo.dart';

enum AuthType { login, register }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthenticationEvent>(authenticationEvent);
  }

  FutureOr<void> authenticationEvent(
      AuthenticationEvent event, Emitter<AuthState> emit) async {
    UserCredential? credential;

    switch (event.authType) {
      case AuthType.login:
        try {
          credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
        } on FirebaseAuthException catch (e) {
          switch (e.code) {
            case 'user-not-found':
              log('No user found for that email: ${event.email}');
              emit(AuthErrorState(
                  error: "No user found for the provided email."));
              break;
            case 'wrong-password':
              log('Wrong password provided for user: ${event.email}');
              emit(AuthErrorState(
                  error: "Incorrect password. Please try again."));
              break;
            default:
              log('Login failed: ${e.message}');
              emit(AuthErrorState(
                  error: "Login failed. Please try again later."));
          }
        } catch (e) {
          log('An error occurred during login: ${e.toString()}');
          emit(AuthErrorState(
              error: "An unexpected error occurred. Please try again later."));
        }
        break;

      case AuthType.register:
        try {
          credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
        } on FirebaseAuthException catch (e) {
          switch (e.code) {
            case 'weak-password':
              log('Weak password provided for email: ${event.email}');
              emit(AuthErrorState(
                  error:
                      'The password is too weak. Please choose a stronger password.'));
              break;
            case 'email-already-in-use':
              log('Account already exists for email: ${event.email}');
              emit(AuthErrorState(
                  error: 'An account already exists for this email.'));
              break;
            default:
              log('Registration failed: ${e.message}');
              emit(AuthErrorState(
                  error: "Registration failed. Please try again later."));
          }
        } catch (e) {
          log('An error occurred during registration: ${e.toString()}');
          emit(AuthErrorState(
              error: "An unexpected error occurred. Please try again later."));
        }
        break;
    }

    if (credential != null) {
      try {
        if (event.authType == AuthType.login) {
          UserModel? userModel =
              await AuthRepo.getUserRepo(credential.user?.uid ?? "");
          if (userModel != null) {
            await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
            DecidePage.authStream.add(credential.user?.uid ?? "");
            emit(AuthSuccessState());
          } else {
            emit(AuthErrorState(
                error: "User data retrieval failed. Please try again."));
          }
        } else if (event.authType == AuthType.register) {
          log('User registered with UID: ${credential.user?.uid}');
          bool success = await AuthRepo.createUserRepo(UserModel(
            uid: credential.user?.uid ?? "",
            patrs: [],
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            createdAt: DateTime.now(),
          ));
          if (success) {
            log('User created in repo with UID: ${credential.user?.uid}');
            await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
            DecidePage.authStream.add(credential.user?.uid ?? "");
            emit(AuthSuccessState());
          } else {
            emit(AuthErrorState(
                error: "User creation failed. Please try again."));
          }
        }
      } catch (e) {
        log('An error occurred while handling credential: ${e.toString()}');
        emit(AuthErrorState(
            error: "An unexpected error occurred. Please try again later."));
      }
    } else {
      log("Credential is null");
      emit(AuthErrorState(error: "Authentication failed. Please try again."));
    }
  }
}


// enum AuthType { login, register }

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc() : super(AuthInitial()) {
//     on<AuthenticationEvent>(authenticationEvent);
//   }

//   FutureOr<void> authenticationEvent(
//       AuthenticationEvent event, Emitter<AuthState> emit) async {
//     UserCredential? credential;

//     switch (event.authType) {
//       case AuthType.login:
//         try {
//           credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//               email: event.email, password: event.password);
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'user-not-found') {
//             log('No user found for that email.');
//             emit(AuthErrorState(error: "No user found for that email."));
//           } else if (e.code == 'wrong-password') {
//             log('Wrong password provided for that user.');
//             emit(AuthErrorState(
//                 error: "Wrong password provided for that user."));
//           }
//         }
//         break;

//       case AuthType.register:
//         try {
//           credential =
//               await FirebaseAuth.instance.createUserWithEmailAndPassword(
//             email: event.email,
//             password: event.password,
//           );
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'weak-password') {
//             log('The password provided is too weak.');
//             emit(AuthErrorState(error: 'The password provided is too weak.'));
//           } else if (e.code == 'email-already-in-use') {
//             log('The account already exists for that email.');
//             emit(AuthErrorState(
//                 error: 'The account already exists for that email.'));
//           }
//         } catch (e) {
//           log(e.toString());
//           emit(AuthErrorState(error: "Something went wrong"));
//         }
//     }

//     if (credential != null) {
//       if (event.authType == AuthType.login) {
//         UserModel? userModel =
//             await AuthRepo.getUserRepo(credential.user?.uid ?? "");
//         if (userModel != null) {
//           await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
//           DecidePage.authStream.add(credential.user?.uid ?? "");
//           emit(AuthSuccessState());
//         } else {
//           emit(AuthErrorState(error: "Something went wrong"));
//         }
//       } else if (event.authType == AuthType.register) {
//         log(credential.user?.uid ?? "");
//         bool success = await AuthRepo.createUserRepo(UserModel(
//             uid: credential.user?.uid ?? "",
//             patrs: [],
//             firstName: event.firstName,
//             lastName: event.lastName,
//             email: event.email,
//             createdAt: DateTime.now(),));
//         if (success) {
//           log(credential.user?.uid ?? "");
//           await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
//           DecidePage.authStream.add(credential.user?.uid ?? "");
//           emit(AuthSuccessState());
//         } else {
//           emit(AuthErrorState(error: "Something went wrong"));
//         }
//       }
//     } else {
//       log("Credential is null");
//       emit(AuthErrorState(error: "Something went wrong"));
//     }
//   }
// }
