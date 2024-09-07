import 'package:flutter/material.dart';
import 'package:flutter_app1/signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Safety App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink[200]!),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Women Safety App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFED4D6), // Match the light pink background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCB2B5), // Slightly darker pink
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Make title bolder
            fontSize: 28, // Increase the font size
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.security,
                size: 120,
                color: Colors.black, // Consistent black color for the icon
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Black text for headings
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'This app is here to assist and protect you, ensuring your safety at all times.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54, // Slightly lighter text for the description
                  ),
                ),
              ),
              const SizedBox(height: 40), // Increased space between text and button

              // "Go to Sign Up Page" Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the SignUp page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Black button color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15), // Padding for the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Rounded button
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    Text(
                      'Sign In to get started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button (for future use)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use for other actions like help or emergency contacts
        },
        backgroundColor: Colors.black,
        tooltip: 'Help',
        child: const Icon(Icons.help, color: Colors.white),
      ),
    );
  }
}
