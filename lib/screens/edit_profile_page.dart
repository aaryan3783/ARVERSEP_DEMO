import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class EditProfilePage extends StatefulWidget {
  final String currentEmail;

  EditProfilePage({required this.currentEmail});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? _image;
  String? existingImagePath;

  String selectedGender = "Male";
  DateTime selectedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.currentEmail;
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(widget.currentEmail);
    if (userJson != null) {
      Map<String, dynamic> userData = jsonDecode(userJson);
      setState(() {
        nameController.text = userData['name'] ?? "Gamerboy";
        phoneController.text = userData['phone'] ?? "";
        selectedGender = userData['gender'] ?? "Male";
        selectedDate = DateTime.tryParse(userData['dob'] ?? "") ?? DateTime.now();
        existingImagePath = userData['profileImage'] ?? '';
        if (existingImagePath != null && existingImagePath!.isNotEmpty) {
          // Check if the file exists before loading
          if (File(existingImagePath!).existsSync()) {
            _image = File(existingImagePath!);
          } else {
            existingImagePath = null; // Clear the path if the file doesn't exist
          }
        }
      });
    } else {
      nameController.text = "Gamerboy";
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Get the app's documents directory
      final directory = await getApplicationDocumentsDirectory();
      final String newPath = '${directory.path}/${pickedFile.name}';

      // Copy the image to the persistent directory
      final File newImage = await File(pickedFile.path).copy(newPath);

      setState(() {
        _image = newImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EDIT PROFILE", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color.fromARGB(255, 197, 187, 199),
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Text(
                              nameController.text.isNotEmpty
                                  ? nameController.text[0].toUpperCase()
                                  : '',
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 15,
                          child: Icon(Icons.edit, size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildTextField("Name", nameController, validator: _validateName),
                _buildTextField("Email", emailController, validator: _validateEmail, readOnly: true),
                _buildTextField("Phone Number", phoneController, keyboardType: TextInputType.phone, validator: _validatePhone),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Icon(Icons.calendar_today, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: InputDecoration(labelText: "Gender"),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  },
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text("UPDATE", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Load existing user data to preserve the password
      String? userJson = prefs.getString(emailController.text);
      Map<String, dynamic> userData = userJson != null ? jsonDecode(userJson) : {};

      // Update the fields
      userData['name'] = nameController.text;
      userData['email'] = emailController.text;
      userData['phone'] = phoneController.text;
      userData['dob'] = selectedDate.toIso8601String();
      userData['gender'] = selectedGender;
      userData['profileImage'] = _image?.path ?? existingImagePath ?? '';

      // Save updated data
      await prefs.setString(emailController.text, jsonEncode(userData));

      // Return updated data to DrawerNavigation
      Navigator.pop(context, {
        'email': emailController.text,
        'name': nameController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile Updated Successfully!")),
      );
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit number';
    }
    return null;
  }
}