import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/home_recommend.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _controller = PageController();//ประกาศตัวที่จุดเลื่อน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: SingleChildScrollView( //เลื่อนลงมาข้างล่างได้
        padding: EdgeInsets.only(top: 30), // เพิ่ม padding ด้านบน
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "THE CONCERT",
                style: TextStyle(
                  color: Colors.purpleAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.bold, // เพิ่ม fontWeight เพื่อทำให้ข้อความเป็นตัวหนา
                ),
              ),
              SizedBox(height: 10), // เพิ่มระยะห่างระหว่างข้อความ
              Text(
                "MUSIC FESTIVAL",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30), // เพิ่มระยะห่างระหว่างข้อความ
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30), // กำหนดให้มีความโค้ง
                      border: Border.all(
                        color: Colors.greenAccent, // กำหนดสีของกรอบนอก
                        width: 3, // กำหนดความกว้างของกรอบนอก
                      ),
                    ),
                    child: Text(
                      "Concert",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // เพิ่มระยะห่างระหว่างกรอบ
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.purpleAccent, // กำหนดสีของกรอบนอก
                        width: 3, // กำหนดความกว้างของกรอบนอก
                      ), // กำหนดให้มีความโค้ง
                    ),
                    child: Text(
                      "Sport",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // เพิ่มระยะห่างระหว่างกรอบ
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.blueAccent, // กำหนดสีของกรอบนอก
                        width: 3, // กำหนดความกว้างของกรอบนอก
                      ), // กำหนดให้มีความโค้ง
                    ),
                    child: Text(
                      "Nightclub",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30), // เพิ่มระยะห่างระหว่างข้อความ
              Container(//รูปสำหรับต่อหลังบ้าน (รอ...)
                height: 200, // กำหนดความสูงของพื้นที่รูปภาพ
                child: PageView(
                  controller: _controller, // รูปภาพเลื่อนได้
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // ความโค้งมน
                        child: Image.asset('assets/nunew.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // ความโค้งมน
                        child: Image.asset('assets/chang.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // ความโค้งมน
                        child: Image.asset('assets/war.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // ความโค้งมน
                        child: Image.asset('assets/cat.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // ความโค้งมน
                        child: Image.asset('assets/piano.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // ความโค้งมน
                        child: Image.asset('assets/kini.png', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // ความโค้งมน
                        child: Image.asset('assets/wan.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // ความโค้งมน
                        child: Image.asset('assets/threemandown.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // ความโค้งมน
                        child: Image.asset('assets/cocktail.jpg', fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20), // ความโค้งมน
                        child: Image.asset('assets/scrub.jpg', fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10), // เพิ่มระยะห่างระหว่างรูปภาพและจุด
              SmoothPageIndicator(
                controller: _controller,
                count: 10,
                effect: WormEffect(
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  activeDotColor: Colors.purpleAccent,
                  dotColor: Colors.white,
                ),
                onDotClicked: (index) {
                  _controller.animateToPage( //เรียกใช้ภายใน onDotClicked
                    index,
                    duration: Duration(milliseconds: 500), // (0.5 วินาที).
                    curve: Curves.easeInOut,
                  );
                },
              ),
              //การลิงค์ของแต่ละหน้า โดยไม่ต้องเขียนโค้ดในไฟล์เดียว
              RecommendedHome(),
            ],
          ),
        ),
      ),
    );
  }
}
