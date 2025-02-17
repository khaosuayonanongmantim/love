import 'dart:convert';
import 'dart:async'; // Import dart:async for Timer
import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/concert_enjoy.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'concert_detail.dart'; // Import the ConcertDetail widget
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeConcert extends StatefulWidget {
  const HomeConcert({super.key});

  @override
  State<HomeConcert> createState() => _HomeConcertState();
}

class _HomeConcertState extends State<HomeConcert> {
  final PageController _controller = PageController();
  Timer? _timer;
  int selectedIndex = 0; // Store the selected index
  String selectedCategory = 'ทั้งหมด'; // Track the selected category
  List<dynamic> _concertImage = [];
  List<dynamic> _concertsEnjoy = [];
  List<dynamic> _concerts = [];
  List<dynamic> _concertsThaimass = [];
  List<dynamic> _concertsTpop = [];
  List<dynamic> _concertsKpop = [];
  List<dynamic> _concertsInter = [];
  bool _isLoading = true;

  // Define the items for each category

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    fetchImages();
    fetchConcertsEnjoy();
    fetchConcerts();
    fetchConcertsThaimass();
    fetchConcertsTpop();
    fetchConcertsKpop();
    fetchConcertsInter();
    _controller.addListener(_onPageChanged);
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

  Future<void> fetchImages() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.55.228:5000/concertsImage'));
      if (response.statusCode == 200) {
        setState(() {
          _concertImage = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

  Future<void> fetchConcertsEnjoy() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/concertsDetail'));
      if (response.statusCode == 200) {
        setState(() {
          _concertsEnjoy = jsonDecode(response.body);
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
    'THAI MASS': [],
    'T-POP': [],
    'K-POP': [],
    'INTERNATIONAL': [],
  };

  Future<void> fetchConcerts() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllConcerts'));
      if (response.statusCode == 200) {
        List<dynamic> concerts = jsonDecode(response.body);

        // แปลงข้อมูลจาก API ให้อยู่ในรูปแบบ categoryItems
        Map<String, List<Map<String, String>>> updatedCategories = {
          'ทั้งหมด': [],
          'THAI MASS': [],
          'T-POP': [],
          'K-POP': [],
          'INTERNATIONAL': [],
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
          _concerts = concerts;
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

  Future<void> fetchConcertsThaimass() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllConcertsthaiMass'));
      if (response.statusCode == 200) {
        List<dynamic> concerts = jsonDecode(response.body);

        // แปลงข้อมูลจาก API ให้อยู่ในรูปแบบ categoryItems
        Map<String, List<Map<String, String>>> updatedCategories = {
          'ทั้งหมด': [],
          'THAI MASS': [],
          'T-POP': [],
          'K-POP': [],
          'INTERNATIONAL': [],
        };

        for (var concert in concerts) {
          String category = concert['category'] ?? 'THAI MASS';
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
          _concertsThaimass = concerts;
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

  Future<void> fetchConcertsTpop() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllConcertstpop'));
      if (response.statusCode == 200) {
        List<dynamic> concerts = jsonDecode(response.body);

        // แปลงข้อมูลจาก API ให้อยู่ในรูปแบบ categoryItems
        Map<String, List<Map<String, String>>> updatedCategories = {
          'ทั้งหมด': [],
          'THAI MASS': [],
          'T-POP': [],
          'K-POP': [],
          'INTERNATIONAL': [],
        };

        for (var concert in concerts) {
          String category = concert['category'] ?? 'T-POP';
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
          categoryItems.forEach((key, value) {
            if (updatedCategories.containsKey(key)) {
              categoryItems[key]!.addAll(updatedCategories[key]!);
            }
          });
          _concertsTpop = concerts;
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

  Future<void> fetchConcertsKpop() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllConcertskpop'));
      if (response.statusCode == 200) {
        List<dynamic> concerts = jsonDecode(response.body);

        // แปลงข้อมูลจาก API ให้อยู่ในรูปแบบ categoryItems
        Map<String, List<Map<String, String>>> updatedCategories = {
          'ทั้งหมด': [],
          'THAI MASS': [],
          'T-POP': [],
          'K-POP': [],
          'INTERNATIONAL': [],
        };

        for (var concert in concerts) {
          String category = concert['category'] ?? 'K-POP';
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
          categoryItems.forEach((key, value) {
            if (updatedCategories.containsKey(key)) {
              categoryItems[key]!.addAll(updatedCategories[key]!);
            }
          });
          _concertsKpop = concerts;
          _isLoading = false;
        });
      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

  Future<void> fetchConcertsInter() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllConcertsinter'));
      if (response.statusCode == 200) {
        List<dynamic> concerts = jsonDecode(response.body);

        // แปลงข้อมูลจาก API ให้อยู่ในรูปแบบ categoryItems
        Map<String, List<Map<String, String>>> updatedCategories = {
          'ทั้งหมด': [],
          'THAI MASS': [],
          'T-POP': [],
          'K-POP': [],
          'INTERNATIONAL': [],
        };

        for (var concert in concerts) {
          String category = concert['category'] ?? 'INTERNATIONAL';
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
          categoryItems.forEach((key, value) {
            if (updatedCategories.containsKey(key)) {
              categoryItems[key]!.addAll(updatedCategories[key]!);
            }
          });
          _concertsInter = concerts;
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
    if (page == 3) {
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
                  Color.fromARGB(255, 238, 163, 192),
                  Color(0xFFEF629F),
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
                      color: Color.fromARGB(255, 252, 186, 232),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          height: 220,
                          child: PageView(
                            controller: _controller,
                            children: _concertImage.map((concertimg) {
                              return buildCarouselItem(
                                concertimg['image'] ?? 'assets/default.jpg',
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SmoothPageIndicator(
                          controller: _controller,
                          count: 4,
                          effect: WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 16,
                            activeDotColor:
                                const Color.fromARGB(255, 243, 33, 191),
                            dotColor: Colors.white,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              SizedBox(height: 70),
                              Text(
                                'ᴇɴᴊᴏʏ ᴛʜɪꜱ ᴀᴍᴀᴢɪɴɢ ᴄᴏɴᴄᴇʀᴛ',
                                style: TextStyle(
                                  fontSize: 22,
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
                            children: _concertsEnjoy.map((concert) {
                              return buildImageWithText(
                                concert['image'] ?? 'assets/default.jpg',
                                concert['name'] ?? 'Concert Name',
                                context, // ส่ง context ไปให้ function
                                concert, // ส่งข้อมูล concert ไปด้วย
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              SizedBox(height: 50),
                              Text(
                                'ᴍᴏᴍᴇɴᴛ ᴄᴏɴᴄᴇʀᴛ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // แถวแรก - รูปใหญ่ 1 รูป
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Image.asset(
                            'assets/gif5.gif', // เปลี่ยนเป็นชื่อไฟล์รูปใหญ่
                            width: double.infinity, // ให้เต็มความกว้าง
                            height: 200, // ความสูงของรูป
                            fit: BoxFit.cover, // ปรับขนาดรูป
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.asset(
                                  'assets/gif.gif', // รูปที่ 1
                                  height: 100, // ความสูงของรูป
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.asset(
                                  'assets/gif1.gif', // รูปที่ 2
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // แถวที่ 3 - รูป 2 รูป
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.asset(
                                  'assets/gif2.gif', // รูปที่ 3
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.asset(
                                  'assets/gif6.gif', // รูปที่ 4
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30),
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildCircleAvatar('ทั้งหมด', 0),
                                buildCircleAvatar('THAI MASS', 1),
                                buildCircleAvatar('T-POP', 2),
                                buildCircleAvatar('K-POP', 3),
                                buildCircleAvatar('INTERNATIONAL', 4),
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

  Widget buildImageWithText(String imagePath, String text, BuildContext context,
      Map<String, dynamic> concert) {
    String imageUrl = 'http://192.168.55.228/concert/$imagePath';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ConcertDetailPage(concert: concert), // ไปที่หน้ารายละเอียด
            ),
          );
        },
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: 150,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: imageUrl.startsWith('http')
                          ? NetworkImage(
                              imageUrl) // ใช้ NetworkImage ถ้าเป็น URL
                          : AssetImage(imageUrl)
                              as ImageProvider, // ใช้ AssetImage ถ้าเป็น local file
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8), // เว้นระยะระหว่างรูปภาพและข้อความ
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCarouselItem(String imagePath) {
    String imageUrl = 'http://192.168.55.228/concert/$imagePath';

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageUrl.startsWith('http')
              ? NetworkImage(imageUrl) // ถ้าเป็น URL ใช้ NetworkImage
              : AssetImage(imageUrl)
                  as ImageProvider, // ถ้าไม่ใช่ URL ใช้ AssetImage
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
    // กำหนด URL ของรูปภาพ
    // แปลงวันที่ให้แสดงในรูปแบบ dd/MM/yyyy
    String formattedDate = formatDate(item['text2']!);

   String imageUrl = 'http://192.168.55.228/concert/all/' + item['imagePath']!;


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
                          builder: (context) => ConcertDetail(
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

}

