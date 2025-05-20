import 'package:flutter/material.dart';

class JobDetailsScreen extends StatelessWidget {
  final String title;
  final String location;
  final String salary;
  final String type;
  final String remote;

  const JobDetailsScreen({super.key, 
    this.title = "UI/UX Designer",
    this.location = "New York, US",
    this.salary = "\$130K/Yr",
    this.type = "Full Time",
    this.remote = "Remote",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond avec dégradé subtil
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Barre de titre
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.blue, size: 28),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Job Details",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      // Espace pour équilibrer
                      SizedBox(width: 48),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Card d’en-tête
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titre du poste
                        Row(
                          children: [
                            Icon(Icons.design_services, color: Colors.blue, size: 28),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.business, color: Colors.grey.shade500, size: 18),
                            SizedBox(width: 4),
                            Text(
                              "TechCorp Inc.",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Row pour Location / Salary
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          icon: Icons.location_on,
                          label: "Location",
                          value: location,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildInfoItem(
                          icon: Icons.attach_money,
                          label: "Salary",
                          value: salary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Row pour Type / Remote
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          icon: Icons.schedule,
                          label: "Type",
                          value: type,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildInfoItem(
                          icon: Icons.wifi,
                          label: "Remote",
                          value: remote,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Titre de la section Description
                  Text(
                    "Job Description",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We are looking for a skilled $title ...",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Bouton "Apply Now"
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/job-application', arguments: {
                          'title': title,
                          'location': location,
                          'salary': salary,
                          'type': type,
                          'remote': remote,
                        });
                      },
                      child: Text(
                        "Apply Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget pour un bloc d'informations (icône + label + value)
  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
