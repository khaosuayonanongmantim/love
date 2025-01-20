import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/recommant_information.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';



class RecommendedHome extends StatefulWidget {
  const RecommendedHome({Key? key}) : super(key: key);

  @override
  State<RecommendedHome> createState() => _RecommendedHomeState();
}

class _RecommendedHomeState extends State<RecommendedHome> {
  List<dynamic> _concerts = [];
  List<dynamic> _sports = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchConcerts();
    fetchSports();
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


  Future<void> fetchConcerts() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllConcertsthaiMass'));
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
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllSportsFootball'));
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
            color: Color.fromARGB(
                255, 126, 198, 207), // สีพื้นหลัง (ปรับตามต้องการ)
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
                      concert['price'] ?? 'Unknown Price',
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
            color: Color.fromARGB(
                255, 233, 106, 148), // สีพื้นหลัง (ปรับตามต้องการ)
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
                  children: _sports.map((concert) {
                    return buildImageWithText(
                      concert['image'] ?? 'assets/default.jpg',
                      concert['name'] ?? 'Unknown Title',
                      concert['date'] ?? 'Unknown Date',
                      concert['price'] ?? 'Unknown Price',
                      concert['location'] ?? 'Unknown Location',
                    );
                  }).toList(),
                ),
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
  String price,
  String location,
) {
  // แปลงวันที่ให้แสดงในรูปแบบ dd/MM/yyyy
  String formattedDate = formatDate(date);

  String imageUrl = 'http://192.168.55.228/concert/all/$imagePath';

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
                image: imageUrl.startsWith('http')
                    ? NetworkImage(imageUrl) // ถ้าเป็น URL ใช้ NetworkImage
                    : AssetImage(imageUrl) as ImageProvider, // ถ้าไม่ใช่ URL ใช้ AssetImage
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
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      ' $formattedDate', // ใช้วันที่ที่แปลงแล้ว
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      ' $price THB',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_sharp,
                        color: Colors.red),
                    Text(
                      location,
                      style: TextStyle(
                        color: Colors.red,
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

Widget buildImageWithText(
  String imagePath,
  String title,
  String date,
  String price,
  String location,
) {
  // แปลงวันที่ให้แสดงในรูปแบบ dd/MM/yyyy
  String formattedDate = formatDate(date);

  String imageUrl = 'http://192.168.55.228/sport/all/$imagePath';

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
                image: imageUrl.startsWith('http')
                    ? NetworkImage(imageUrl) // ถ้าเป็น URL ใช้ NetworkImage
                    : AssetImage(imageUrl) as ImageProvider, // ถ้าไม่ใช่ URL ใช้ AssetImage
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
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      ' $formattedDate', // ใช้วันที่ที่แปลงแล้ว
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      ' $price THB',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                     Icon(Icons.location_on_sharp,
                        color: Colors.red),
                    Text(
                      location,
                      style: TextStyle(
                        color: Colors.red,
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
