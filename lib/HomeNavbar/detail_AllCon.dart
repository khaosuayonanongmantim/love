import 'dart:async'; // Import dart:async for Timer
import 'package:flutter/material.dart';

class DetailCon extends StatefulWidget {
  const DetailCon({super.key});

  @override
  State<DetailCon> createState() => _DetailConState();
}

class _DetailConState extends State<DetailCon> {
  final PageController _controller = PageController();
  Timer? _timer;
  int selectedIndex = 0; // Store the selected index

  // Define the items for each category
  final Map<String, List<Map<String, String>>> categoryItems = {
    'All': [
      {
        'imagePath': 'assets/bar.jpg',
        'title': 'Rock Concert',
      },
      {
        'imagePath': 'assets/bar1.jpg',
        'title': 'Jazz Night',
      },
      {
        'imagePath': 'assets/bar2.jpg',
        'title': 'Pop Fest',
      },
      {
        'imagePath': 'assets/con3.jpg',
        'title': 'Trance Mania',
      },
      {
        'imagePath': 'assets/sport1.jpg',
        'title': 'Inter Mix',
      },
      {
        'imagePath': 'assets/nunew.jpg',
        'title': 'T-pop Gala',
      },
      {
        'imagePath': 'assets/hip.jpg',
        'title': 'Hip-Hop Jam',
      },
    ],
    // Add more categories as needed
  };

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _controller.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.removeListener(_onPageChanged);
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_controller.hasClients) {
        final nextPage = (_controller.page!.toInt() + 1) % 10;
        _controller.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onPageChanged() {
    final page = _controller.page?.round() ?? 0;
    if (page == 9) {
      _controller.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 243, 134, 219), // Soft Pink
                  Color.fromARGB(255, 122, 194, 255), // Light Blue
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50), // Adjusted height for consistency
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    const SizedBox(
                        width: 8), // Reduce the spacing between arrow and text
                    const Text(
                      'Concerts & Events',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif', // Custom font for header
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        15), // Increase border radius for a softer look
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12, // Subtle shadow
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search concerts, events, and more…',
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 170,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                          image: const DecorationImage(
                            image: AssetImage('assets/con3.jpg'), // Adjust path
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.3), // Dark overlay for better readability
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'ᴄᴏɴᴄᴇʀᴛ ᴅᴇᴛᴀɪʟꜱ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Vibrant Red
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: categoryItems['All']!.length,
                    itemBuilder: (context, index) {
                      final item = categoryItems['All']![index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10), // Rounded image corners
                              child: Image.asset(
                                item['imagePath']!,
                                width: 120,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .deepPurple, // Change title color
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // Handle button press
                                      },
                                      icon: const Icon(
                                          Icons.confirmation_number,
                                          color: Colors
                                              .black), // Set icon color to black
                                      label: const Text(
                                        'รายละเอียด',
                                        style: TextStyle(
                                            color: Colors
                                                .black), // Set text color to black
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .blue, // Set button background color to blue
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20), // Rounded button
                                        ),
                                        elevation: 5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
