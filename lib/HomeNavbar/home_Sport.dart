import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_new/HomeNavbar/sport_detail.dart';

class HomeSport extends StatefulWidget {
  const HomeSport({super.key});

  @override
  State<HomeSport> createState() => _HomeSportState();
}

class _HomeSportState extends State<HomeSport> {
  bool _isHovered = false;
  final PageController _controller = PageController();
  int selectedIndex = 0;
  String selectedCategory = 'ทั้งหมด';
  List<dynamic> _sportImage = [];
  List<dynamic> _sport = [];
  List<dynamic> _sportBox = [];
  List<dynamic> _sportFootball = [];
  List<dynamic> _sportOther = [];
  List<dynamic> _Image = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSportsImage();
    fetchImages();
    fetchSports();
    fetchSportsBox();
    fetchSportsFootball();
    fetchSportsOther();
  }

  String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      print("Error formatting date: $e");
      return dateString; // หากเกิดข้อผิดพลาด ให้แสดงวันที่เดิม
    }
  }

  Future<void> fetchSportsImage() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.55.228:5000/sportsImage'));
      if (response.statusCode == 200) {
        setState(() {
          _sportImage = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

  Future<void> fetchImages() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.55.228:5000/getImages'));
      if (response.statusCode == 200) {
        setState(() {
          _Image = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

  var categoryItems = {
    'ทั้งหมด': [],
    'BOXING': [],
    'FOOTBALL': [],
    'OTHER': [],
  };

  Future<void> fetchSports() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.55.228:5000/getAllSports'));
      if (response.statusCode == 200) {
        List<dynamic> concerts = jsonDecode(response.body);

        // แปลงข้อมูลจาก API ให้อยู่ในรูปแบบ categoryItems
        Map<String, List<Map<String, String>>> updatedCategories = {
          'ทั้งหมด': [],
          'BOXING': [],
          'FOOTBALL': [],
          'OTHER': [],
        };

        for (var concert in concerts) {
          String category = concert['category'] ?? 'ทั้งหมด';
          if (!updatedCategories.containsKey(category)) {
            updatedCategories[category] = [];
          }

          updatedCategories[category]!.add({
            'imagePath': concert['image'] ?? 'assets/default.jpg',
            'text1': concert['name'] ?? 'Unknown Concert',
            'text2': concert['date'] ?? 'Unknown Date',
            'text3': concert['time'] ?? 'Unknown Time',
            'text4': concert['location'] ?? 'Unknown Location',
            'text5': concert['price'] ?? 'N/A', // เพิ่มราคาที่รับจาก API
            'boxColor': '0xFFFFFFFF',
            'textColor': '0xFF000000',
          });
        }

        setState(() {
          // รวมข้อมูลของ API นี้เข้ากับ categoryItems เดิม
          categoryItems.forEach((key, value) {
            if (updatedCategories.containsKey(key)) {
              categoryItems[key]!.addAll(updatedCategories[key]!);
            }
          });
          _sport = concerts;
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

  Future<void> fetchSportsBox() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllSportsBoxing'));
      if (response.statusCode == 200) {
        List<dynamic> concerts = jsonDecode(response.body);

        // แปลงข้อมูลจาก API ให้อยู่ในรูปแบบ categoryItems
        Map<String, List<Map<String, String>>> updatedCategories = {
          'ทั้งหมด': [],
          'BOXING': [],
          'FOOTBALL': [],
          'OTHER': [],
        };

        for (var concert in concerts) {
          String category = concert['category'] ?? 'BOXING';
          if (!updatedCategories.containsKey(category)) {
            updatedCategories[category] = [];
          }

          updatedCategories[category]!.add({
            'imagePath': concert['image'] ?? 'assets/default.jpg',
            'text1': concert['name'] ?? 'Unknown Concert',
            'text2': concert['date'] ?? 'Unknown Date',
            'text3': concert['time'] ?? 'Unknown Time',
            'text4': concert['location'] ?? 'Unknown Location',
            'text5': concert['price'] ?? 'N/A',
            'boxColor': '0xFFFFFFFF',
            'textColor': '0xFF000000',
          });
        }

        setState(() {
          // รวมข้อมูลของ API นี้เข้ากับ categoryItems เดิม
          categoryItems.forEach((key, value) {
            if (updatedCategories.containsKey(key)) {
              categoryItems[key]!.addAll(updatedCategories[key]!);
            }
          });
          _sportBox = concerts;
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }
  
  Future<void> fetchSportsFootball() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllSportsFootball'));
      if (response.statusCode == 200) {
        List<dynamic> concerts = jsonDecode(response.body);

        // แปลงข้อมูลจาก API ให้อยู่ในรูปแบบ categoryItems
        Map<String, List<Map<String, String>>> updatedCategories = {
          'ทั้งหมด': [],
          'BOXING': [],
          'FOOTBALL': [],
          'OTHER': [],
        };

        for (var concert in concerts) {
          String category = concert['category'] ?? 'FOOTBALL';
          if (!updatedCategories.containsKey(category)) {
            updatedCategories[category] = [];
          }

          updatedCategories[category]!.add({
            'imagePath': concert['image'] ?? 'assets/default.jpg',
            'text1': concert['name'] ?? 'Unknown Concert',
            'text2': concert['date'] ?? 'Unknown Date',
            'text3': concert['time'] ?? 'Unknown Time',
            'text4': concert['location'] ?? 'Unknown Location',
            'text5': concert['price'] ?? 'N/A',
            'boxColor': '0xFFFFFFFF',
            'textColor': '0xFF000000',
          });
        }

        setState(() {
          // รวมข้อมูลของ API นี้เข้ากับ categoryItems เดิม
          categoryItems.forEach((key, value) {
            if (updatedCategories.containsKey(key)) {
              categoryItems[key]!.addAll(updatedCategories[key]!);
            }
          });
          _sportFootball = concerts;
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }
  
  Future<void> fetchSportsOther() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllSportsOther'));
      if (response.statusCode == 200) {
        List<dynamic> concerts = jsonDecode(response.body);

        // แปลงข้อมูลจาก API ให้อยู่ในรูปแบบ categoryItems
        Map<String, List<Map<String, String>>> updatedCategories = {
          'ทั้งหมด': [],
          'BOXING': [],
          'FOOTBALL': [],
          'OTHER': [],
        };

        for (var concert in concerts) {
          String category = concert['category'] ?? 'OTHER';
          if (!updatedCategories.containsKey(category)) {
            updatedCategories[category] = [];
          }

          updatedCategories[category]!.add({
            'imagePath': concert['image'] ?? 'assets/default.jpg',
            'text1': concert['name'] ?? 'Unknown Concert',
            'text2': concert['date'] ?? 'Unknown Date',
            'text3': concert['time'] ?? 'Unknown Time',
            'text4': concert['location'] ?? 'Unknown Location',
            'text5': concert['price'] ?? 'N/A',
            'boxColor': '0xFFFFFFFF',
            'textColor': '0xFF000000',
          });
        }

        setState(() {
          // รวมข้อมูลของ API นี้เข้ากับ categoryItems เดิม
          categoryItems.forEach((key, value) {
            if (updatedCategories.containsKey(key)) {
              categoryItems[key]!.addAll(updatedCategories[key]!);
            }
          });
          _sportOther = concerts;
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
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
                            children: _sportImage.map((sport) {
                              return buildImageWithText(
                                sport['image'] ?? 'assets/default.jpg',
                                sport['name'] ?? 'Default Name',
                              );
                            }).toList(),
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
                              ), // ช่องว่างระหว่างรูปภาพหลักและรูปภาพด้านล่าง
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 รูปต่อแถว
                                  crossAxisSpacing: 8, // ระยะห่างแนวนอน
                                  mainAxisSpacing: 8, // ระยะห่างแนวตั้ง
                                  childAspectRatio: 1.8, // อัตราส่วนของรูปภาพ
                                ),
                                shrinkWrap: true,
                                physics:
                                    NeverScrollableScrollPhysics(), // ป้องกันการเลื่อนซ้ำซ้อน
                                itemCount: _Image.length,
                                itemBuilder: (context, index) {
                                  return buildSmallImage(_Image[index]
                                          ['image'] ??
                                      'assets/default.jpg');
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildCircleAvatar('ทั้งหมด', 0),
                                buildCircleAvatar('BOXING', 1),
                                buildCircleAvatar('FOOTBALL', 2),
                                buildCircleAvatar('OTHER', 3),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Content List
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: (_isLoading
                                    ? [] // ถ้ายังโหลดข้อมูลอยู่ ให้แสดงเป็นค่าว่าง
                                    : categoryItems[selectedCategory] ??
                                        []) // ใช้ข้อมูลจาก selectedCategory
                                .map((item) => buildImageWithTextAndBox(
                                    item)) // แปลงแต่ละ item เป็น widget
                                .toList(),
                          ),
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

  Widget buildCircleAvatar(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = text;
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? Colors.pink.withOpacity(0.2)
              : Colors.white, // พื้นหลังของกรอบ
          borderRadius: BorderRadius.circular(30), // มุมโค้งมน
          border: Border.all(
            color: selectedIndex == index
                ? Colors.white
                : Colors.white, // สีของกรอบ
            width: 2,
          ),
        ),
        width: 130, // ปรับความกว้างของกรอบ
        height: 40, // ปรับความสูงของกรอบ
        child: Center(
          // จัดตำแหน่งข้อความให้อยู่กลาง
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Text
              Text(
                text,
                style: TextStyle(
                  color: selectedIndex == index ? Colors.pink : Colors.black,
                  fontSize: 16, // ปรับขนาดตัวอักษร
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageWithTextAndBox(Map<String, String> item) {
    // กำหนด URL ของรูปภาพ
    // แปลงวันที่ให้แสดงในรูปแบบ dd/MM/yyyy
    String formattedDate = formatDate(item['text2']!);

    String imageUrl = 'http://192.168.55.228/sport/all/' + item['imagePath']!;

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(int.parse(item['boxColor']!)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            // ใช้ Image.network แทน NetworkImage
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 100,
                height: 140,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // ถ้าภาพโหลดเสร็จแล้ว ให้แสดงภาพเลย
                    } else {
                      // ถ้ายังโหลดไม่เสร็จ ให้แสดง CircularProgressIndicator
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['text1']!, // ชื่อคอนเสิร์ต
                    style: TextStyle(
                      color: Color(int.parse(item['textColor']!)),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined,
                          size: 16, color: Colors.green),
                      Text(
                        ' $formattedDate', // ใช้วันที่ที่แปลงแล้ว
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.timer_sharp, size: 16, color: Colors.blue),
                      SizedBox(width: 4),
                      Text(
                        item['text3']!, // วัน
                        style: TextStyle(
                          color: Color(int.parse(item['textColor']!)),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.push_pin, size: 16, color: Colors.red),
                      SizedBox(width: 4),
                      Expanded(
                        // ใช้ Expanded เพื่อให้ข้อความยืดออกไปได้
                        child: Text(
                          item['text4']!, // สถานที่
                          style: TextStyle(
                            color: Color(int.parse(item['textColor']!)),
                            fontSize: 16,
                          ),
                          softWrap:
                              true, // จะทำให้ข้อความขึ้นบรรทัดใหม่ถ้ายาวเกิน
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),
                  // Add the 'Buy Tickets' button
                  ElevatedButton(
                    onPressed: () {
                      // ตรวจสอบค่า
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SportDetail(
                            imagePath: imageUrl, // เปลี่ยนเป็น URL เต็ม
                            text1: item['text1']!,
                            text2: item['text2']!,
                            text3: item['text3']!,
                            text4: item['text4']!,
                            text5: item['text5'] ?? 'ไม่มีข้อมูล',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 29, 13),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
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

  Widget buildImageWithText(String imagePath, String text) {
    String imageUrl = 'http://192.168.55.228/sport/$imagePath';

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
              child: Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: imageUrl.startsWith('http')
                        ? NetworkImage(imageUrl) // ใช้ NetworkImage ถ้าเป็น URL
                        : AssetImage(imageUrl)
                            as ImageProvider, // ใช้ AssetImage ถ้าเป็น local file
                    fit: BoxFit.cover,
                  ),
                ),
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

  Widget buildSmallImage(String imagePath) {
    String imageUrl = 'http://192.168.55.228/sport/$imagePath';

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
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 150,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: imageUrl.startsWith('http')
                  ? NetworkImage(imageUrl) // ใช้ NetworkImage ถ้าเป็น URL
                  : AssetImage(imageUrl)
                      as ImageProvider, // ใช้ AssetImage ถ้าเป็น local file
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
