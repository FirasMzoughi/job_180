import 'package:flutter/material.dart';

class CandidatsPage extends StatelessWidget {
  // Exemple de données pour les candidats
  final List<Map<String, dynamic>> candidates = [
    {
      "name": "Alice Martin",
      "description": "Développeuse Flutter passionnée",
      "avatarUrl": "https://via.placeholder.com/150.png?text=Alice",
      "skills": ["Flutter", "Dart", "Firebase"],
    },
    {
      "name": "Bob Johnson",
      "description": "Product Manager expérimenté",
      "avatarUrl": "https://via.placeholder.com/150.png?text=Bob",
      "skills": ["Gestion", "Agile", "Stratégie"],
    },
    {
      "name": "Claire Dupont",
      "description": "Designer UX/UI créative",
      "avatarUrl": "https://via.placeholder.com/150.png?text=Claire",
      "skills": ["Design", "Prototype", "Illustration"],
    },
  ];

  CandidatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond en dégradé pour le thème général
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
              // AppBar personnalisée
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: Colors.blue, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        "Liste des Candidats",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    // Espace réservé pour centrer le titre
                    Opacity(
                      opacity: 0.0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: Colors.transparent, size: 28),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              // Liste des candidats
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: candidates.length,
                  itemBuilder: (context, index) {
                    final candidate = candidates[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      shadowColor: Colors.blue.withOpacity(0.2),
                      margin: EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Avatar avec image et icône fallback
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue.shade100,
                              backgroundImage:
                                  NetworkImage(candidate["avatarUrl"]),
                              child: candidate["avatarUrl"] == null
                                  ? Icon(Icons.person,
                                      color: Colors.blue, size: 30)
                                  : null,
                            ),
                            SizedBox(width: 16),
                            // Informations du candidat
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    candidate["name"],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    candidate["description"],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  // Affichage des compétences sous forme de chips avec icône
                                  Wrap(
                                    spacing: 6,
                                    children: candidate["skills"]
                                        .map<Widget>((skill) => Chip(
                                              label: Text(skill,
                                                  style: TextStyle(
                                                      fontSize: 12)),
                                              avatar: Icon(
                                                Icons.star_border,
                                                size: 16,
                                                color: Colors.blue,
                                              ),
                                              backgroundColor:
                                                  Colors.blue.shade50,
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            // Bouton d'action (par exemple pour accéder au profil complet)
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Colors.blue),
                              onPressed: () {
                                // Navigation vers le profil complet du candidat ou son CV
                              },
                            )
                          ],
                        ),
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
