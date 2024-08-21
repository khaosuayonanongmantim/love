import 'dart:async'; // Import the Timer class
import 'dart:ui'; // Import for BackdropFilter

import 'package:flutter/material.dart';
import 'package:project_new/ReadMorePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Message(),
    );
  }
}

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final PageController _pageController = PageController();
  final List<String> _images = [
    'assets/piano.jpg',
    'assets/party.jpg',
    'assets/cat.jpg',
    // Add more images here
  ];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page?.toInt() ?? 0) + 1;
        if (nextPage >= _images.length) {
          nextPage = 0; // Reset to the first page
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a gradient for the background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEECDA3), Color(0xFFEF629F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false, // Remove the back arrow
                backgroundColor: Colors.transparent, // Make the AppBar background transparent
                elevation: 0, // Remove the shadow
                title: Container(
                  width: 700, // Set the width for the search bar
                  height: 40,
                  margin: const EdgeInsets.only(top: 10), // Add margin to separate from text
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 229, 229),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2), // Add border here
                  ),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            // Clear the search field
                          },
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              // Enhanced styling for the header text
              Container(
                padding: const EdgeInsets.all(14.0), // Add padding
                width: double.infinity, // Take full width
                child: Container(
                  padding: const EdgeInsets.all(16.0), // Add padding around the text
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFAF3F3), Color(0xFFFFB6B9)], // Light pastel colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    '▶ 𝕴𝖓𝖋𝖔𝖗𝖒𝖆𝖙𝖎𝖔𝖓 ◀', // Enhanced text
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Dark color for better contrast
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          offset: Offset(2, 2),
                          color: Colors.white, // Add a white shadow to enhance readability
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center, // Center the text horizontally
                  ),
                ),
              ),
              SizedBox(
                height: 250, // Adjust the height of the image container
                width: 380,  // Adjust the width of the image container
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _images.length,
                  scrollDirection: Axis.vertical, // Scroll vertically
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double pageOffset = (_pageController.page ?? 0) - index;
                        double rotateX = pageOffset * 0.3; // Adjust the rotation angle for vertical scroll
                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.002) // Set the perspective
                            ..rotateX(rotateX), // Rotate the page
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  margin: const EdgeInsets.all(0), // Removed margin
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(_images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // Apply a more noticeable blur effect
                                    child: Container(
                                      color: Colors.black.withOpacity(0.2), // Slightly darken the background
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10, // Position the heading text at the top
                                left: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.black.withOpacity(0.7), // Darker background for better text visibility
                                  child: Text(
                                    'Heading for image $index',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22, // Increased font size for heading
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis, // Handle text overflow
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10, // Position the message text at the bottom
                                left: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.black.withOpacity(0.7), // Darker background for better text visibility
                                  child: Text(
                                    'Message for image $index',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis, // Handle text overflow
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // Enhanced styling for the footer text
              Container(
                padding: const EdgeInsets.all(14.0), // Add padding
                width: double.infinity, // Take full width
                child: Container(
                  padding: const EdgeInsets.all(16.0), // Add padding around the text
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFE6E6), Color(0xFFFF9AA2)], // Light pastel colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    '🔥𝗛𝗢𝗧 𝗡𝗘𝗪𝗦🔥', // New text here
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black, // Dark color for better contrast
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center, // Center the text horizontally
                  ),
                ),
              ),
              // Cards section
SizedBox(
  height: 500, // Adjust the height of the GridView container
  child: GridView.builder(
    padding: const EdgeInsets.all(16.0),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1, // One card per row
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      childAspectRatio: 2.5,
    ),
    itemCount: 3, // Number of cards
    itemBuilder: (context, index) {
      return Card(
        color: const Color(0xFFFFC1E3), // Softer pink color for the card background
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.card_giftcard,
              size: 50,
              color: Color(0xFFFF69B4), // Hot pink color for the icon
            ),
            const SizedBox(height: 8),
            Text(
              'Card ${index + 1}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Darker text color for contrast
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This is the description for card ${index + 1}.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black, // Darker text color for contrast
              ),
            ),
          ],
        ),
      );
    },
  ),
),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReadMorePage()), // Navigate to the ReadMorePage
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // Adjusted padding
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                      border: Border.all(color: Color.fromARGB(255, 249, 27, 216), width: 2), // Border color and width
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Padding inside the container
                      child: Text(
                        'ℝ𝔼𝔸𝔻 𝕄𝕆ℝ𝔼 >>',
                        style: const TextStyle(
                          fontSize: 20, // Slightly larger font size
                          color: Color.fromARGB(255, 255, 144, 222), // Color to match the border
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
