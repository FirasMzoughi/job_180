import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

// Admin
import 'package:job360/admin/dashbord.dart';

// Employer
import 'package:job360/candidate/home.dart';
import 'package:job360/candidate/job_details_screen.dart';
import 'package:job360/candidate/job_application_screen.dart';
import 'package:job360/candidate/notifications_screen.dart';

// Entreprise
import 'package:job360/entreprise/candidat.dart';
import 'package:job360/entreprise/contact.dart';
import 'package:job360/entreprise/détail.dart';
import 'package:job360/entreprise/edite.dart';
import 'package:job360/entreprise/gestion.dart';
import 'package:job360/entreprise/home.dart';
import 'package:job360/entreprise/notification.dart';
import 'package:job360/entreprise/profile.dart';

import 'package:job360/login/login.dart';
import 'package:job360/singup/startup_signup.dart';
import 'package:job360/singup/signup.dart';

// Welcome
import 'package:job360/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job360',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const WelcomePage()),
        GetPage(name: "/login", page: () => const SigninScreen()),
        GetPage(name: "/signup", page: () => const SignupScreen()),
        GetPage(name: "/startup_signup", page: () => const StartupSignupScreen()),
        GetPage(name: "/jobApplication", page: () => const JobApplicationScreen()),
        // Employer
        GetPage(name: "/homeEmployer", page: () => const HomeEmployerScreen()),
        GetPage(name: "/notifications", page: () => const NotificationsEmployerScreen()),
        // Entreprise
        GetPage(name: "/homeEntreprise", page: () =>  StartupHomeScreen()),
        GetPage(name: "/entrepriseNotifications", page: () => const NotificationsScreen()),
        GetPage(name: "/chat", page: () => const ChatPage()),
        GetPage(name: "/gestionOffres", page: () =>  GestionOffresPage()),
        GetPage(name: "/detailOffre", page: () =>  DetailOffrePage()),
        GetPage(name: "/candidats", page: () =>  CandidatsPage()),
        // Admin
        GetPage(name: "/adminDashboard", page: () => const AdminHomeScreen()),
        // Add 'home' route (assuming it's for candidat; adjust if needed)
        GetPage(name: "/home", page: () => const HomeEmployerScreen()), // Placeholder; replace with HomeCandidatScreen if applicable
      ],
      unknownRoute: GetPage(
        name: "/notfound",
        page: () => Scaffold(
          body: Center(
            child: Text('Route non trouvée'),
          ),
        ),
      ),
    );
  }
}