import 'package:flutter/material.dart';

class GestionOffresPage extends StatelessWidget {
  // Exemple de données d'offres d'emploi
  final List<Map<String, dynamic>> jobOffers = [
    {
      "title": "Senior Flutter Developer",
      "applicants": 15,
      "status": "Active",
      "icon": Icons.work_outline,
    },
    {
      "title": "Product Manager",
      "applicants": 8,
      "status": "Expired",
      "icon": Icons.business_center,
    },
    {
      "title": "UX/UI Designer",
      "applicants": 10,
      "status": "Active",
      "icon": Icons.design_services,
    },
  ];

  GestionOffresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond dégradé conforme au thème
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
              // AppBar minimaliste
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        "Gestion des Offres",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Pour équilibrer le titre
                    Opacity(
                      opacity: 0.0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.transparent),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemCount: jobOffers.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final offer = jobOffers[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: Colors.blue.withOpacity(0.2),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Icon(
                                offer["icon"],
                                color: Colors.blue,
                                size: 28,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer["title"],
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${offer["applicants"]} candidats",
                                    style: TextStyle(color: Colors.grey.shade600),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 14,
                                        color: offer["status"] == "Active" ? Colors.green : Colors.red,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        offer["status"],
                                        style: TextStyle(
                                          color: offer["status"] == "Active" ? Colors.green : Colors.red,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Boutons d'action
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                // Navigation vers la page d’édition (à implémenter)
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                              onPressed: () {
                                // Suppression de l'offre
                              },
                            ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Action pour créer une nouvelle offre d'emploi
        },
      ),
    );
  }
}
