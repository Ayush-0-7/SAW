import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isEditing = false;

  final TextEditingController _person1NameController = TextEditingController();
  final TextEditingController _person1PhoneController = TextEditingController();
  final TextEditingController _person2NameController = TextEditingController();
  final TextEditingController _person2PhoneController = TextEditingController();
  final TextEditingController _person3NameController = TextEditingController();
  final TextEditingController _person3PhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data when the widget initializes
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _person1NameController.text = prefs.getString('person1_name') ?? 'Person 1';
      _person1PhoneController.text = prefs.getString('person1_phone') ?? '123-456-7890';
      _person2NameController.text = prefs.getString('person2_name') ?? 'Person 2';
      _person2PhoneController.text = prefs.getString('person2_phone') ?? '987-654-3210';
      _person3NameController.text = prefs.getString('person3_name') ?? 'Person 3';
      _person3PhoneController.text = prefs.getString('person3_phone') ?? '555-555-5555';
    });
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save all person details
    await prefs.setString('person1_name', _person1NameController.text);
    await prefs.setString('person1_phone', _person1PhoneController.text);
    await prefs.setString('person2_name', _person2NameController.text);
    await prefs.setString('person2_phone', _person2PhoneController.text);
    await prefs.setString('person3_name', _person3NameController.text);
    await prefs.setString('person3_phone', _person3PhoneController.text);

    // Store person 1 phone number as helperPhone
    await prefs.setString('helperPhone', _person1PhoneController.text);

    // Reload the updated data into the UI immediately after saving
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E9E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.person, color: Colors.black, size: 50),
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
                onPressed: () async {
                  if (_isEditing) {
                    await _saveData(); // Save data and update UI immediately
                  }
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
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

  Widget buildHelperDetailBox(String name, String phoneNumber) {
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
