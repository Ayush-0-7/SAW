import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isEditing = false;

  // TextEditingController for each helper detail
  final TextEditingController _person1NameController = TextEditingController(text: 'Person 1');
  final TextEditingController _person1PhoneController = TextEditingController(text: '123-456-7890');
  final TextEditingController _person2NameController = TextEditingController(text: 'Person 2');
  final TextEditingController _person2PhoneController = TextEditingController(text: '987-654-3210');
  final TextEditingController _person3NameController = TextEditingController(text: 'Person 3');
  final TextEditingController _person3PhoneController = TextEditingController(text: '555-555-5555');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF8E9E9), // Light pink background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove shadow
        automaticallyImplyLeading: false, // Prevents default back button
        leading: IconButton( // Custom back button
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.person, color: Colors.black, size: 50), // Profile Icon
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                 Text(
                  'Your Name',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Helper Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Display Helper Details or Edit Form
            if (_isEditing) ...[
              buildHelperEditForm('Person 1', _person1NameController, _person1PhoneController),
              const SizedBox(height: 20),
              buildHelperEditForm('Person 2', _person2NameController, _person2PhoneController),
              const SizedBox(height: 20),
              buildHelperEditForm('Person 3', _person3NameController, _person3PhoneController),
            ] else ...[
              buildHelperDetailBox(_person1NameController.text, _person1PhoneController.text),
              const SizedBox(height: 20),
              buildHelperDetailBox(_person2NameController.text, _person2PhoneController.text),
              const SizedBox(height: 20),
              buildHelperDetailBox(_person3NameController.text, _person3PhoneController.text),
            ],
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing; // Toggle between edit and display mode
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:  Text(
                  _isEditing ? 'Save Details' : 'Edit Profile',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a box with name and phone number
  Widget buildHelperDetailBox(String name, String phoneNumber) {
    return Container(
      padding: const  EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow:const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset:Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            phoneNumber,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a form for editing helper details
  Widget buildHelperEditForm(String personName, TextEditingController nameController, TextEditingController phoneController) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            personName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Name',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Mobile No.',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
