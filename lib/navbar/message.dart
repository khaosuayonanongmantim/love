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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
                      borderRadius: BorderRadius.circular(20), // ความโค้งมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
                      child: Image.asset('assets/nunew.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
                      borderRadius: BorderRadius.circular(20), // ความโค้งมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
                      child: Image.asset('assets/chang.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
                      borderRadius: BorderRadius.circular(20), // ความโค้งมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
                      child: Image.asset('assets/war.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
                      borderRadius: BorderRadius.circular(20), // ความโค้งมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
                      child: Image.asset('assets/cat.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
                      borderRadius: BorderRadius.circular(20), // ความโค้งมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
                      child: Image.asset('assets/piano.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
                      borderRadius: BorderRadius.circular(20), // ความโค้งมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
                      child: Image.asset('assets/kini.png', fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
                      borderRadius: BorderRadius.circular(20), // ความโค้งมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
                      child: Image.asset('assets/wan.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
                      borderRadius: BorderRadius.circular(20), // ความโค้งมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
                      child: Image.asset('assets/threemandown.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
                      borderRadius: BorderRadius.circular(20), // ความโค้งมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
                      child: Image.asset('assets/cocktail.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // กำหนดระยะห่างระหว่างรูปภาพ
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 10, 9, 9), width: 4), // เส้นขอบ
                      borderRadius: BorderRadius.circular(20), // ความโค้งมน
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // ความโค้งมน (ควรเป็นน้อยกว่า borderRadius ของ Container)
                      child: Image.asset('assets/scrub.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
               children: [
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
            ),
          ),
        ],
      ),
    );
  }
}
