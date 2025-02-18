import 'package:flutter/material.dart';
import 'package:project_new/Payment/GalleryPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _firstName = "";
  String _lastName = "";
  String _email = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = prefs.getString('firstName') ?? "Unknown";
      _lastName = prefs.getString('lastName') ?? "";
      _email = prefs.getString('email') ?? "No Email";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Decoration
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFEECDA3), Color(0xFFEF629F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40), // Added top spacing

                  // Profile Picture with Border, Shadow, and Gradient
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 6,
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('assets/pro1.jpg'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt,
                                color: Color(0xFF6200EA), size: 28),
                            onPressed: () {
                              // Add functionality for changing profile picture
                            },
                            tooltip: 'Change Profile Picture',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // User Details
                  const SizedBox(height: 20),

                  // Display User Name & Email
                  Text(
                    '☞ $_firstName $_lastName ☜',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _email,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Profile Information Cards with onPressed
                  ProfileInfoCard(
                    icon: Icons.photo_library,
                    title: 'Gallery',
                    info: 'ใบเสร็จ',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImagePickerScreen()));
                    },
                  ),

                  ProfileInfoCard(
                    icon: Icons.credit_card,
                    title: '𝗣𝗮𝘆𝗺𝗲𝗻𝘁 𝗠𝗲𝘁𝗵𝗼𝗱',
                    info: 'Visa **** 1234',
                    onPressed: () {
                      // Navigate to payment methods page or edit payment method
                      print("Payment Method clicked");
                    },
                  ),
                  ProfileInfoCard(
                    icon: Icons.location_on,
                    title: 'ᴘʀᴇꜰᴇʀʀᴇᴅ ᴠᴇɴᴜᴇ',
                    info: 'Madison Square Garden, NY',
                    onPressed: () {
                      // Navigate to the preferred venues page or edit the preferred venue
                      print("Preferred Venue clicked");
                    },
                  ),
                  ProfileInfoCard(
                    icon: Icons.star,
                    title: '𝐿𝑜𝑦𝑎𝑙𝑡𝑦 𝑃𝑜𝑖𝑛𝑡𝑠',
                    info: '350 Points',
                    onPressed: () {
                      // Add functionality for viewing or redeeming loyalty points
                      print("Loyalty Points clicked");
                    },
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for edit profile
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.black, // Change text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for logout
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF5350),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          shadowColor: Colors.red.withOpacity(0.3),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white, // Change text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Setting Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality for settings
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        shadowColor: Colors.grey.withOpacity(0.3),
                      ),
                      child: const Text(
                        'Setting',
                        style: TextStyle(
                          color: Colors.white, // Change text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), // Added bottom spacing
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;
  final VoidCallback? onPressed;

  const ProfileInfoCard({
    required this.icon,
    required this.title,
    required this.info,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.2),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF6200EA).withOpacity(0.1),
            child: Icon(icon, color: const Color(0xFF6200EA)),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          subtitle: Text(
            info,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF6200EA),
            ),
          ),
          trailing:
              const Icon(Icons.arrow_forward_ios, color: Color(0xFF6200EA)),
        ),
      ),
    );
  }
}
