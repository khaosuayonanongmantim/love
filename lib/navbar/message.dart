import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 128, 195, 236),
      body: Column(
        children: [
          const SizedBox(height: 30), // เพิ่มระยะห่างระหว่างข้อความ
          Container( // รูปสำหรับต่อหลังบ้าน (รอ...)
            height: 200, // กำหนดความสูงของพื้นที่รูปภาพ
            child: PageView(
              controller: _controller, // รูปภาพเลื่อนได้
              children: [
                buildImageContainer('assets/nunew.jpg'),
                buildImageContainer('assets/chang.jpg'),
                buildImageContainer('assets/war.jpg'),
                buildImageContainer('assets/cat.jpg'),
                buildImageContainer('assets/piano.jpg'),
                buildImageContainer('assets/kini.png'),
                buildImageContainer('assets/wan.jpg'),
                buildImageContainer('assets/threemandown.jpg'),
                buildImageContainer('assets/cocktail.jpg'),
                buildImageContainer('assets/scrub.jpg'),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "🔥 แนะนำสำหรับคุณ 🔥",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildImageContainer(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
          borderRadius: BorderRadius.circular(20), // ความโค้งมน
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
