import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class ApplicantsScreen extends StatelessWidget {
  ApplicantsScreen({Key? key}) : super(key: key);

  // Static data mimicking Firestore structure
  final List<Map<String, dynamic>> jobPostings = [
    {
      'jobId': 'job1',
      'jobTitle': 'Flutter Developer',
      'applications': [
        {
          'applicationId': 'app1',
          'name': 'Alya Khattab',
          'role': 'Flutter Developer',
          'skills': 'Flutter, Dart, Firebase',
          'location': 'Tunis, Tunisia',
          'experience': '3+ Years',
          'email': 'alya@example.com',
          'coverLetter': 'I am passionate about mobile development and have extensive experience in Flutter.',
          'cvUrl': 'https://example.com/cv/alya.pdf',
          'status': 'pending',
        },
        {
          'applicationId': 'app2',
          'name': 'Mohamed Ali',
          'role': 'Flutter Developer',
          'skills': 'Flutter, Dart, REST APIs',
          'location': 'Remote',
          'experience': '2+ Years',
          'email': 'mohamed@example.com',
          'coverLetter': 'Excited to contribute to innovative mobile apps.',
          'cvUrl': 'https://example.com/cv/mohamed.pdf',
          'status': 'pending',
        },
      ],
    },
    {
      'jobId': 'job2',
      'jobTitle': 'UI/UX Designer',
      'applications': [
        {
          'applicationId': 'app3',
          'name': 'Sara Ben Ammar',
          'role': 'UI/UX Designer',
          'skills': 'Figma, Adobe XD',
          'location': 'London, UK',
          'experience': '4+ Years',
          'email': 'sara@example.com',
          'coverLetter': 'I specialize in creating user-friendly interfaces.',
          'cvUrl': 'https://example.com/cv/sara.pdf',
          'status': 'pending',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Job Applicants",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1976D2)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: jobPostings.isEmpty
            ? Center(
                child: Text(
                  'No job postings found.',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: jobPostings.length,
                itemBuilder: (context, index) {
                  var job = jobPostings[index];
                  String jobId = job['jobId'];
                  String jobTitle = job['jobTitle'] ?? 'Untitled Job';
                  List applications = job['applications'] ?? [];

                  if (applications.isEmpty) {
                    return SizedBox.shrink();
                  }

                  return FadeInUp(
                    duration: Duration(milliseconds: 800 + index * 200),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(bottom: 16),
                      child: ExpansionTile(
                        title: Text(
                          jobTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          '${applications.length} applicant(s)',
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                        ),
                        children: applications.map<Widget>((app) {
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            title: Text(
                              app['name'] ?? 'Unknown Applicant',
                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              app['role'] ?? 'No role specified',
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF1976D2)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ApplicantDetailsScreen(
                                    jobId: jobId,
                                    applicationId: app['applicationId'],
                                    applicantData: Map<String, dynamic>.from(app),
                                    onStatusUpdate: (status) {
                                      // Update local data
                                      int jobIndex = jobPostings.indexWhere((j) => j['jobId'] == jobId);
                                      int appIndex = jobPostings[jobIndex]['applications']
                                          .indexWhere((a) => a['applicationId'] == app['applicationId']);
                                      jobPostings[jobIndex]['applications'][appIndex]['status'] = status;
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class ApplicantDetailsScreen extends StatefulWidget {
  final String jobId;
  final String applicationId;
  final Map<String, dynamic> applicantData;
  final Function(String) onStatusUpdate;

  const ApplicantDetailsScreen({
    Key? key,
    required this.jobId,
    required this.applicationId,
    required this.applicantData,
    required this.onStatusUpdate,
  }) : super(key: key);

  @override
  _ApplicantDetailsScreenState createState() => _ApplicantDetailsScreenState();
}

class _ApplicantDetailsScreenState extends State<ApplicantDetailsScreen> {
  late Map<String, dynamic> _applicantData;

  @override
  void initState() {
    super.initState();
    _applicantData = Map<String, dynamic>.from(widget.applicantData);
  }

  void _updateApplicationStatus(BuildContext context, String status) {
    setState(() {
      _applicantData['status'] = status;
    });
    widget.onStatusUpdate(status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Application $status successfully!'),
        backgroundColor: status == 'accepted' ? Colors.green : Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    Navigator.pop(context); // Return to ApplicantsScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Applicant Details",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1976D2)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FadeInUp(
              duration: Duration(milliseconds: 800),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _applicantData['name'] ?? 'Unknown Applicant',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _applicantData['role'] ?? 'No role specified',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(color: Colors.grey[300]),
                      SizedBox(height: 16),
                      _buildDetailRow("Skills", _applicantData['skills'] ?? 'Not provided'),
                      _buildDetailRow("Location", _applicantData['location'] ?? 'Not provided'),
                      _buildDetailRow("Experience", _applicantData['experience'] ?? 'Not provided'),
                      _buildDetailRow("Email", _applicantData['email'] ?? 'Not provided'),
                      _buildDetailRow("Cover Letter", _applicantData['coverLetter'] ?? 'Not provided'),
                      _buildDetailRow(
                        "CV",
                        _applicantData['cvUrl'] ?? 'Not provided',
                        isUrl: _applicantData['cvUrl'] != null,
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Application Status: ${_applicantData['status']?.toUpperCase() ?? 'PENDING'}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _applicantData['status'] == 'accepted'
                              ? Colors.green
                              : _applicantData['status'] == 'rejected'
                                  ? Colors.redAccent
                                  : Colors.blue,
                        ),
                      ),
                      SizedBox(height: 24),
                      if (_applicantData['status'] == null || _applicantData['status'] == 'pending') ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 4,
                              ),
                              onPressed: () => _updateApplicationStatus(context, 'accepted'),
                              child: Text(
                                "Accept",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 4,
                              ),
                              onPressed: () => _updateApplicationStatus(context, 'rejected'),
                              child: Text(
                                "Reject",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isUrl = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1976D2),
            ),
          ),
          SizedBox(height: 4),
          isUrl
              ? InkWell(
                  onTap: () {
                    // Placeholder: Open CV URL (e.g., using url_launcher)
                    print('Opening CV: $value');
                  },
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              : Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
        ],
      ),
    );
  }
}