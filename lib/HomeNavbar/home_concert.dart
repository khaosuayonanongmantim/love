import 'dart:async'; // Import dart:async for Timer
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'concert_detail.dart'; // Import the ConcertDetail widget

class HomeConcert extends StatefulWidget {
  const HomeConcert({super.key});

  @override
  State<HomeConcert> createState() => _HomeConcertState();
}

class _HomeConcertState extends State<HomeConcert> {
  final PageController _controller = PageController();
  Timer? _timer;
  int selectedIndex = 0; // Store the selected index
  String selectedCategory = 'All'; // Track the selected category

  // Define the items for each category
  final Map<String, List<Map<String, String>>> categoryItems = {
    'All': [
      {'imagePath': 'assets/bar.jpg', 'text1': 'Rock Concert', 'text2': '10 ตุลาคม 2567', 'text3': '9 PM', 'text4': 'Main Stage', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/bar1.jpg', 'text1': 'Jazz Night', 'text2': '12 กันยายน 2567', 'text3': '8 PM', 'text4': 'Side Stage', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/bar2.jpg', 'text1': 'Pop Fest', 'text2': '11 คุลาคม 2567', 'text3': '7 PM', 'text4': 'Main Stage', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/con3.jpg', 'text1': 'Trance Mania', 'text2': '4 กันยายน 2567', 'text3': '10 PM', 'text4': 'Main Arena', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/sport1.jpg', 'text1': 'Inter Mix', 'text2': '3 สิงหาคม 2567', 'text3': '6 PM', 'text4': 'Main Hall', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/nunew.jpg', 'text1': 'T-pop Gala', 'text2': '10 กันยายน 2567', 'text3': '5 PM', 'text4': 'Side Hall', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/hip.jpg', 'text1': 'Hip-Hop Jam', 'text2': '25 กันยายน 2567', 'text3': '9 PM', 'text4': 'Outdoor Stage', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      // Add more items as needed
    ],
    'Trance': [
      {'imagePath': 'assets/con3.jpg', 'text1': 'Trance Mania', 'text2': '4 กันยายน 2567', 'text3': '10 PM', 'text4': 'Main Arena', 'boxColor': '0xFFE0E0E0', 'textColor': '0xFF000000'},
      // Add more items as needed
    ],
    'Inter': [
      {'imagePath': 'assets/sport1.jpg', 'text1': 'Inter Mix', 'text2': '3 สิงหาคม 2567', 'text3': '6 PM', 'text4': 'Main Hall', 'boxColor': '0xFFFFF3E0', 'textColor': '0xFF000000'},
      // Add more items as needed
    ],
    'T-pop': [
      {'imagePath': 'assets/nunew.jpg', 'text1': 'T-pop Gala', 'text2': '10 กันยายน 2567', 'text3': '5 PM', 'text4': 'Side Hall', 'boxColor': '0xFFFCE4EC', 'textColor': '0xFF000000'},
      // Add more items as needed
    ],
    'Hip-Hop': [
      {'imagePath': 'assets/hip.jpg', 'text1': 'Hip-Hop Jam', 'text2': '25 กันยายน 2567', 'text3': '9 PM', 'text4': 'Outdoor Stage', 'boxColor': '0xFFEEEEEE', 'textColor': '0xFF000000'},
      // Add more items as needed
    ]
    // Add more categories and items as needed
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
                  Color.fromARGB(255, 45, 122, 58),
                  Color.fromARGB(255, 37, 206, 22),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Page Content
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: SingleChildScrollView(
              // Add this to enable scrolling
              child: Column(
                children: [
                  // Header with Text and Back Icon
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ᴄᴏɴᴄᴇʀᴛ',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search for concerts...',
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Content Box with Carousel
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 186, 252, 202),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          height: 200,
                          child: PageView(
                            controller: _controller,
                            children: [
                              buildCarouselItem('assets/kini.png'),
                              buildCarouselItem('assets/nunew.jpg'),
                              buildCarouselItem('assets/chang.jpg'),
                              buildCarouselItem('assets/war.jpg'),
                              buildCarouselItem('assets/cat.jpg'),
                              buildCarouselItem('assets/piano.jpg'),
                              buildCarouselItem('assets/wan.jpg'),
                              buildCarouselItem('assets/threemandown.jpg'),
                              buildCarouselItem('assets/cocktail.jpg'),
                              buildCarouselItem('assets/scrub.jpg'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SmoothPageIndicator(
                          controller: _controller,
                          count: 10,
                          effect: WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 16,
                            activeDotColor: Colors.blue,
                            dotColor: Colors.grey,
                          ),
                        ),

                         Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              SizedBox(height: 50),
                              Text(
                                'ʜɪɢʜʟɪɢʜᴛ',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Recommended Images
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              buildImageWithText('assets/bar4.jpg'),
                              buildImageWithText('assets/bar2.jpg'),
                              buildImageWithText('assets/heap.jpg'),
                              buildImageWithText('assets/bar3.jpg'),
                              buildImageWithText('assets/party.jpg'),
                              buildImageWithText('assets/bar.jpg'),
                              buildImageWithText('assets/heap.jpg'),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              SizedBox(height: 50),
                              Text(
                                'ʀᴇʟᴀᴛᴇᴅ ᴛᴏᴘɪᴄᴇ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Circle Avatars with Text
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildCircleAvatar('assets/con3.jpg', 'All', 0),
                                buildCircleAvatar('assets/bell.jpg', 'Trance', 1),
                                buildCircleAvatar('assets/con1.png', 'Inter', 2),
                                buildCircleAvatar('assets/con2.png', 'T-pop', 3),
                                buildCircleAvatar('assets/hip.jpg', 'Hip-Hop', 4),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Content List
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: categoryItems[selectedCategory]!
                                .map((item) => buildImageWithTextAndBox(item))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCircleAvatar(String imagePath, String text, int index) {
  return GestureDetector(
    onTap: () {
      setState(() {
        selectedCategory = text;
        selectedIndex = index;
      });
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
            backgroundColor: selectedIndex == index
                ? Colors.green
                : Colors.transparent,
          ),
          SizedBox(height: 4),
          Stack(
            children: [
              // Underline
              if (selectedIndex == index)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2,
                    color: Color.fromARGB(255, 10, 128, 14),
                  ),
                ),
              // Text
              Text(
                text,
                style: TextStyle(
                  color: selectedIndex == index
                      ? const Color.fromARGB(255, 22, 102, 25)
                      : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

   Widget buildImageWithText(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildCarouselItem(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: selectedCategory == category ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: selectedCategory == category ? Colors.blue : Colors.grey,
          ),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              color: selectedCategory == category ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageWithTextAndBox(Map<String, String> item) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConcertDetail(
            imagePath: item['imagePath']!,
            text1: item['text1']!,
            text2: item['text2']!,
            text3: item['text3']!,
            text4: item['text4']!,
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(int.parse(item['boxColor']!)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          // ClipRRect to apply rounded corners to the image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
            child: Image.asset(
              item['imagePath']!,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['text1']!,
                  style: TextStyle(
                    color: Color(int.parse(item['textColor']!)),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined, size: 16, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      item['text2']!,
                      style: TextStyle(
                        color: Color(int.parse(item['textColor']!)),
                         fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.timer_sharp, size: 16, color: Colors.blue),
                    SizedBox(width: 4),
                    Text(
                      item['text3']!,
                      style: TextStyle(
                        color: Color(int.parse(item['textColor']!)),
                         fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded, size: 16, color: Colors.red),
                    SizedBox(width: 4),
                    Text(
                      item['text4']!,
                      style: TextStyle(
                        color: Color(int.parse(item['textColor']!)),
                         fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Add the 'Buy Tickets' button
                ElevatedButton(
                  onPressed: () {
                    // Action when the button is pressed
                    // You can navigate to another screen or show a dialog
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 255, 29, 13), // Background color
                    onPrimary: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  child: Text(
                    'ซื้อบัตร',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
