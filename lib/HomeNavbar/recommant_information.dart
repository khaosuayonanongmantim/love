import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/recomment_product.dart';
import 'package:project_new/navbar/message.dart';
import 'package:http/http.dart' as http;

class Recommantinformation extends StatefulWidget {
  const 
  Recommantinformation({Key? key}) : super(key: key);

  @override
  State<Recommantinformation> createState() => _RecommantinformationState();
}

class _RecommantinformationState extends State<Recommantinformation> {
  List<dynamic> _eventPoster = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEventposter();
  }

  Future<void> fetchEventposter() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getEventPoster'));
      if (response.statusCode == 200) {
        setState(() {
          _eventPoster = jsonDecode(response.body); // แปลง JSON เป็น List
          _isLoading = false;
        });
      } else {
        print('Failed to load events: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 185, 125, 197),
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 200, 255),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.purple,
                    width: 2.0,
                  ),
                ),
                child: Text(
                  "📖 INFORMATION 📚",
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _isLoading
                  ? CircularProgressIndicator() // แสดง spinner ระหว่างรอข้อมูล
                  : GridView.builder(
                      shrinkWrap: true, // ใช้สำหรับแสดงรายการแบบย่อ
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // กำหนดให้มี 2 กรอบในแถว
                        crossAxisSpacing: 10, // ระยะห่างระหว่างกรอบในแถว
                        mainAxisSpacing: 10, // ระยะห่างระหว่างแถว
                        childAspectRatio: 0.7, // อัตราส่วนความกว้าง/ความสูงของกรอบ
                      ),
                      itemCount: _eventPoster.length, // จำนวนรายการ
                      itemBuilder: (context, index) {
                        var event = _eventPoster[index]; // ข้อมูลแต่ละรายการ
                        String imageUrl = 'http://192.168.55.228/information/${event['image']}';
                        
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color.fromARGB(255, 2, 90, 161),
                              width: 2.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              // แสดงรูปภาพจาก URL
                              Image.network(
                                imageUrl, // แสดงรูปภาพจาก URL
                                height: 112, // ขนาดรูปภาพที่เล็กลง
                                width: double.infinity, // ความกว้างของรูปภาพ
                                fit: BoxFit.cover, // การปรับขนาดรูปภาพ
                              ),
                              SizedBox(height: 10),
                              // ข้อความ Title
                              Text(
                                event['title'], // ใช้ข้อมูลจาก API (เปลี่ยนให้ตรงกับโครงสร้าง API)
                                style: TextStyle(
                                  fontSize: 14, // ขนาดข้อความเล็กลง
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              // ข้อความ Text
                              Text(
                                event['text'], // ข้อความจาก API (เปลี่ยนให้ตรงกับโครงสร้าง API)
                                style: TextStyle(
                                  fontSize: 10, // ขนาดข้อความเล็กลง
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Message(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "GO TO NEXT PAGE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Recommantpromotion(),
      ],
    );
  }
}
