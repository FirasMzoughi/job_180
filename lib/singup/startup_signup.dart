import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class StartupSignupScreen extends StatefulWidget {
  const StartupSignupScreen({super.key});

  @override
  _StartupSignupScreenState createState() => _StartupSignupScreenState();
}

class _StartupSignupScreenState extends State<StartupSignupScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _agreeToTerms = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Initialize AuthController with GetX
    Get.put(AuthController(), permanent: true); // Use permanent to reuse existing instance
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access AuthController
    final authController = Get.find<AuthController>();

    // Listen for error messages using the RxString
    ever(authController.errorMessage, (String? error) {
      if (error != null && error.isNotEmpty) {
        _showError(error);
        authController.clearError();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/grocery-store.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Create entreprise Account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "Join Carthage Store as a entreprise!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      prefixIcon: const Icon(Icons.email_outlined, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),

                  // Password Field
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  const SizedBox(height: 15),

                  // Terms Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreeToTerms = value ?? false;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      Expanded(
                        child: Text(
                          "I agree to the Terms and Conditions and Privacy Policy",
                          style: TextStyle(color: Colors.grey[700], fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Register Button
                  Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                      ),
                      onPressed: authController.isLoading
                          ? null
                          : () {
                              authController.registerUser(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                role: 'entreprise',
                                agreeToTerms: _agreeToTerms,
                              );
                            },
                      child: authController.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Create entreprise Account",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Divider OR
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[400])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "OR",
                          style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey[400])),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Social buttons (mock)
                  SocialSigninButton(
                    icon: Icons.g_mobiledata,
                    text: "Sign up with Google",
                    color: Colors.white,
                    textColor: Colors.black87,
                    borderColor: Colors.grey[300],
                    onPressed: () {
                      _showError("Sign up with Google is not implemented yet.");
                    },
                  ),
                  const SizedBox(height: 15),
                  SocialSigninButton(
                    icon: Icons.facebook,
                    text: "Sign up with Facebook",
                    color: const Color(0xFF1877F2),
                    textColor: Colors.white,
                    onPressed: () {
                      _showError("Sign up with Facebook is not implemented yet.");
                    },
                  ),
                  const SizedBox(height: 15),
                  SocialSigninButton(
                    icon: Icons.apple,
                    text: "Sign up with Apple",
                    color: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {
                      _showError("Sign up with Apple is not implemented yet.");
                    },
                  ),
                  const SizedBox(height: 20),

                  // Link to login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/login');
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Social Signin Button
class SocialSigninButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  const SocialSigninButton({
    required this.icon,
    required this.text,
    required this.color,
    required this.textColor,
    this.borderColor,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
        ),
        elevation: 2,
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: textColor, size: 24),
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
} 
// // ignore_for_file: use_key_in_widget_constructors
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class StartupSignupScreen extends StatefulWidget {
//   const StartupSignupScreen({super.key});

//   @override
//   _StartupSignupScreenState createState() => _StartupSignupScreenState();
// }

// class _StartupSignupScreenState extends State<StartupSignupScreen> with SingleTickerProviderStateMixin {
//   final _companyNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   bool _agreeToTerms = false;
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _companyNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> _signUp() async {
//     if (_isLoading) return;
//     setState(() => _isLoading = true);

//     // Input validation
//     if (_companyNameController.text.trim().isEmpty) {
//       _showErrorDialog("Please enter your company name.");
//       setState(() => _isLoading = false);
//       return;
//     }
//     if (_emailController.text.trim().isEmpty) {
//       _showErrorDialog("Please enter your company email.");
//       setState(() => _isLoading = false);
//       return;
//     }
//     if (!_emailController.text.trim().contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
//       _showErrorDialog("Please enter a valid email address.");
//       setState(() => _isLoading = false);
//       return;
//     }
//     if (_passwordController.text.trim().isEmpty) {
//       _showErrorDialog("Please enter a password.");
//       setState(() => _isLoading = false);
//       return;
//     }
//     if (_passwordController.text.trim().length < 6) {
//       _showErrorDialog("Password must be at least 6 characters long.");
//       setState(() => _isLoading = false);
//       return;
//     }
//     if (_confirmPasswordController.text.trim().isEmpty) {
//       _showErrorDialog("Please confirm your password.");
//       setState(() => _isLoading = false);
//       return;
//     }
//     if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
//       _showErrorDialog("Passwords do not match.");
//       setState(() => _isLoading = false);
//       return;
//     }
//     if (!_agreeToTerms) {
//       _showErrorDialog("You must agree to the Terms & Conditions.");
//       setState(() => _isLoading = false);
//       return;
//     }

//     try {
//       // Create user with Firebase Authentication
//       final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );

//       // Store user data in Firestore
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .set({
//         'companyName': _companyNameController.text.trim(),
//         'email': _emailController.text.trim(),
//         'role': 'entreprise', // Already set as 'entreprise'
//         'createdAt': Timestamp.now(),
//       });

//       // Navigate to login screen
//       Navigator.pushNamed(context, 'login');
//     } on FirebaseAuthException catch (e) {
//       String errorMessage;
//       switch (e.code) {
//         case 'email-already-in-use':
//           errorMessage = 'This email is already registered.';
//           break;
//         case 'invalid-email':
//           errorMessage = 'The email address is invalid.';
//           break;
//         case 'weak-password':
//           errorMessage = 'The password is too weak.';
//           break;
//         case 'network-request-failed':
//           errorMessage = 'Network error: Please check your internet connection and try again.';
//           break;
//         default:
//           errorMessage = e.message ?? 'An error occurred during registration.';
//       }
//       _showErrorDialog(errorMessage);
//     } catch (e) {
//       if (e.toString().contains('network') || e.toString().contains('timeout')) {
//         _showErrorDialog('Network error: Please check your internet connection and try again.');
//       } else {
//         _showErrorDialog('An unexpected error occurred: $e');
//       }
//     }
//     setState(() => _isLoading = false);
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text("Error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
//             child: FadeInUp(
//               duration: const Duration(milliseconds: 800),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Back Button and Logo Row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         icon: const Icon(
//                           Icons.arrow_back_ios_new,
//                           color: Color(0xFF1976D2),
//                           size: 28,
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context); // Navigate back to WelcomePage
//                         },
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF42A5F5).withOpacity(0.1),
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 8,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: const Icon(
//                           Icons.business,
//                           size: 40,
//                           color: Color(0xFF1976D2),
//                         ),
//                       ),
//                       const SizedBox(width: 40),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   // Title
//                   Text(
//                     "Startup Signup",
//                     style: GoogleFonts.poppins(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black87,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Create your startup account on Job360!",
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   // Company Name Field
//                   TextField(
//                     controller: _companyNameController,
//                     decoration: InputDecoration(
//                       labelText: "Company Name",
//                       labelStyle: TextStyle(color: Colors.grey[700]),
//                       prefixIcon: const Icon(Icons.business, color: Color(0xFF1976D2)),
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   // Email Field
//                   TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       labelText: "Company Email",
//                       labelStyle: TextStyle(color: Colors.grey[700]),
//                       prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF1976D2)),
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
//                       ),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(height: 15),
//                   // Password Field
//                   TextField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       labelStyle: TextStyle(color: Colors.grey[700]),
//                       prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1976D2)),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//                           color: Colors.grey[600],
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
//                       ),
//                     ),
//                     obscureText: _obscurePassword,
//                   ),
//                   const SizedBox(height: 15),
//                   // Confirm Password Field
//                   TextField(
//                     controller: _confirmPasswordController,
//                     decoration: InputDecoration(
//                       labelText: "Confirm Password",
//                       labelStyle: TextStyle(color: Colors.grey[700]),
//                       prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1976D2)),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//                           color: Colors.grey[600],
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscureConfirmPassword = !_obscureConfirmPassword;
//                           });
//                         },
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
//                       ),
//                     ),
//                     obscureText: _obscureConfirmPassword,
//                   ),
//                   const SizedBox(height: 15),
//                   // Terms and Conditions Checkbox
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: _agreeToTerms,
//                         onChanged: (value) {
//                           setState(() {
//                             _agreeToTerms = value ?? false;
//                           });
//                         },
//                         activeColor: Color(0xFF1976D2),
//                       ),
//                       Expanded(
//                         child: Text(
//                           "I agree to the Terms & Conditions and Privacy Policy",
//                           style: GoogleFonts.poppins(
//                             color: Colors.grey[700],
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   // Signup Button
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF1976D2),
//                       minimumSize: const Size(double.infinity, 55),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                       elevation: 8,
//                       shadowColor: Colors.black38,
//                     ),
//                     onPressed: _agreeToTerms && !_isLoading ? _signUp : null,
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : Text(
//                             "Sign Up",
//                             style: GoogleFonts.poppins(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                   ),
//                   const SizedBox(height: 25),
//                   // Divider with "OR"
//                   Row(
//                     children: [
//                       Expanded(child: Divider(color: Colors.grey[400])),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Text(
//                           "OR",
//                           style: GoogleFonts.poppins(
//                             color: Colors.grey[600],
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       Expanded(child: Divider(color: Colors.grey[400])),
//                     ],
//                   ),
//                   const SizedBox(height: 25),
//                   // Social Signup Buttons
//                   SocialSignupButton(
//                     icon: Icons.g_mobiledata,
//                     text: "Sign up with Google",
//                     color: Colors.white,
//                     textColor: Colors.black87,
//                     borderColor: Colors.grey[300],
//                     onPressed: () {},
//                   ),
//                   const SizedBox(height: 15),
//                   SocialSignupButton(
//                     icon: Icons.facebook,
//                     text: "Sign up with Facebook",
//                     color: Color(0xFF1877F2),
//                     textColor: Colors.white,
//                     onPressed: () {},
//                   ),
//                   const SizedBox(height: 15),
//                   SocialSignupButton(
//                     icon: Icons.apple,
//                     text: "Sign up with Apple",
//                     color: Colors.black,
//                     textColor: Colors.white,
//                     onPressed: () {},
//                   ),
//                   const SizedBox(height: 25),
//                   // Login Link
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Already have an account? ",
//                         style: GoogleFonts.poppins(color: Colors.grey[600]),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, 'login');
//                         },
//                         child: Text(
//                           "Sign In",
//                           style: GoogleFonts.poppins(
//                             color: Color(0xFF1976D2),
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SocialSignupButton extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final Color color;
//   final Color textColor;
//   final Color? borderColor;
//   final VoidCallback onPressed;

//   const SocialSignupButton({
//     required this.icon,
//     required this.text,
//     required this.color,
//     required this.textColor,
//     this.borderColor,
//     required this.onPressed,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         minimumSize: const Size(double.infinity, 50),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//           side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
//         ),
//         elevation: 4,
//         shadowColor: Colors.black26,
//       ),
//       onPressed: onPressed,
//       icon: Icon(icon, color: textColor, size: 24),
//       label: Text(
//         text,
//         style: GoogleFonts.poppins(
//           color: textColor,
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }