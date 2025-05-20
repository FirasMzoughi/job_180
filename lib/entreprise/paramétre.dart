import 'package:flutter/material.dart';

class ParametresPage extends StatelessWidget {
  final List<Map<String, dynamic>> settings = [
    {
      "title": "Notifications",
      "subtitle": "Gérer les alertes reçues",
      "icon": Icons.notifications_active_outlined,
    },
    {
      "title": "Langue",
      "subtitle": "Changer la langue de l'application",
      "icon": Icons.language,
    },
    {
      "title": "Sécurité",
      "subtitle": "Changer le mot de passe ou activer 2FA",
      "icon": Icons.lock_outline,
    },
    {
      "title": "Thème",
      "subtitle": "Activer le mode clair ou sombre",
      "icon": Icons.brightness_6_outlined,
    },
    {
      "title": "Confidentialité",
      "subtitle": "Contrôlez vos données",
      "icon": Icons.privacy_tip_outlined,
    },
    {
      "title": "Déconnexion",
      "subtitle": "Se déconnecter de votre compte",
      "icon": Icons.logout,
    },
  ];

  ParametresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Arrière-plan avec dégradé
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar personnalisé
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        "Paramètres",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0,
                      child: Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),

              // Liste des paramètres
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: settings.length,
                  itemBuilder: (context, index) {
                    final setting = settings[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.08),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade50,
                          child: Icon(
                            setting["icon"],
                            color: Colors.blue,
                          ),
                        ),
                        title: Text(
                          setting["title"],
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        subtitle: Text(
                          setting["subtitle"],
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Colors.blue.shade300, size: 18),
                        onTap: () {
                          // Action à définir pour chaque paramètre
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
