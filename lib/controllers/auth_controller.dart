import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reactive variables
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getter for the current user
  User? get user => _auth.currentUser;

  // Getters
  bool get isLoading => _isLoading.value;
  RxString get errorMessage => _errorMessage;

  // Clear error message
  void clearError() {
    _errorMessage.value = '';
  }

  // Register a user (candidat or entreprise)
  Future<void> registerUser({
    required String email,
    required String password,
    required String role,
    required bool agreeToTerms,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage.value = "Please fill in both email and password fields.";
      return;
    }

    if (password.length < 6) {
      _errorMessage.value = "Password must be at least 6 characters.";
      return;
    }

    if (!agreeToTerms) {
      _errorMessage.value = "Please agree to the terms and conditions.";
      return;
    }

    _isLoading.value = true;

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email.trim(),
          'role': role,
          'createdAt': Timestamp.now(),
        });

        Get.offNamed('/login'); // Navigate to login
      } else {
        _errorMessage.value = "Failed to create user.";
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          _errorMessage.value = "The email is already in use.";
          break;
        case 'invalid-email':
          _errorMessage.value = "The email is invalid.";
          break;
        case 'weak-password':
          _errorMessage.value = "The password is too weak.";
          break;
        default:
          _errorMessage.value = e.message ?? "Registration failed.";
      }
    } catch (e) {
      _errorMessage.value = "An unexpected error occurred: $e";
    } finally {
      _isLoading.value = false;
    }
  }

  // Login a user
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage.value = "Please fill in both email and password fields.";
      return;
    }

    _isLoading.value = true;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          await _auth.signOut();
          _errorMessage.value = "User data not found.";
          return;
        }

        final userData = userDoc.data() as Map<String, dynamic>;
        final role = userData['role'] as String?;

        if (role == 'candidat') {
          Get.offNamed('homeEmployer');
        } else if (role == 'entreprise') {
          Get.offNamed('homeEntreprise');
        } else if (role == 'admin') {
          Get.offNamed('adminDashboard');
        } else {
          await _auth.signOut();
          _errorMessage.value = "You are not authorized to access. Only candidats and entreprises are allowed.";
        }
      } else {
        _errorMessage.value = "Login failed.";
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          _errorMessage.value = "No user found with this email.";
          break;
        case 'wrong-password':
          _errorMessage.value = "Incorrect password.";
          break;
        case 'invalid-email':
          _errorMessage.value = "The email is invalid.";
          break;
        default:
          _errorMessage.value = e.message ?? "Login failed.";
      }
    } catch (e) {
      _errorMessage.value = "An unexpected error occurred: $e";
    } finally {
      _isLoading.value = false;
    }
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:logging/logging.dart';
// import 'package:flutter/material.dart';

// class AuthController extends GetxController {
//   final _logger = Logger('AuthController');

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   final RxBool isLoading = false.obs;
//   final Rx<User?> currentUser = Rx<User?>(null);
//   final RxString userRole = ''.obs; // Default to empty string
//   final RxString userId = ''.obs; // Default to empty string instead of nullable

//   @override
//   void onInit() {
//     super.onInit();
//     // Register this controller as a singleton
//     Get.put(this);
//     // Listen to auth state changes
//     _auth.authStateChanges().listen((User? user) {
//       currentUser.value = user;
//       if (user != null) {
//         userId.value = user.uid; // Set user ID when authenticated
//         _fetchUserRole(user.uid);
//       } else {
//         userId.value = ''; // Set to empty string when not authenticated
//         userRole.value = '';
//       }
//     });
//   }

//   Future<void> _fetchUserRole(String uid) async {
//     try {
//       final userDoc = await _firestore.collection('users').doc(uid).get();
//       if (userDoc.exists) {
//         userRole.value = (userDoc.data()?['role'] as String?)?.toLowerCase() ?? '';
//       }
//     } catch (e) {
//       _logger.severe('Error fetching user role: $e');
//       userRole.value = '';
//     }
//   }

