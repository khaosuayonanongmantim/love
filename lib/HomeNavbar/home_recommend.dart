import 'package:flutter/material.dart';

class RecommendedHome extends StatefulWidget {
  const RecommendedHome({Key? key}) : super(key: key);

  @override
  State<RecommendedHome> createState() => _RecommendedHomeState();
}

class _RecommendedHomeState extends State<RecommendedHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "🔥 แนะนำสำหรับคุณ 🔥", // รวมทุกอย่างทั้งคอนเสิร์ต ไนต์คลับและกีฬา
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildVerticalImageWithText(
                'assets/chang.jpg',
                '"Concert 2"',
                'December 5, 2024',
                '15.00 น.-22.00 น.',
                'Impact Arena เมืองทอง',
              ),
              buildVerticalImageWithText(
                'assets/nunew.jpg',
                '"Concert 1"',
                'November 20, 2024',
                '15.00 น.-22.00 น.',
                'สนามราชมังคลา',
              ),
              buildVerticalImageWithText(
                'assets/war.jpg',
                '"Concert 3"',
                'January 15, 2025',
                '15.00 น.-22.00 น.',
                'Indoor stadiam หัวหมาก',
              ),
              buildVerticalImageWithText(
                'assets/cat.jpg',
                '"Concert 4"',
                'February 28, 2025',
                '15.00 น.-22.00 น.',
                'Bitec บางนา',
              ),
              buildVerticalImageWithText(
                'assets/piano.jpg',
                '"Concert 5"',
                'March 10, 2025',
                '15.00 น.-22.00 น.',
                'Thuder Dome เมืองทอง',
              ),
              buildVerticalImageWithText(
                'assets/kini.png',
                '"Concert 6"',
                'April 25, 2025',
                '15.00 น.-22.00 น.',
                'Impact เมืองทอง',
              ),
              buildVerticalImageWithText(
                'assets/wan.jpg',
                '"Concert 7"',
                'May 7, 2025',
                '15.00 น.-22.00 น.',
                'Bitec live, Bitec Bangna',
              ),
              buildVerticalImageWithText(
                'assets/threemandown.jpg',
                '"Concert 8"',
                'June 20, 2025',
                '15.00 น.-22.00 น.',
                'Paragon Ciniplex',
              ),
              buildVerticalImageWithText(
                'assets/cocktail.jpg',
                '"Concert 9"',
                'July 4, 2025',
                '15.00 น.-22.00 น.',
                'เมืองไทยรัชดาลัย',
              ),
              buildVerticalImageWithText(
                'assets/scrub.jpg',
                '"Concert 10"',
                'August 15, 2025',
                '15.00 น.-22.00 น.',
                'เอ็มซีซี ฮอลล์',
              ),
            ],
          ),
        ),

        // อยู่หลังแนะนำสำหรับคุณการแสกงยอดนิยม
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "🏟 การแสดงยอดนิยม",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const Product()),);
                },
                child: Text(
                  "ALL",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        //ส่วนของรูปภาพแยกเป็นส่วนๆ รูปภาพการแสดง
        SizedBox(height: 15),
        Container(
          height: 150, // กำหนดความสูงของ Container ให้พอเหมาะ
          child: GridView.count(
            crossAxisCount: 2, // จำนวนคอลัมน์ที่ต้องการ
            crossAxisSpacing: 4, // ระยะห่างแนวนอนระหว่างช่อง
            mainAxisSpacing: 4, // ระยะห่างแนวตั้งระหว่างช่อง
            childAspectRatio: 1, // สัดส่วนของช่องเป็นรูปสี่เหลี่ยมจัตุรัส
            physics: NeverScrollableScrollPhysics(), // ปิดการเลื่อน
            children: [
              buildImageGridItem('assets/nunew.jpg', 'Concert 1'),
              buildImageGridItem('assets/chang.jpg', 'Concert 2'),
            ],
          ),
        ),

        Container(
          height: 150, // กำหนดความสูงของ Container ให้พอเหมาะ
          child: GridView.count(
            crossAxisCount: 2, // จำนวนคอลัมน์ที่ต้องการ
            crossAxisSpacing: 4, // ระยะห่างแนวนอนระหว่างช่อง
            mainAxisSpacing: 4, // ระยะห่างแนวตั้งระหว่างช่อง
            childAspectRatio: 1, // สัดส่วนของช่องเป็นรูปสี่เหลี่ยมจัตุรัส
            physics: NeverScrollableScrollPhysics(), // ปิดการเลื่อน
            children: [
              buildImageGridItem('assets/cat.jpg', 'cat'),
              buildImageGridItem('assets/piano.jpg', 'piaio'),
            ],
          ),
        ),

        //สถานที่บันเทิง
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "🌃 สถานที่บันเทิงยอดนิยม",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const Product()),);
                },
                child: Text(
                  "ALL",
                  style: TextStyle(
                    color: Color.fromARGB(255, 28, 142, 235),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        //รูปภาพเกี่ยวกับสถานที่บันเทิง
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              buildImageWithText('assets/bar4.jpg', '"bar 1"'),
              buildImageWithText('assets/bar2.jpg', '"bar 2"'),
              buildImageWithText(
                'assets/bar1.jpg',
                '"bar 3"',
              ),
              buildImageWithText(
                'assets/bar3.jpg',
                '"bar 4"',
              ),
              buildImageWithText(
                'assets/party.jpg',
                '"bar 5"',
              ),
              buildImageWithText(
                'assets/bar.jpg',
                '"bar 6"',
              ),
              buildImageWithText(
                'assets/heap.jpg',
                '"bar 7"',
              ),
            ])),

        //กีฬาแห่งชาติ
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "⚽ กีฬาแห่งชาติ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const Product()),);
                },
                child: Text(
                  "ALL",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 219, 38, 38),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
