import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_new/navbar/discount.dart';
import 'package:project_new/navbar/product.dart';
import 'package:http/http.dart' as http;

class Recommantpromotion extends StatefulWidget {
  const Recommantpromotion({Key? key}) : super(key: key);

  State<Recommantpromotion> createState() => _RecommantpromotionState();
}

class _RecommantpromotionState extends State<Recommantpromotion> {
  List<dynamic> _lightstickcon = [];
  List<dynamic> _promotion = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLightstick();
    fetchPromotionImages();
  }

  Future<void> fetchLightstick() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getAllligthstickcon'));
      if (response.statusCode == 200) {
        setState(() {
          _lightstickcon = jsonDecode(response.body); // แปลง JSON เป็น List
          _isLoading = false;
        });
      } else {
        print('Failed to load events: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future<void> fetchPromotionImages() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/getpromotionImage'));
      if (response.statusCode == 200) {
        setState(() {
          _promotion = jsonDecode(response.body); // แปลง JSON เป็น List
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
            color: Color.fromARGB(255, 149, 164, 216),
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
                  color: const Color.fromARGB(255, 247, 200, 255),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromARGB(255, 126, 39, 176),
                    width: 2.0,
                  ),
                ),
                child: Text(
                  "👜 Our Exclusive Products🧸",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 145, 64, 251),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator() // แสดง spinner ระหว่างรอข้อมูล
                  : GridView.builder(
                      shrinkWrap: true, // ใช้สำหรับแสดงรายการแบบย่อ
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // กำหนดให้มี 2 กรอบในแถว
                        crossAxisSpacing: 10, // ระยะห่างระหว่างกรอบในแถว
                        mainAxisSpacing: 10, // ระยะห่างระหว่างแถว
                        childAspectRatio:
                            0.65, // อัตราส่วนความกว้าง/ความสูงของกรอบ
                      ),
                      itemCount: _lightstickcon.length, // จำนวนรายการ
                      itemBuilder: (context, index) {
                        var event = _lightstickcon[index]; // ข้อมูลแต่ละรายการ
                        String imageUrl =
                            'http://192.168.55.228/product/lightstick/${event['image']}';

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
                                height: 110, // ขนาดรูปภาพที่เล็กลง
                                width: double.infinity, // ความกว้างของรูปภาพ
                                fit: BoxFit.cover, // การปรับขนาดรูปภาพ
                              ),
                              SizedBox(height: 10),
                              // ข้อความ Title
                              Text(
                                event[
                                    'name'], // ใช้ข้อมูลจาก API (เปลี่ยนให้ตรงกับโครงสร้าง API)
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              // ข้อความ Text
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // จัดข้อความให้ชิดซ้าย
                                children: [
                                  Text(
                                    'ราคา ${event['price']} ฿', // การใช้ `${}` เพื่อแทรกราคาในข้อความ
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(
                                      255, 247, 186, 150), // สีพื้นหลังปุ่ม
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // มุมโค้งของปุ่ม
                                  ),
                                  minimumSize: Size(190,
                                      30), // กำหนดขนาดของปุ่ม (ความกว้าง, ความสูง)
                                ),
                                onPressed: () {
                                  // ฟังก์ชันที่จะทำเมื่อกดปุ่ม
                                },
                                child: Text(
                                  "BUY NOW",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12, // ขนาดฟอนต์
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Product(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  width: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 240, 171, 186), // ชมพูอ่อน
                        Color.fromARGB(255, 241, 207, 155), // ส้มอ่อน
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
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

        //page promotion
        SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 177, 228, 221),
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
                margin:
                    const EdgeInsets.only(bottom: 10), // ระยะห่างระหว่างกรอบ
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 200, 255, 227),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color.fromARGB(255, 23, 139, 72),
                    width: 2.0,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "✨Exclusive Promotion🌟",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _isLoading
                  ? CircularProgressIndicator() // แสดง spinner ระหว่างรอข้อมูล
                  : GridView.builder(
                      shrinkWrap: true, // ใช้สำหรับแสดงรายการแบบย่อ
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, // กำหนดให้มี 2 กรอบในแถว
                        crossAxisSpacing: 10, // ระยะห่างระหว่างกรอบในแถว
                        mainAxisSpacing: 10, // ระยะห่างระหว่างแถว
                        childAspectRatio:
                            2, // อัตราส่วนความกว้าง/ความสูงของกรอบ
                      ),
                      itemCount: _promotion.length, // จำนวนรายการ
                      itemBuilder: (context, index) {
                        var promotion = _promotion[index]; // ข้อมูลแต่ละรายการ
                        String imageUrl =
                            'http://192.168.55.228/promotion/${promotion['image']}';

                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color.fromARGB(255, 2, 150, 161),
                              width: 2.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              
                              // ข้อความ Title
                              // Text(
                              //   promotion[
                              //       'name'], // ใช้ข้อมูลจาก API (เปลี่ยนให้ตรงกับโครงสร้าง API)
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              // แสดงรูปภาพจาก URL
                              SizedBox(height: 10),
                              Image.network(
                                imageUrl, // แสดงรูปภาพจาก URL
                                height: 110, // ขนาดรูปภาพที่เล็กลง
                                width: double.infinity, // ความกว้างของรูปภาพ
                                fit: BoxFit.cover, // การปรับขนาดรูปภาพ
                              ),
                            ],
                          ),
                        );
                      },
                    ),

              SizedBox(height: 20),

              // ปุ่มสำหรับการนำทาง
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Discount(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  width: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 148, 86), // ชมพูอ่อน
                        Color.fromARGB(255, 255, 210, 85), // ส้มอ่อน
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
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
      ],
    );
  }
}
