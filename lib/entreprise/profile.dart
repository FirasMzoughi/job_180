import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class StartupProfileScreen extends StatelessWidget {
  const StartupProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF1E3C72);
    final Color secondaryColor = Color(0xFF2A5298);
    final Gradient blueGradient = LinearGradient(
      colors: [primaryColor, secondaryColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        icon: Icon(Icons.edit),
        label: Text('Mettre à jour'),
        onPressed: () {
          _showUpdateDialog(context);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre avec animation et bouton de déconnexion
              FadeInDown(
                duration: Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profil de la Startup",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: primaryColor, size: 28),
                      tooltip: 'Déconnexion',
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Avatar avec animation
              Center(
                child: BounceInUp(
                  duration: Duration(milliseconds: 800),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        NetworkImage('https://placehold.co/200x200'),
                    backgroundColor: Colors.white,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          // Action pour changer la photo
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Card avec dégradé bleu et effets modernes
              FadeIn(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: blueGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nom de la startup
                      Row(
                        children: [
                          Icon(Icons.business, color: Colors.white70),
                          SizedBox(width: 10),
                          Text(
                            "Nom de la startup",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "TechTrend Innovations",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Divider(color: Colors.white54, height: 30),
                      // Location
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.white70),
                          SizedBox(width: 10),
                          Text(
                            "Lieu",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Tunis, Tunisia",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      Divider(color: Colors.white54, height: 30),
                      // Industrie
                      Row(
                        children: [
                          Icon(Icons.business_center, color: Colors.white70),
                          SizedBox(width: 10),
                          Text(
                            "Secteur",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Technologie",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      Divider(color: Colors.white54, height: 30),
                      // Website
                      Row(
                        children: [
                          Icon(Icons.web, color: Colors.white70),
                          SizedBox(width: 10),
                          Text(
                            "Site Web",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "www.techtrend.com",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Divider(color: Colors.white54, height: 30),
                      // Description
                      Row(
                        children: [
                          Icon(Icons.description, color: Colors.white70),
                          SizedBox(width: 10),
                          Text(
                            "Description",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Innovons pour un futur technologique innovant.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour afficher une boîte de dialogue d'édition
  void _showUpdateDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController(text: 'TechTrend Innovations');
    final TextEditingController locationController = TextEditingController(text: 'Tunis, Tunisia');
    final TextEditingController industryController = TextEditingController(text: 'Technologie');
    final TextEditingController websiteController = TextEditingController(text: 'www.techtrend.com');
    final TextEditingController descriptionController = TextEditingController(text: 'Innovons pour un futur technologique innovant.');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mettre à jour le profil', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Nom de la startup'),
                    validator: (value) => value!.isEmpty ? 'Ce champ est requis' : null,
                  ),
                  TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(labelText: 'Lieu'),
                    validator: (value) => value!.isEmpty ? 'Ce champ est requis' : null,
                  ),
                  TextFormField(
                    controller: industryController,
                    decoration: InputDecoration(labelText: 'Secteur'),
                    validator: (value) => value!.isEmpty ? 'Ce champ est requis' : null,
                  ),
                  TextFormField(
                    controller: websiteController,
                    decoration: InputDecoration(labelText: 'Site Web'),
                    validator: (value) => value!.isEmpty ? 'Ce champ est requis' : null,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty ? 'Ce champ est requis' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Annuler', style: GoogleFonts.poppins(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Sauvegarder', style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3C72),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Ici, vous pouvez enregistrer les données modifiées
                  Navigator.of(context).pop();
                  // Actualiser l'interface si nécessaire
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Fonction pour afficher une boîte de dialogue de déconnexion
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Déconnexion', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          content: Text('Êtes-vous sûr de vouloir vous déconnecter ?', style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              child: Text('Annuler', style: GoogleFonts.poppins(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Déconnexion', style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3C72),
              ),
              onPressed: () {
                // Naviguer vers l'écran de connexion et remplacer la pile de navigation
                Navigator.pushReplacementNamed(context, 'startupLogin');
              },
            ),
          ],
        );
      },
    );
  }
}