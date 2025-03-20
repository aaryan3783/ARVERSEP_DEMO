import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'signin_page.dart'; // Import SignInPage for logout navigation

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
          _buildSettingItem("Contact Us", onTap: () => _openGmail()), // Open Gmail on tap
          _buildSettingItem("Delete Account"),
          SizedBox(height: 20),
          _buildPremiumBanner(),
          SizedBox(height: 20),
          _buildLogoutButton(context), // Navigate to Sign In page on logout
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()), // Navigate to Sign In page
            (route) => false, // Removes all previous routes
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

  void _openGmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@gmail.com', // Change to your support email
      queryParameters: {'subject': 'Support Request'},
    );
    if (await launchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not open email';
    }
  }
}
