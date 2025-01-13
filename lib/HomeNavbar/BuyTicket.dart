import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/ZoneDetailPage.dart';

class ConcertPlan extends StatefulWidget {
  const ConcertPlan({super.key});

  @override
  State<ConcertPlan> createState() => _ConcertPlanState();
}

class _ConcertPlanState extends State<ConcertPlan> {
  late Timer _timer;
  int _remainingTime = 300; // ตั้งค่าเวลานับถอยหลัง (300 วินาที = 5 นาที)
  String selectedPrice = "฿2,500"; // ราคาเริ่มต้นที่เลือก
  String selectedZone = "STD"; // โซนที่เลือก
  List<String> seatZones = ['STD']; // รายการโซนที่แสดงผล
  List<String> seatPrices = [];

@override
void initState() {
  super.initState();
  // เพิ่มโซนทั้งหมดและราคาที่ตรงกัน


  

  
  seatZones = [
    'STD', // โซนราคา 2,500
    'BB1', 'BB2', 'BB3', 'BB4', 'BB5', 'BB6', // โซนราคา 3,500
    'AA4', 'AA5', 'AA6', // โซนราคา 4,500
    'AA1', 'AA2', 'AA3'  // โซนราคา 5,500
  ];
  seatPrices = [
    '฿2,500', // ราคาโซน STD
    '฿3,500', '฿3,500', '฿3,500', '฿3,500', '฿3,500', '฿3,500', // ราคาโซน BB
    '฿4,500', '฿4,500', '฿4,500', // ราคาโซน AA4-AA6
    '฿5,500', '฿5,500', '฿5,500'  // ราคาโซน AA1-AA3
  ];
  startTimer(); // เริ่มต้น Timer
}

  @override
  void dispose() {
    _timer.cancel(); // ยกเลิก Timer เมื่อ Widget ถูกทำลาย
    super.dispose();
  }


  // เพิ่มตัวแปรสีตามโซน
  Map<String, Color> zoneColors = {
    'STD': Colors.blue, // โซนราคา 2,500
    'BB1': Colors.lightBlue, // โซนราคา 3,500
    'BB2': Colors.lightBlue,
    'BB3': Colors.lightBlue,
    'BB4': Colors.lightBlue,
    'BB5': Colors.lightBlue,
    'BB6': Colors.lightBlue,
    'AA4': Colors.yellow, // โซนราคา 4,500
    'AA5': Colors.yellow,
    'AA6': Colors.yellow,
    'AA1': Colors.pinkAccent, // โซนราคา 5,500
    'AA2': Colors.pinkAccent,
    'AA3': Colors.pinkAccent,
  };


  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('หมดเวลาทำรายการ'),
            content: const Text('กรุณาเริ่มการจองใหม่'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('ตกลง'),
              ),
            ],
          ),
        );
      }
    });
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void updatePrice(String price) {
    setState(() {
      selectedPrice = price;

      // อัปเดตรายการโซนตามราคา
      if (price == "฿3,500") {
        seatZones = ['BB1', 'BB2', 'BB3', 'BB4', 'BB5', 'BB6'];
      } else if (price == "฿5,500") {
        seatZones = ['AA1', 'AA2', 'AA3'];
      } else if (price == "฿4,500") {
        seatZones = ['AA4', 'AA5', 'AA6'];
      } else if (price == "฿2,500") {
        seatZones = ['STD'];
      }
    });
  }

  void _bookSeat(String zone) {
  debugPrint("เลือกโซน: $zone ราคา: $selectedPrice");

  // เมื่อเลือกโซน จะนำทางไปยังหน้ารายละเอียดของโซนที่เลือก
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ZoneDetailPage(
        zoneName: zone,
        selectedPrice: selectedPrice,
      ),
    ),
  );
}


  Widget buildPriceButton(String price, Color color) {
    return GestureDetector(
      onTap: () {
        updatePrice(price);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: selectedPrice == price ? color : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Text(
          price,
          style: TextStyle(
            color: selectedPrice == price ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

Widget buildSeatContainers() {
  return Column(
    children: List.generate(seatZones.length, (index) {
      final zone = seatZones[index];
      final price = seatPrices[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          width: 360,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: zoneColors[zone],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // แสดงชื่อโซนและราคา
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    zone,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // ปุ่มจองโซน
              ElevatedButton(
                onPressed: () {
                  _bookSeat(zone);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "จองโซนที่นั่ง",
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 14, 15),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }),
  );
}

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('แผนผังโซนที่นั่ง'),
    ),
    body: Container(
      width: double.infinity,
      height: double.infinity, // ยืดเต็มหน้าจอ
      color: Colors.white, // พื้นหลังขาว
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Timer
            Text(
              "เวลาที่ทำรายการ: ${formatTime(_remainingTime)}",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Stage
            Container(
              height: 50,
              width: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: const Text(
                "STAGE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // โซนที่นั่ง
            buildZoneRow(['AA1', 'AA2', 'AA3'], Colors.pinkAccent, Colors.white),
            const SizedBox(height: 10),
            buildZoneRow(['AA4', 'AA5', 'AA6'], Colors.yellow, Colors.black),
            const SizedBox(height: 10),
            buildZoneRow(['BB1', 'BB2', 'BB3', 'BB4', 'BB5', 'BB6'], Colors.lightBlueAccent, Colors.black),

            const SizedBox(height: 20),

            // STD Zone
            Container(
              height: 40,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "STD",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ปุ่มราคา
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildPriceButton("฿2,500", Colors.blue),
                buildPriceButton("฿3,500", Colors.lightBlueAccent),
                buildPriceButton("฿4,500", Colors.yellow),
                buildPriceButton("฿5,500", Colors.pinkAccent),
              ],
            ),

            const SizedBox(height: 20),

            // กล่องโซนที่นั่ง
            buildSeatContainers(),
          ],
        ),
      ),
    ),
  );
}
}


  Widget buildZoneRow(List<String> zones, Color color, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: zones
          .map(
            (zone) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GestureDetector(
                onTap: () {
                  debugPrint("Selected Zone: $zone");
                },
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Text(
                    zone,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }



void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ConcertPlan(),
  ));
}