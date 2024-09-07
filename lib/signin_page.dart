import 'package:flutter/material.dart';
import 'package:flutter_app1/app_screen.dart'; // Ensure this is the correct path
import 'package:flutter_app1/main.dart'; // Make sure MyApp is correctly imported
import 'package:flutter_app1/signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  // Function to show a dialog allowing the user to choose the login result
  void _simulateLoginResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Simulate Login Result'),
          content: const Text('Choose whether the login is successful or not for testing.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _showLoginResultDialog(context, true); // Simulate successful login
              },
              child: const Text('Successful', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _showLoginResultDialog(context, false); // Simulate unsuccessful login
              },
              child: const Text('Unsuccessful', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Function to show the login result dialog
  void _showLoginResultDialog(BuildContext context, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isSuccess ? 'Login Successful' : 'Login Unsuccessful'),
          content: Text(
            isSuccess
                ? 'You have successfully logged in!'
                : 'Login failed. Please try again.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                if (isSuccess) {
                  // If login is successful, redirect to the MyAppscreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAppscreen(), // Correct home page widget
                    ),
                  );
                }
              },
              child: Text(
                isSuccess ? 'Go to Home' : 'Try Again',
                style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFED4D6), // Light pink background similar to SignUpPage
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>const MyApp()), // Correct home page widget
                      );
                    },
                    child: const Icon(
                      Icons.lock_outline,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sign In to Your Account',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40), // Space between title and fields
                  
                  // Input Fields
                  CustomTextField(
                    hintText: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: "Password",
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30), // Space between fields and button

                  // SignIn Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Show the dialog to let the user choose if login is successful or not
                        _simulateLoginResultDialog(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Black button color
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), // Rounded button
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20), // Space between button and SignUp

                  // SignUp Option
                  GestureDetector(
                    onTap: () {
                      // Navigate to SignUp Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      'New User? SignUp',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom TextField Widget for Input Fields with Validation
class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const CustomTextField(
    
    {super.key,required this.hintText, this.obscureText = false, this.validator}
    );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(
            color: Colors.black54,
          ),
        ),
        validator: validator, // Use the validator passed from parent
      ),
    );
  }
}
