import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSport extends StatefulWidget {
  const HomeSport({super.key});

  @override
  State<HomeSport> createState() => _HomeSportState();
}

class _HomeSportState extends State<HomeSport> {
  final PageController _controller = PageController();
  String selectedCategory = 'All';

  final Map<String, List<Map<String, String>>> categoryItems = {
    'All': [
      {
        'imagePath': 'assets/bar.jpg',
        'text1': 'ʀᴏᴄᴋ ᴄᴏɴᴄᴇʀᴛ',
        'text2': '10 ตุลาคม 2567',
        'text3': '9 PM',
        'text4': 'Main Stage',
        'boxColor': '0xFFFFFFFF',
        'textColor': '0xFF000000'
      },
      {
        'imagePath': 'assets/bar1.jpg',
        'text1': 'ᴊᴀᴢᴢ ɴɪɢʜᴛ',
        'text2': '12 กันยายน 2567',
        'text3': '8 PM',
        'text4': 'Side Stage',
        'boxColor': '0xFFFFFFFF',
        'textColor': '0xFF000000'
      },
      {
        'imagePath': 'assets/bar2.jpg',
        'text1': 'ᴘᴏᴘ ꜰᴇꜱᴛ',
        'text2': '11 คุลาคม 2567',
        'text3': '7 PM',
        'text4': 'Main Stage',
        'boxColor': '0xFFFFFFFF',
        'textColor': '0xFF000000'
      },
      {
        'imagePath': 'assets/con3.jpg',
        'text1': 'ᴛʀᴀɴᴄᴇ ᴍᴀɴɪᴀ',
        'text2': '4 กันยายน 2567',
        'text3': '10 PM',
        'text4': 'Main Arena',
        'boxColor': '0xFFFFFFFF',
        'textColor': '0xFF000000'
      },
      {
        'imagePath': 'assets/sport1.jpg',
        'text1': 'ɪɴᴛᴇʀ ᴍɪx',
        'text2': '3 สิงหาคม 2567',
        'text3': '6 PM',
        'text4': 'Main Hall',
        'boxColor': '0xFFFFFFFF',
        'textColor': '0xFF000000'
      },
      {
        'imagePath': 'assets/nunew.jpg',
        'text1': 'ᴛ-ᴘᴏᴘ ɢᴀʟᴀ',
        'text2': '10 กันยายน 2567',
        'text3': '5 PM',
        'text4': 'Side Hall',
        'boxColor': '0xFFFFFFFF',
        'textColor': '0xFF000000'
      },
      {
        'imagePath': 'assets/hip.jpg',
        'text1': 'ʜɪᴘ-ʜᴏᴘ ᴊᴀᴍ',
        'text2': '25 กันยายน 2567',
        'text3': '9 PM',
        'text4': 'Outdoor Stage',
        'boxColor': '0xFFFFFFFF',
        'textColor': '0xFF000000'
      },
      // Add more items as needed
    ],
    // Add more categories and items as needed
    'Trance': [
      {
        'imagePath': 'assets/con3.jpg',
        'text1': 'Trance Mania',
        'text2': '4 กันยายน 2567',
        'text3': '10 PM',
        'text4': 'Main Arena',
        'boxColor': '0xFFE0E0E0',
        'textColor': '0xFF000000'
      },
      // Add more items as needed
    ],
    'Inter': [
      {
        'imagePath': 'assets/sport1.jpg',
        'text1': 'Inter Mix',
        'text2': '3 สิงหาคม 2567',
        'text3': '6 PM',
        'text4': 'Main Hall',
        'boxColor': '0xFFFFF3E0',
        'textColor': '0xFF000000'
      },
      // Add more items as needed
    ],
    'T-pop': [
      {
        'imagePath': 'assets/nunew.jpg',
        'text1': 'T-pop Gala',
        'text2': '10 กันยายน 2567',
        'text3': '5 PM',
        'text4': 'Side Hall',
        'boxColor': '0xFFFCE4EC',
        'textColor': '0xFF000000'
      },
      // Add more items as needed
    ],
    'Hip-Hop': [
      {
        'imagePath': 'assets/hip.jpg',
        'text1': 'Hip-Hop Jam',
        'text2': '25 กันยายน 2567',
        'text3': '9 PM',
        'text4': 'Outdoor Stage',
        'boxColor': '0xFFEEEEEE',
        'textColor': '0xFF000000'
      },
      // Add more items as needed
    ]
  };

  final List<String> _imagePaths = [
    'assets/sport6.jpg',
    'assets/sport5.jpg',
    'assets/sport3.jpg',
    'assets/sport.jpg',
    'assets/sport2.jpg',
    'assets/sport1.jpg',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpToPage(_imagePaths.length); // Start at the middle page
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFC0CB),
                  Color(0xFFB39DDB),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                          'ꜱᴘᴏʀᴛ',
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
                          hintText: 'Search for sports...',
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
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE0F0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 200, // Increase the height for a larger image
                          child: PageView.builder(
                            controller: _controller,
                            itemCount: _imagePaths.length * 3,
                            itemBuilder: (context, index) {
                              // To create a looping effect
                              final actualIndex = index % _imagePaths.length;
                              return buildCarouselItem(
                                  _imagePaths[actualIndex]);
                            },
                            onPageChanged: (index) {
                              if (index == 0) {
                                _controller.jumpToPage(_imagePaths.length);
                              } else if (index == _imagePaths.length * 2 - 1) {
                                _controller.jumpToPage(_imagePaths.length - 1);
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        SmoothPageIndicator(
                          controller: _controller,
                          count: _imagePaths.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor: Colors.pinkAccent,
                            dotColor: Colors.grey,
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              SizedBox(height: 70),
                              Text(
                                'ʜɪɢʜʟɪɢʜᴛ',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.pink,
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
                        SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              SizedBox(height: 50),
                              Text(
                                'ʀᴇʟᴀᴛᴇᴅ ᴛᴏᴘɪᴄᴇ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: categoryItems.keys.map((category) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  decoration: BoxDecoration(
                                    color: selectedCategory == category
                                        ? Colors.pinkAccent
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      category,
                                      style: TextStyle(
                                        color: selectedCategory == category
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Concert List
                        Column(
                          children: categoryItems[selectedCategory]
                                  ?.map((item) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 16.0),
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(item['boxColor']!)),
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  //รูปภาพในกรอบข้างล่าง
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 120,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      item['imagePath']!),
                                                  fit: BoxFit.cover,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 4,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 16.0,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item['text1']!,
                                                    style: TextStyle(
                                                      color: Color(int.parse(
                                                          item['textColor']!)),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          25, // Adjust font size
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    item['text2']!,
                                                    style: TextStyle(
                                                      color: Color(int.parse(
                                                          item['textColor']!)),
                                                      fontSize:
                                                          16, // Adjust font size
                                                    ),
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  Text(
                                                    '${item['text3']} at ${item['text4']}',
                                                    style: TextStyle(
                                                      color: Color(int.parse(
                                                          item['textColor']!)),
                                                      fontSize:
                                                          14, // Adjust font size
                                                    ),
                                                  ),
                                                  Container(
                                        padding: const EdgeInsets.all(10.0),
                                        alignment: Alignment.centerLeft,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Add your ticket purchasing logic here
                                          },
                                          child: Text('Buy Tickets'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .pinkAccent, // Button color
                                            onPrimary:
                                                Colors.white, // Text color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                );
                              }).toList() ??
                              [],
                        ),
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
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
