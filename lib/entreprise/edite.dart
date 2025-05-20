import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
 

  // Valeurs initiales du profil, à adapter selon vos besoins.
  String _name = "TechStartup Inc.";
  String _sector = "Software Development";
  String _location = "Paris, France";
  String _description = "Building the next-gen recruitment platform.";
  String _founded = "2020";
  String _teamSize = "20";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text("Modifier le Profil", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
       
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar ou logo de la startup
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(Icons.business, size: 40, color: Colors.blue),
                ),
              ),
              SizedBox(height: 20),
              // Champ de saisie pour le nom
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: "Nom de la startup",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer le nom de la startup";
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              SizedBox(height: 16),
              // Champ de saisie pour le secteur d'activité
              TextFormField(
                initialValue: _sector,
                decoration: InputDecoration(
                  labelText: "Secteur d'activité",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer le secteur d'activité";
                  }
                  return null;
                },
                onSaved: (value) => _sector = value!,
              ),
              SizedBox(height: 16),
              // Champ de saisie pour la localisation
              TextFormField(
                initialValue: _location,
                decoration: InputDecoration(
                  labelText: "Localisation",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer la localisation";
                  }
                  return null;
                },
                onSaved: (value) => _location = value!,
              ),
              SizedBox(height: 16),
              // Champ de saisie pour la description
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer une description";
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 24),
              Text("Informations complémentaires", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),
              // Champ de saisie pour l'année de création
              TextFormField(
                initialValue: _founded,
                decoration: InputDecoration(
                  labelText: "Année de création",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer l'année de création";
                  }
                  return null;
                },
                onSaved: (value) => _founded = value!,
              ),
              SizedBox(height: 16),
              // Champ de saisie pour la taille de l'équipe
              TextFormField(
                initialValue: _teamSize,
                decoration: InputDecoration(
                  labelText: "Taille de l'équipe",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer la taille de l'équipe";
                  }
                  return null;
                },
                onSaved: (value) => _teamSize = value!,
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: Icon(Icons.save),
                  label: Text("Enregistrer les modifications", style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour valider et enregistrer les modifications
  void _submitForm() {
    
      // Ici, vous pouvez ajouter l'appel à une API, sauvegarder dans Firebase ou toute autre action nécessaire
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profil mis à jour")),
      );
    
  }
}
