import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/BuyTicketSport.dart';

class HomeSport extends StatefulWidget {
  const HomeSport({super.key});

  @override
  State<HomeSport> createState() => _HomeSportState();
}

class _HomeSportState extends State<HomeSport> {
  bool _isHovered = false;

  final PageController _controller = PageController();
  String selectedCategory = 'ทั้งหมด';

  final Map<String, List<Map<String, String>>> categoryItems = {
    'ทั้งหมด': [
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
    ],
    'BOXING': [
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
    'FOOTBALL': [
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
    'OTHER': [
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
  };

  @override
  void initState() {
    super.initState();
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
                  Color.fromARGB(255, 238, 163, 192),
                  Color(0xFFEF629F),
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
                      color: Color.fromARGB(255, 252, 186, 232),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height: 20), // เพิ่มช่องว่างระหว่างข้อความกับรูปภาพ
                        Image.asset(
                          'assets/sport.gif', // เปลี่ยนเป็นชื่อไฟล์ภาพที่คุณต้องการแสดง
                          width: 370, // กำหนดความกว้างของรูปภาพ
                          height: 200, // กำหนดความสูงของรูปภาพ
                          fit: BoxFit.cover, // ปรับขนาดรูปภาพให้พอดี
                        ),

                        //ประเภทการแข่งขัน
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ประเภทการแข่งขันกีฬา',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0), // เพิ่มช่องว่างเล็กน้อย
                                child: Text(
                                  'ᴛʜᴇ ᴛʀᴏᴘʜʏ ɪꜱ ɪɴ ꜰʀᴏɴᴛ ᴏꜰ ʏᴏᴜ.  ɪꜱ ɪɴ ʏᴏᴜʀ ʜᴇᴀʀᴛ.\n',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                  ),
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
                              buildImageWithText('assets/bat.jpg', 'แบตมินตัน'),
                              buildImageWithText(
                                  'assets/bas.jpg', 'บาสเก็ตบอล'),
                              buildImageWithText('assets/ball.jpg', 'ฟุตบอล'),
                              buildImageWithText(
                                  'assets/val.jpg', 'วอลเลย์บอล'),
                              buildImageWithText('assets/pig.jpg', 'ปิงปอง'),
                            ],
                          ),
                        ),

                        //การแข่งขันกีฬา
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'การแข่งขันกีฬากับผู้ต่อสู้',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isHovered = !_isHovered;
                                  });
                                },
                                child: MouseRegion(
                                  onEnter: (_) =>
                                      setState(() => _isHovered = true),
                                  onExit: (_) =>
                                      setState(() => _isHovered = false),
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    child: _isHovered
                                        ? Image.asset(
                                            'assets/sports1.jpg', // รูปที่สองจะแสดงเมื่อวางเมาส์/แตะ
                                            key: ValueKey('sports1'),
                                            width: 400,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/sports.jpg', // รูปภาพเริ่มต้น
                                            key: ValueKey('sports'),
                                            width: 400,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      10), // ช่องว่างระหว่างรูปภาพหลักและรูปภาพด้านล่าง
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildSmallImage(
                                      'assets/sports3.webp'), // รูปแรก
                                  buildSmallImage(
                                      'assets/sports4.jpg'), // รูปที่สอง
                                ],
                              ),
                              SizedBox(height: 10), // ช่องว่างระหว่างแถวรูปภาพ
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildSmallImage(
                                      'assets/sports5.jpg'), // รูปที่สาม
                                  buildSmallImage(
                                      'assets/sports2.jpg'), // รูปที่สี่
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 35, // ความสูง
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
                                      horizontal: 5.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 5.0),
                                  width: 100, // ปรับความกว้างของแต่ละหมวดหมู่
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
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 10),
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
                                        color: const Color.fromARGB(66, 236, 9, 9),
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
                                              height: 170,
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
                                            SizedBox(
                                              width: 16.0,
                                            ),
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
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .calendar_today, // หรือใช้ไอคอนที่คุณต้องการ
                                                        color: Colors
                                                            .green, // เปลี่ยนสีของไอคอนเป็นสีเขียว
                                                        size:
                                                            20, // ปรับขนาดไอคอนตามต้องการ
                                                      ),// เพิ่มระยะห่างระหว่างไอคอนและข้อความ
                                                      Text(
                                                        item['text2']!,
                                                        style: TextStyle(
                                                          color: Color(
                                                              int.parse(item[
                                                                  'textColor']!)),
                                                          fontSize:
                                                              16, // ปรับขนาดฟอนต์
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start, // ให้จัดชิดซ้าย
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .access_time, // ไอคอนนาฬิกา
                                                            color: Colors
                                                                .blue, // สีฟ้า
                                                            size:
                                                                16, // ขนาดของไอคอน
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  4), // ระยะห่างระหว่างไอคอนกับข้อความ
                                                          Text(
                                                            item['text3']!,
                                                            style: TextStyle(
                                                              color: Color(int
                                                                  .parse(item[
                                                                      'textColor']!)),
                                                              fontSize:
                                                                  14, // ขนาดฟอนต์
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .push_pin, // ไอคอนปักหมุด
                                                            color: Color.fromARGB(255, 236, 20, 4), // สีแดง
                                                            size:
                                                                16, // ขนาดของไอคอน
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  4), // ระยะห่างระหว่างไอคอนกับข้อความ
                                                          Text(
                                                            item['text4']!,
                                                            style: TextStyle(
                                                              color: Color(int
                                                                  .parse(item[
                                                                      'textColor']!)),
                                                              fontSize:
                                                                  14, // ขนาดฟอนต์
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                           Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                     builder: (context) => SportPlan(),
                                                       ),
                                                       );

                                                      },
                                                      child: Text('ซื้อบัตร'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color.fromARGB(255, 241, 30, 14), // Button color
                                                        onPrimary: Colors
                                                            .white, // Text color
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
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

  Widget buildImageWithText(String imagePath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 75, 180).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 200,
                height: 170, // Adjust height as needed
              ),
            ),
            Positioned(
              bottom: 10, // Adjust position as needed
              left: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.6), // Semi-transparent background
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ],
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

  Widget buildSmallImage(String imagePath) {
    return Container(
      width: 180, // ความกว้างของรูปภาพเล็ก
      height: 100, // ความสูงของรูปภาพเล็ก
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
