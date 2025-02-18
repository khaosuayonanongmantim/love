import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_new/HomeNavbar/BuyTicketSport.dart';

class SportDetail extends StatelessWidget {
  final String imagePath;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5; // เพิ่ม price

  const SportDetail({
    Key? key,
    required this.imagePath,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5, // รับค่า price
  }) : super(key: key);

  String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      print("Error formatting date: $e");
      return dateString; // หากเกิดข้อผิดพลาด ให้แสดงวันที่เดิม
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = formatDate(text2);
    return Scaffold(
      appBar: AppBar(
        title: Text(text1),
        backgroundColor: const Color.fromARGB(255, 255, 135, 175),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFE4E1), // 🎨 พื้นหลังสีชมพูอ่อน
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 300, // กำหนดความกว้างให้เท่ากันทุกภาพ
                      height: 300, // กำหนดความสูงให้เท่ากันทุกภาพ
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // เพิ่มมุมโค้งให้ดูดีขึ้น
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10), // ป้องกันภาพล้นขอบ
                        child: Image.network(
                          imagePath,
                          width: double.infinity, // ขยายเต็ม Container
                          height: double.infinity, // ขยายเต็ม Container
                          fit: BoxFit.cover, // ครอบคลุมพื้นที่ทั้งหมด
                          alignment: Alignment.center, // จัดให้อยู่ตรงกลาง
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    text1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'วันที่ : ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 9, 121, 12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Color.fromARGB(255, 41, 121, 9),
                      ),
                      SizedBox(width: 5),
                      Text(
                        ' $formattedDate',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 9, 121, 12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'เวลา : ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Icon(
                          Icons.timer_sharp,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 5),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          text3,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'สถานที่ : ',
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 33, 54, 243),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Icon(
                          Icons.location_on_sharp,
                          color: const Color.fromARGB(255, 33, 54, 243),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 5.0), // ขยับลง 20 พิกเซล
                          child: Text(
                            text4,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 33, 54, 243),
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 160),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ราคาเริ่มต้น:  ฿ $text5 ', // แสดงราคาจาก API
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // เปลี่ยนสีให้เด่น
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SportPlan(
                                  imagePath: imagePath,
                                  sportName: text1,
                                  date: formattedDate,
                                  time: text3,
                                  location: text4,
                                  price: text5, // ส่ง sport หรือเปลี่ยนเป็นค่าอื่น ๆ ตามต้องการ
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 41, 26),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                          ),
                          child: Text(
                            'ซื้อบัตร',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
