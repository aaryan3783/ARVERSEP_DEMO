import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_page.dart';
import 'edit_profile_page.dart';
import 'career_page.dart';

class DrawerNavigation extends StatefulWidget {
  final String userEmail;

  const DrawerNavigation({Key? key, required this.userEmail}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  late String userEmail;
  String userName = "GAMERBOY"; // Default placeholder

  @override
  void initState() {
    super.initState();
    userEmail = widget.userEmail;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(widget.userEmail);
    if (userJson != null) {
      final userData = jsonDecode(userJson);
      setState(() {
        userName = userData['name'] ?? "GAMERBOY";
        userEmail = userData['email'] ?? widget.userEmail;
      });
    } else {
      setState(() {
        userName = "GAMERBOY";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile & Close Button (Original Design)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final updatedData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(currentEmail: userEmail),
                            ),
                          );
                          if (updatedData != null) {
                            setState(() {
                              userEmail = updatedData['email'] ?? userEmail;
                            });
                            _loadUserData();
                          }
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.purple,
                          child: Text(
                            userName.isNotEmpty ? userName[0].toUpperCase() : "G",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.notifications_none, size: 28),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close, size: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(),

            // VIDEO Section (Original)
            _buildSectionTitle("VIDEO"),
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem("Series"),
                  _buildDrawerItem("Kids"),
                  _buildDrawerItem("Variety"),
                  _buildDrawerItem("Movies"),
                  _buildDrawerItem("Tollywood"),
                  _buildDrawerItem("Quality"),
                  _buildDrawerItem("Online"),
                  SizedBox(height: 10),

                  // STORE Section
                  _buildSectionTitle("STORE"),
                  _buildDrawerSubItem("Gift Card"),
                  SizedBox(height: 20),

                  // WATCH FOR FREE Section
                  _buildSectionTitle("WATCH FOR FREE"),
                  _buildDrawerSubItem("News"),
                  _buildDrawerSubItem("Knowledge"),
                  SizedBox(height: 20),

                  // SETTING Section
                  _buildSectionTitle("SETTING"),
                  _buildDrawerItem("Settings", onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  }),
                  SizedBox(height: 40),

                  // CONNECT Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CONNECT",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            socialIcon('assets/facebook.png', 'https://www.facebook.com'),
                            SizedBox(width: 10),
                            socialIcon('assets/instagram.png', 'https://www.instagram.com'),
                            SizedBox(width: 10),
                            socialIcon('assets/youtube.png', 'https://www.youtube.com'),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

                  // Footer Links
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "About Us  •  ",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CareerPage()),
                            );
                          },
                          child: Text(
                            "Career",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          "  •  Policy",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDrawerItem(String title, {VoidCallback? onTap}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.chevron_right, color: Colors.black),
      onTap: onTap ?? () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildDrawerSubItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget socialIcon(String assetPath, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Image.asset(
        assetPath,
        width: 30,
        height: 30,
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
