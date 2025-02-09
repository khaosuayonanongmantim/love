import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/recommant_information.dart';
import 'package:http/http.dart' as http;

class RecommendedHome extends StatefulWidget {
  const RecommendedHome({Key? key}) : super(key: key);

  @override
  State<RecommendedHome> createState() => _RecommendedHomeState();
}

class _RecommendedHomeState extends State<RecommendedHome> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
 List<dynamic> _concerts = [];
 List<dynamic> _sports = [];
  bool _isLoading = true;

   @override
  void initState() {
    super.initState();
    fetchConcerts();
    fetchSports();
  }

  Future<void> fetchConcerts() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.144.137:5000/getAllConcerts'));
      if (response.statusCode == 200) {
        setState(() {
          _concerts = jsonDecode(response.body);
          _isLoading = false;
        });

      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

   Future<void> fetchSports() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.144.137:5000/getAllSportsFootball'));
      if (response.statusCode == 200) {
        setState(() {
          _sports = jsonDecode(response.body);
          _isLoading = false;
        });

      } else {
        print('Failed to load concerts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching concerts: $e');
    }
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

    void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ส่วนของการแนะนำสำหรับคุณ
        SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(5), // ระยะห่างภายในกรอบ
          margin: const EdgeInsets.symmetric(horizontal: 16), // ระยะห่างรอบกรอบ
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 126, 198, 207), // สีพื้นหลัง (ปรับตามต้องการ)
            border: Border.all(
              color: Colors.white, // สีของกรอบ
              width: 2.0, // ความหนาของกรอบ

            ),
            borderRadius: BorderRadius.circular(8), // มุมโค้งของกรอบ
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // จัดแนวข้อความทางด้านซ้าย
            children: [
              // กรอบข้อความ "Upcoming Concerts"
              Container(
                padding: const EdgeInsets.all(8), // ระยะห่างภายในกรอบข้อความ
                decoration: BoxDecoration(
                  
                  color: const Color.fromARGB(
                      255, 219, 235, 248), // สีพื้นหลังกรอบข้อความ
                  borderRadius:
                      BorderRadius.circular(8), // มุมโค้งของกรอบข้อความ
                  border: Border.all(
                    color: Colors.blue, // สีของกรอบ
                    width: 2.0, // ความหนาของกรอบ
                  ),
                ),
                child: Text(
                  "🎤 Upcoming Concerts 🎶",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8), // เพิ่มระยะห่างระหว่างข้อความและ ScrollView
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                  child: Row(
                        children: _concerts.map((concert) {
                          return buildVerticalImageWithText(
                            concert['image'] ?? 'assets/default.jpg',
                            concert['name'] ?? 'Unknown Title',
                            concert['date'] ?? 'Unknown Date',
                            concert['time'] ?? 'Unknown Time',
                            concert['location'] ?? 'Unknown Location',
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
        // การแสดงยอดนิยม
        SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(5), // ระยะห่างภายในกรอบ
          margin: const EdgeInsets.symmetric(horizontal: 16), // ระยะห่างรอบกรอบ
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 233, 106, 148), // สีพื้นหลัง (ปรับตามต้องการ)
            border: Border.all(
              color: Colors.white, // สีของกรอบ
              width: 2.0, // ความหนาของกรอบ
            ),
            borderRadius: BorderRadius.circular(8), // มุมโค้งของกรอบ
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // จัดแนวข้อความทางด้านซ้าย
            children: [
              // กรอบข้อความ "Upcoming Sports Events"
              Container(
                padding: const EdgeInsets.all(8), // ระยะห่างภายในกรอบข้อความ
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 250, 219, 229), // สีพื้นหลังกรอบข้อความ
                  borderRadius:
                      BorderRadius.circular(8), // มุมโค้งของกรอบข้อความ
                  border: Border.all(
                    color: Colors.pink, // สีของกรอบ
                    width: 2.0, // ความหนาของกรอบ
                  ),
                ),
                child: Text(
                  "🏆 Upcoming Sports Events ⚽",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                  height: 8), // เพิ่มระยะห่างระหว่างกรอบข้อความและ ScrollView
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildImageWithText('assets/sport6.jpg'),
                    buildImageWithText('assets/sport2.jpg'),
                    buildImageWithText('assets/sport3.jpg'),
                    buildImageWithText('assets/sport1.jpg'),
                  ],
                ),
              ),
                 // รูปภาพยาวแนวนอนใต้ส่วนของ Sports Events
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
          height: 170, // ความสูงของรูปภาพ
          margin: const EdgeInsets.symmetric(horizontal: 16), // ระยะห่างรอบกรอบ
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  buildImageContainer('assets/sport5.jpg'),
                  buildImageContainer('assets/sport6.jpg'),
                  buildImageContainer('assets/sport2.jpg'),
                ],
              ),
              Positioned(
                left: -10,
                top: 70, // ปรับตำแหน่งตามต้องการ
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 255, 0, 191)),
                  onPressed: _previousPage,
                  
                ),
              ),
              Positioned(
                right: -15,
                top: 70, // ปรับตำแหน่งตามต้องการ
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 255, 0, 191)),
                  onPressed: _nextPage,
                ),
              ),
            ],
          ),
        ),
      ],
                
              ),
            
            ],
          ),
        ),
        // การกีฬายอดเยี่ยม
        Recommantinformation(),
      ],
    );
  }

 Widget buildVerticalImageWithText(
  String imagePath,
  String title,
  String date,
  String time,
  String location,
) {
  // สร้าง URL ของภาพที่ถูกต้อง
  String imageUrl = 'http://192.168.144.137/concert/all/$imagePath';

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 250,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                // ใช้ URL ของภาพที่ถูกสร้าง
                image: imageUrl.startsWith('http')
                    ? NetworkImage(imageUrl) // ถ้าเป็น URL ให้ใช้ NetworkImage
                    : AssetImage(imageUrl) as ImageProvider, // ถ้าไม่ใช่ URL ให้ใช้ AssetImage
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 241, 239, 239),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined,
                        color: Color.fromARGB(255, 5, 255, 13)),
                    SizedBox(width: 8),
                    Text(
                      date,
                      style: TextStyle(
                        color: Color.fromARGB(255, 5, 255, 13),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.timer_sharp,
                        color: Color.fromARGB(255, 5, 255, 13)),
                    SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(
                        color: Color.fromARGB(255, 5, 255, 13),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded,
                        color: Color.fromARGB(255, 8, 214, 241)),
                    SizedBox(width: 8),
                    Text(
                      location,
                      style: TextStyle(
                        color: Color.fromARGB(255, 8, 214, 241),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  // เกี่ยวกับส่วนของสถานที่บันเทิง
  Widget buildImageWithText(
    String imagePath,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 170,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

    Widget buildImageContainer(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