//   Future<String> getUserId() async {
//     try {
//       final user = currentUser.value;
//       if (user == null) {
//         _logger.warning('No user is currently signed in');
//         return ''; // Return empty string if no user is signed in
//       }
//       userId.value = user.uid; // Update userId
//       return user.uid;
//     } catch (e) {
//       _logger.severe('Error getting user ID: $e');
//       return ''; // Return empty string on error
//     }
//   }

//   Future<Map<String, dynamic>?> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     isLoading.value = true;
//     try {
//       final credential = await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );

//       final user = credential.user;
//       if (user != null) {
//         final userDoc = await _firestore.collection('users').doc(user.uid).get();

//         if (userDoc.exists) {
//           final role = userDoc.data()?['role'] as String?;
//           if (role == null) {
//             Get.snackbar(
//               'Error',
//               'User role not found in Firestore.',
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.red,
//               colorText: Colors.white,
//               margin: const EdgeInsets.all(10),
//               titleText: Text(
//                 'Error',
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               messageText: Text(
//                 'User role not found in Firestore.',
//                 style: GoogleFonts.poppins(color: Colors.white),
//               ),
//             );
//             await _auth.signOut();
//             isLoading.value = false;
//             return null;
//           }

//           currentUser.value = user;
//           userId.value = user.uid; // Save user ID immediately after sign-in
//           userRole.value = role.toLowerCase();

//           _logger.info('User signed in: ${user.email}, Role: $role');
//           isLoading.value = false;
//           return {
//             'user': user,
//             'role': role.toLowerCase(),
//           };
//         } else {
//           Get.snackbar(
//             'Error',
//             'User data not found in Firestore.',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//             margin: const EdgeInsets.all(10),
//             titleText: Text(
//               'Error',
//               style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             messageText: Text(
//               'User data not found in Firestore.',
//               style: GoogleFonts.poppins(color: Colors.white),
//             ),
//           );
//           await _auth.signOut();
//           isLoading.value = false;
//           return null;
//         }
//       }
//       isLoading.value = false;
//       return null;
//     } on FirebaseAuthException catch (e) {
//       String message;
//       switch (e.code) {
//         case 'user-not-found':
//           message = 'No user found with this email.';
//           break;
//         case 'wrong-password':
//           message = 'Incorrect password.';
//           break;
//         case 'network-request-failed':
//           message = 'Network error: Please check your internet connection.';
//           break;
//         default:
//           message = 'Error: ${e.message}';
//       }

//       Get.snackbar(
//         'Error',
//         message,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         margin: const EdgeInsets.all(10),
//         titleText: Text(
//           'Error',
//           style: GoogleFonts.poppins(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         messageText: Text(
//           message,
//           style: GoogleFonts.poppins(color: Colors.white),
//         ),
//       );
//       _logger.warning('Sign-in error: ${e.code}, ${e.message}');
//       isLoading.value = false;
//       return null;
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'An unexpected error occurred: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         margin: const EdgeInsets.all(10),
//         titleText: Text(
//           'Error',
//           style: GoogleFonts.poppins(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         messageText: Text(
//           'An unexpected error occurred: $e',
//           style: GoogleFonts.poppins(color: Colors.white),
//         ),
//       );
//       _logger.severe('Unexpected error during sign-in: $e');
//       isLoading.value = false;
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//       currentUser.value = null;
//       userId.value = ''; // Clear user ID on sign-out
//       userRole.value = '';
//       _logger.info('User signed out successfully');
//     } catch (e) {
//       _logger.severe('Error signing out: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to sign out: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         margin: const EdgeInsets.all(10),
//         titleText: Text(
//           'Error',
//           style: GoogleFonts.poppins(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         messageText: Text(
//           'Failed to sign out: $e',
//           style: GoogleFonts.poppins(color: Colors.white),
//         ),
//       );
//     }
//   }
// }