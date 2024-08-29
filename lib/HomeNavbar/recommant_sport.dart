import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/detail_AllSportt.dart';

class HomeConcertAndSport extends StatefulWidget {
  const HomeConcertAndSport({Key? key}) : super(key: key);

  @override
  State<HomeConcertAndSport> createState() => _RecommendedHomeState();
}

class _RecommendedHomeState extends State<HomeConcertAndSport> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "🏟⚽ᴇxᴄᴇʟʟᴇɴᴛ ꜱᴘᴏʀᴛꜱ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailSport()),);
                },
                child: Text(
                  "ᴀʟʟ",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 240, 240), // เพิ่มสีพื้นหลังที่นี่
                  border: Border.all(
                    color: Colors.purple,
                    width: 2.0, // เพิ่มความหนาของเส้นขอบ
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/war.jpg', // แทนที่ด้วยตำแหน่งรูปภาพภายในโปรเจ็กต์ของคุณ
                      height: 150, // ปรับขนาดรูปภาพ
                    ),
                    SizedBox(height: 8),
                    Text(
                      'concert 1',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 167, 1, 153), // ปรับสีของข้อความ
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 240, 240), // เพิ่มสีพื้นหลังที่นี่
                  border: Border.all(
                    color: Colors.purple,
                    width: 2.0, // เพิ่มความหนาของเส้นขอบ
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/threemandown.jpg', // แทนที่ด้วยตำแหน่งรูปภาพภายในโปรเจ็กต์ของคุณ
                      height: 150, // ปรับขนาดรูปภาพ
                    ),
                    SizedBox(height: 8),
                    Text(
                      'concert 2',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 167, 1, 153), // ปรับสีของข้อความ
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 240, 240), // เพิ่มสีพื้นหลังที่นี่
                  border: Border.all(
                    color: Colors.purple,
                    width: 2.0, // เพิ่มความหนาของเส้นขอบ
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/sport.jpg', // แทนที่ด้วยตำแหน่งรูปภาพภายในโปรเจ็กต์ของคุณ
                      height: 150, // ปรับขนาดรูปภาพ
                    ),
                    SizedBox(height: 8),
                    Text(
                      'sport 1',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 167, 1, 153), // ปรับสีของข้อความ
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 240, 240), // เพิ่มสีพื้นหลังที่นี่
                  border: Border.all(
                    color: Colors.purple,
                    width: 2.0, // เพิ่มความหนาของเส้นขอบ
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/sport2.jpg', // แทนที่ด้วยตำแหน่งรูปภาพภายในโปรเจ็กต์ของคุณ
                      height: 150, // ปรับขนาดรูปภาพ
                    ),
                    SizedBox(height: 8),
                    Text(
                      'sport 2',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 167, 1, 153), // ปรับสีของข้อความ
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
         Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 240, 240), // เพิ่มสีพื้นหลังที่นี่
                  border: Border.all(
                    color: Colors.purple,
                    width: 2.0, // เพิ่มความหนาของเส้นขอบ
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/kini.png', // แทนที่ด้วยตำแหน่งรูปภาพภายในโปรเจ็กต์ของคุณ
                      height: 150, // ปรับขนาดรูปภาพ
                    ),
                    SizedBox(height: 8),
                    Text(
                      'concert 3',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 167, 1, 153), // ปรับสีของข้อความ
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 240, 240), // เพิ่มสีพื้นหลังที่นี่
                  border: Border.all(
                    color: Colors.purple,
                    width: 2.0, // เพิ่มความหนาของเส้นขอบ
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/sport1.jpg', // แทนที่ด้วยตำแหน่งรูปภาพภายในโปรเจ็กต์ของคุณ
                      height: 150, // ปรับขนาดรูปภาพ
                    ),
                    SizedBox(height: 8),
                    Text(
                      'sport 3',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 167, 1, 153), // ปรับสีของข้อความ
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