//รูปภาพเกี่ยวกับกีฬาแห่งชาติ
 SizedBox(height: 10),
        Container(
          height: 150, // กำหนดความสูงของ Container ให้พอเหมาะ
          child: GridView.count(
            crossAxisCount: 2, // จำนวนคอลัมน์ที่ต้องการ
            crossAxisSpacing: 4, // ระยะห่างแนวนอนระหว่างช่อง
            mainAxisSpacing: 4, // ระยะห่างแนวตั้งระหว่างช่อง
            childAspectRatio: 1, // สัดส่วนของช่องเป็นรูปสี่เหลี่ยมจัตุรัส
            physics: NeverScrollableScrollPhysics(), // ปิดการเลื่อน
            children: [
              buildsportGridItem('assets/sport.jpg', 'sport 1'),
              buildsportGridItem('assets/sport1.jpg', 'sport 2'),
            ],
          ),
        ),

        Container(
          height: 150, // กำหนดความสูงของ Container ให้พอเหมาะ
          child: GridView.count(
            crossAxisCount: 2, // จำนวนคอลัมน์ที่ต้องการ
            crossAxisSpacing: 4, // ระยะห่างแนวนอนระหว่างช่อง
            mainAxisSpacing: 4, // ระยะห่างแนวตั้งระหว่างช่อง
            childAspectRatio: 1, // สัดส่วนของช่องเป็นรูปสี่เหลี่ยมจัตุรัส
            physics: NeverScrollableScrollPhysics(), // ปิดการเลื่อน
            children: [
              buildsportGridItem('assets/sport2.jpg', 'sport 3'),
              buildsportGridItem('assets/sport3.jpg', 'sport 4'),
            ],
          ),
        ),

      ],
    );
  }

  

//เกี่ยวกับส่วนของการแนะนำสำหรับคุณ
  Widget buildVerticalImageWithText(
    String imagePath,
    String title,
    String date,
    String time,
    String location,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 250,
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
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Color.fromARGB(255, 5, 255, 13),
                    ),
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
                    Icon(
                      Icons.timer_sharp,
                      color: Color.fromARGB(255, 5, 255, 13),
                    ),
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
                    Icon(
                      Icons.location_on_rounded,
                      color: Color.fromARGB(255, 8, 214, 241),
                    ),
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
    );
  }

//เกี่ยวกับส่วนของการแสดงยอดนิยม
  Widget buildImageGridItem(String imagePath, String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0), // ระยะห่างระหว่างรูปภาพ
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20), // ความโค้งมน
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 120, // กำหนดความสูงของภาพ
              width: double.infinity, // ขยายภาพให้เต็มความกว้าง
            ),
          ),
          SizedBox(height: 5), // ระยะห่างระหว่างภาพกับข้อความ
          Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 100, 2, 117),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }


  //เกี่ยวกับส่วนของสถานที่บันเทิง
  Widget buildImageWithText(
    String imagePath,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8), // ระยะห่างระหว่างภาพกับข้อความ
          Text(
            title,
            style: TextStyle(
              color: Color.fromARGB(255, 0, 99, 180),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }


//เกี่ยวกับส่วนของกีฬา
   Widget buildsportGridItem(String imagePath, String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0), // ระยะห่างระหว่างรูปภาพ
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20), // ความโค้งมน
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 120, // กำหนดความสูงของภาพ
              width: double.infinity, // ขยายภาพให้เต็มความกว้าง
            ),
          ),
          SizedBox(height: 5), // ระยะห่างระหว่างภาพกับข้อความ
          Text(
            text,
            style: TextStyle(
              color: const Color.fromARGB(255, 216, 26, 13),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}