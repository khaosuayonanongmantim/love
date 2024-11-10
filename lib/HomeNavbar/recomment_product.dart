import 'package:flutter/material.dart';
import 'package:project_new/navbar/discount.dart';
import 'package:project_new/navbar/message.dart';
import 'package:project_new/navbar/product.dart';

class Recommantpromotion extends StatefulWidget {
  const Recommantpromotion({Key? key}) : super(key: key);

  State<Recommantpromotion> createState() => _RecommantpromotionState();
}

class _RecommantpromotionState extends State<Recommantpromotion> {
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
              SizedBox(height: 20),

              // แถวแรกของกรอบ 2 กรอบ
              Row(
                children: [
                  Expanded(
                    child: buildProductCard('assets/baby.jpg', "Product 1",
                        "This is a description of product 1."),
                  ),
                  SizedBox(width: 8), // เพิ่มระยะห่างระหว่างกรอบ
                  Expanded(
                    child: buildProductCard('assets/baby2.jpg', "Product 2",
                        "This is a description of product 2."),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // แถวที่สองของกรอบ 2 กรอบ
              Row(
                children: [
                  Expanded(
                    child: buildProductCard('assets/baby3.jpg', "Product 3",
                        "This is a description of product 3."),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: buildProductCard('assets/baby7.jpg', "Product 4",
                        "This is a description of product 4."),
                  ),
                ],
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

              // Container 1 with Image
              Container(
                padding: const EdgeInsets.all(8),
                margin:
                    const EdgeInsets.only(bottom: 10), // ระยะห่างระหว่างกรอบ
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 228, 245),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      "Special Offer",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      'assets/pop1.jpg',
                      width: 400, // ขยายความกว้าง
                      height: 150, // ขยายความสูง
                      fit: BoxFit.cover, // ปรับขนาดภาพให้เต็มกรอบ
                    ),
                  ],
                ),
              ),

              // Container 2 with Image
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 200, 249, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      "50% Off!",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      'assets/pop2.jpg',
                      width: 400, // ขยายความกว้าง
                      height: 150, // ขยายความสูง
                      fit: BoxFit.cover, // ปรับขนาดภาพให้เต็มกรอบ
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Container 3 with Image
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 222, 200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      "Buy 1 Get 1!",
                      style: TextStyle(
                        color: Colors.red,
                        
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      'assets/pop3.jpg',
                      width: 400, // ขยายความกว้าง
                      height: 150, // ขยายความสูง
                      fit: BoxFit.cover, // ปรับขนาดภาพให้เต็มกรอบ
                      
                      
                    ),
                  ],
                ),
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
         SizedBox(height: 20),
      ],
    );
  }

  // ฟังก์ชันเพื่อสร้างกรอบผลิตภัณฑ์
  Widget buildProductCard(String imagePath, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              // เพิ่มโค้ดฟังก์ชันการทำงานของปุ่ม Buy Now ที่นี่
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 247, 186, 150), // สีพื้นหลังปุ่ม
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "BUY NOW",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
