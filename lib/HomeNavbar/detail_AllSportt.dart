import 'dart:async';
import 'package:flutter/material.dart';

class DetailSport extends StatefulWidget {
  const DetailSport({super.key});

  @override
  State<DetailSport> createState() => _DetailSportState();
}

class _DetailSportState extends State<DetailSport> {
  final PageController _controller = PageController();
  Timer? _timer;
  int selectedIndex = 0;

  // Define the items for each category
  final Map<String, List<Map<String, String>>> categoryItems = {
    'All': [
      {'imagePath': 'assets/bar.jpg', 'text1': 'ʀᴏᴄᴋ ᴄᴏɴᴄᴇʀᴛ', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/bar1.jpg', 'text1': 'ᴊᴀᴢᴢ ɴɪɢʜᴛ', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/bar2.jpg', 'text1': 'ᴘᴏᴘ ꜰᴇꜱᴛ', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/con3.jpg', 'text1': 'ᴛʀᴀɴᴄᴇ ᴍᴀɴɪᴀ', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/sport1.jpg', 'text1': 'ɪɴᴛᴇʀ ᴍɪx', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/nunew.jpg', 'text1': 'ᴛ-ᴘᴏᴘ ɢᴀʟᴀ', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      {'imagePath': 'assets/hip.jpg', 'text1': 'ʜɪᴘ-ʜᴏᴘ ᴊᴀᴍ', 'boxColor': '0xFFFFFFFF', 'textColor': '0xFF000000'},
      // Add more items as needed
    ],
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
              const SizedBox(height: 50),
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
                    const SizedBox(width: 8),
                    const Text(
                      'Sports & Events',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif',
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
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search sports, events, and more…',
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
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage('assets/sport5.jpg'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
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
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'ꜱᴘᴏʀᴛꜱ ᴅᴇᴛᴀɪʟꜱ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categoryItems['All']?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = categoryItems['All']![index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.asset(
                              item['imagePath']!,
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['text1']!,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Color(int.parse(item['textColor']!)),
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Handle button press
                                  },
                                  icon: const Icon(Icons.confirmation_number, color: Colors.black),
                                  label: const Text(
                                    'รายละเอียด',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 5,
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
            ],
          ),
        ],
      ),
    );
  }
}
