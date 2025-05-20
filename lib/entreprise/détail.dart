import 'package:flutter/material.dart';

class DetailOffrePage extends StatelessWidget {
  // Exemple de données pour l'offre
  final Map<String, dynamic> offer = {
    "title": "Senior Flutter Developer",
    "headerImage":
        "https://via.placeholder.com/400x200.png?text=Company+Banner", // Image d'en-tête (placeholder)
    "companyLogo":
        "https://via.placeholder.com/100.png?text=Logo", // Logo de l'entreprise (placeholder)
    "description":
        "Nous recherchons un développeur Flutter expérimenté pour créer des applications mobiles de haute qualité. Vous aurez l'occasion de travailler sur des projets innovants et de collaborer avec une équipe dynamique.",
    "requirements": [
      "3+ années d'expérience en Flutter",
      "Bonne connaissance de Dart",
      "Maîtrise de l’UX/UI mobile",
      "Expérience en architecture logicielle",
      "Capacité à travailler en équipe agile",
    ],
    "candidates": [
      {"name": "Alice", "avatar": Icons.person},
      {"name": "Bob", "avatar": Icons.person},
      {"name": "Claire", "avatar": Icons.person},
      {"name": "David", "avatar": Icons.person},
    ],
  };

   DetailOffrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond avec dégradé pour rester dans le thème
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
            _buildCustomAppBar(context),
            Expanded(
              child: ListView(
                children: [
                  _buildHeaderImage(),
                  SizedBox(height: 12),
                  _buildOfferTitleSection(),
                  SizedBox(height: 16),
                  _buildDescriptionSection(),
                  SizedBox(height: 16),
                  _buildRequirementsSection(),
                  SizedBox(height: 20),
                  _buildCandidatesSection(),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Action pour contacter les candidats
                      },
                      icon: Icon(Icons.send, color: Colors.white),
                      label: Text(
                        "Contacter les candidats",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  // Barre de navigation personnalisée
  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              "Détail de l'Offre",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          // Bouton invisible pour centrer le titre
          Opacity(
            opacity: 0.0,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  // Image d'en-tête
  Widget _buildHeaderImage() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Image.network(
        offer["headerImage"],
        fit: BoxFit.cover,
      ),
    );
  }

  // Section affichant le titre de l'offre et le logo de l'entreprise
  Widget _buildOfferTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Logo de l'entreprise
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade100,
            backgroundImage: NetworkImage(offer["companyLogo"]),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer["title"],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.business, color: Colors.blue, size: 18),
                    SizedBox(width: 4),
                    Text(
                      "Nom de l'Entreprise",
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Section description détaillée de l'offre
  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        offer["description"],
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }

  // Section des exigences avec icônes
  Widget _buildRequirementsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Exigences :",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...offer["requirements"].map<Widget>((req) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      req,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Section affichant horizontalement les candidats postulants
  Widget _buildCandidatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Candidats postulants",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: offer["candidates"].length,
            itemBuilder: (context, index) {
              final candidate = offer["candidates"][index];
              return Padding(
                padding: EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(candidate["avatar"], color: Colors.blue, size: 28),
                    ),
                    SizedBox(height: 6),
                    Text(candidate["name"],
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
