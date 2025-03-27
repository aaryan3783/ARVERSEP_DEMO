import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/session_manager.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSettingItem("Download Quality"),
          _buildSettingItem("Notification", trailing: Switch(value: true, onChanged: (val) {})),
          _buildSettingItem("History"),
          _buildSettingItem("Payment History"),
          _buildSettingItem("Manage Subscription"),
          _buildSettingItem("Help Center"),
          _buildSettingItem("Contact Us", onTap: () => _openGmail(context)),
          _buildSettingItem("Delete Account"),
          SizedBox(height: 20),
          _buildPremiumBanner(),
          SizedBox(height: 20),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, {Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Join Premium!\nEnjoy watching Full-HD movies without ads.",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Show confirmation dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Logout"),
              content: Text("Are you sure you want to logout?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    // Clear the session
                    await SessionManager.clearSession();

                    // Navigate to SignInPage using named route
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text("LOGOUT", style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  void _openGmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@gmail.com',
      queryParameters: {'subject': 'Support Request'},
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open email client")),
      );
    }
  }
}