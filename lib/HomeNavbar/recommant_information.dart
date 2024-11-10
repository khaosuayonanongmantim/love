import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/recomment_product.dart';
import 'package:project_new/navbar/message.dart';

class Recommantinformation extends StatefulWidget {
  const Recommantinformation({Key? key}) : super(key: key);

  @override
  State<Recommantinformation> createState() => _RecommantinformationState();
}

class _RecommantinformationState extends State<Recommantinformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(8), // ระยะห่างภายในกรอบ
          margin: const EdgeInsets.symmetric(horizontal: 16), // ระยะห่างรอบกรอบ
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 185, 125, 197), // สีพื้นหลัง
            border: Border.all(
              color: Colors.white, // สีกรอบด้านนอก
              width: 2.0, // ความหนาของกรอบด้านนอก
            ),
            borderRadius: BorderRadius.circular(8), // มุมโค้งของกรอบด้านนอก
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // กรอบข้อความ "Upcoming Sports Events"
              Container(
                padding: const EdgeInsets.all(8), // ระยะห่างภายในกรอบข้อความ
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 247, 200, 255), // สีพื้นหลังกรอบข้อความ
                  borderRadius:
                      BorderRadius.circular(8), // มุมโค้งของกรอบข้อความ
                  border: Border.all(
                    color: Colors.purple, // สีกรอบข้อความ
                    width: 2.0, // ความหนาของกรอบข้อความ
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

              // กรอบย่อยในกรอบหลัก
              Container(
                padding: const EdgeInsets.all(10), // ระยะห่างภายในกรอบภายใน
                width: double.infinity, // ทำให้กรอบภายในกว้างสุดเท่าที่จะทำได้
                decoration: BoxDecoration(
                  color: Colors.white, // สีพื้นหลังสำหรับกรอบภายใน
                  borderRadius: BorderRadius.circular(8), // มุมโค้งของกรอบภายใน
                  border: Border.all(
                    color: Color.fromARGB(255, 2, 90, 161), // สีกรอบภายใน
                    width: 2.0, // ความหนาของกรอบภายใน
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // กรอบย่อย 1
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: 150,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 204, 203, 203),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Page 1: Introduction",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ), // เปลี่ยนเป็นสีฟ้า
                              ),
                              SizedBox(
                                  height:
                                      5), // ระยะห่างระหว่างข้อความหลักและข้อความรอง

                              Text(
                                "Welcome to the Virtual Book for Sports Events! ", // ข้อความใต้
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ), // ข้อความสีดำ
                              ),
                            ],
                          ),
                        ),
                        // กรอบย่อย 2
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: 150,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 204, 203, 203),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Page 2: SportsEvent",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Details about the first sports event experience.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // ระยะห่างระหว่างแถว
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // กรอบย่อย 3
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: 150,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 204, 203, 203),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Page 3: SportsEvent",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Learn about the second exciting sports event.",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // กรอบย่อย 4
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: 150,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 204, 203, 203),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Page 4: Introduction",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Get ready for the third major sports event.to miss!",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10), // ระยะห่างระหว่างแถว
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Message(), // เปลี่ยน NextPage เป็นชื่อหน้าที่ต้องการจะนำทางไป
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
            ],
          ),
        ),
        Recommantpromotion(),
     ],
    );
  }
}
