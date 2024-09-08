import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/main.dart';
import 'package:flutter_app1/profile.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart'; // Import your profile screen

class MyAppscreen extends StatelessWidget {
  const MyAppscreen ({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Safety App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TrackModeScreen(),
    );
  }
}

class TrackModeScreen extends StatefulWidget {
  const TrackModeScreen({super.key});
  
  @override
  _TrackModeScreenState createState() => _TrackModeScreenState();
}

class _TrackModeScreenState extends State<TrackModeScreen> {
  bool isTrackModeOn = false;
  SharedPreferences ? _prefs;
  String helperphone = '';
  @override
  void initState(){
    super.initState();
    _initPrefs();
  }
  void _initPrefs() async{
    _prefs = await SharedPreferences.getInstance();
    _getprefs();
  }
  void _getprefs(){
    setState(() {
     helperphone = _prefs?.getString('helperPhone') ?? 'null';
    });
     print('Get prefs method called.');
  }
  _callNumber(String number) async{ 
   await FlutterPhoneDirectCaller.callNumber(number);
  }
  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'This app uses your real-time location and microphone to record audio. Do you agree to grant these permissions?'
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  isTrackModeOn = false; // Keep track mode off
                });
              },
              child: const Text('Disagree'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                setState(() {
                  isTrackModeOn = true; // Turn track mode on
                });
              },
              child: const Text('Agree'),
            ),
          ],
        );
      },
    );
  }

  void _handleTrackModeChange(bool value) {
    if (value) {
      _showPermissionDialog(); // Show the permission dialog when turning on track mode
    } else {
      setState(() {
        isTrackModeOn = false; // Turn track mode off
      });
    }
  }

  void _showSafetyAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SafetyAlertDialog(
          onClose: () {
            _showEmergencySentMessage(); // Show emergency message after closing
            _getprefs();
            _callNumber(helperphone);
          },
        );
      },
    );
  }

  void _showEmergencySentMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Emergency Alert'),
          content: const Text('MESSAGE SENT TO YOUR EMERGENCY CONTACTS WITH YOUR LOCATION.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()), // Navigate to the HomePage
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set background to black
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SAW',
              style: TextStyle(
                fontSize: 28, // Increase font size for "SAW"
                fontWeight: FontWeight.w900, // Make text bolder
                letterSpacing: 1.5, // Increase letter spacing
                color: Colors.white, // White text color
              ),
            ),
            SizedBox(height: 5), // Space between lines
            Text(
              'Safety App for Women',
              style: TextStyle(
                fontSize: 18, // Font size for "Safety App for Women"
                fontWeight: FontWeight.w700, // Bold text for second line
                letterSpacing: 1.2, // Letter spacing for second line
                color: Colors.white, // White text color
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), // White icon
            onPressed: _logout,
          ),
        ],
      ),

      backgroundColor: const Color(0xFFF8E9E9), // light pink background
      body: Stack(
        children: [
          Positioned(
            top: 40, // Adjust this value to control how far from the top it should be
            left: 20, // Adjust this value to control the left spacing
            child: GestureDetector(
              onTap: () {
                // Navigate to Profile Page when profile icon or text is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()), // Make sure ProfileScreen is correctly imported
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.person, size: 30), // Profile Icon
                  SizedBox(width: 10),
                  Text(
                    'Welcome XXXXXX',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView( // Wrap content in SingleChildScrollView to avoid overflow
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100), // Adjust height so that content doesn't overlap with the profile
                    const Text(
                      'Home',
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Model',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Switch(
                      value: isTrackModeOn,
                      onChanged: _handleTrackModeChange, // Use the handler method
                      activeTrackColor: Colors.green,   // Green track when ON
                      inactiveTrackColor: Colors.black, // Black track when OFF
                      activeColor: Colors.white,        // White toggle button
                      inactiveThumbColor: Colors.white, // White toggle button
                    ),
                    Text(
                      isTrackModeOn ? 'ON' : 'OFF',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isTrackModeOn ? Colors.green : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Profile Page when "My Profile" button is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()), // Make sure Profile is correctly imported
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'My Profile',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80), // Add space to push the button down
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AbsorbPointer(
              absorbing: !isTrackModeOn,
              child: GestureDetector(
                onTap: isTrackModeOn ? _showSafetyAlert : null, // Show alert when button is tapped and track mode is on
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    color: isTrackModeOn ? Colors.red : Colors.grey, // Grey background when disabled
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(20), // Margin from the edges
                  child: const Text(
                    'Unsafe Environment Detected by the Model',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, // White text color
                      fontSize: 16,
                      fontWeight: FontWeight.bold, // Bold text
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SafetyAlertDialog extends StatefulWidget {
  final VoidCallback onClose;

   const SafetyAlertDialog({super.key,required this.onClose});

  @override
  
  _SafetyAlertDialogState createState() => _SafetyAlertDialogState();
}

class _SafetyAlertDialogState extends State<SafetyAlertDialog> {
  int _countdown = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
        Navigator.of(context).pop(); // Close the dialog when countdown finishes
        widget.onClose(); // Call onClose callback
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Safety Check'),
      content: Text('Are you safe?\nCountdown: $_countdown seconds'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            widget.onClose(); // Call onClose callback
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}