import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/ZoneDetailPage.dart';

class ConcertPlan extends StatefulWidget {
  final String imagePath;
  final String concertName;
  final String date;
  final String time;
  final String location;
  final String price;

  const ConcertPlan({
    Key? key,
    required this.imagePath,
    required this.concertName,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
  }) : super(key: key);

  @override
  State<ConcertPlan> createState() => _ConcertPlanState();
}

class _ConcertPlanState extends State<ConcertPlan> {
  late Timer _timer;
  int _remainingTime = 300; // ตั้งค่าเวลานับถอยหลัง (300 วินาที = 5 นาที)
  String selectedPrice = "฿2,500"; // ราคาเริ่มต้นที่เลือก
  String selectedZone = "STD"; // โซนที่เลือก
  List<String> seatPrices = [];
  List<dynamic> _zones = [];
  String? selectedConcertID;  
  List<dynamic> concerts = [];
  bool _isLoading = true;

@override
void initState() {
  super.initState();
 fetchConcerts();// แก้ให้เป็น concert_id ที่ถูกต้อง
  startTimer();
}

Future<void> fetchConcerts() async {
  try {
    final response = await http.get(Uri.parse("http://192.168.55.228:5000/getAllConcerts"));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        concerts = data;
      });
    } else {
      print("❌ โหลดคอนเสิร์ตล้มเหลว");
    }
  } catch (e) {
    print("❌ เกิดข้อผิดพลาดในการโหลดคอนเสิร์ต: $e");
  }
}

Future<void> fetchZones(String concertID) async {
  try {
    final response = await http.get(Uri.parse(
        'http://192.168.55.228:5000/getZones?concert_id=$concertID'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print("🎯 ข้อมูลที่ได้จาก API: $data"); // ✅ เช็คว่าข้อมูลมาไหม

      setState(() {
        _zones = data;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load zones');
    }
  } catch (e) {
    print('❌ Error fetching zones: $e');
  }
}

  @override
  void dispose() {
    _timer.cancel(); 
    super.dispose();
  }

  // เพิ่มตัวแปรสีตามโซน
  Map<String, Color> zoneColors = {};

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


 void _bookSeat(String zone) {
  if (selectedConcertID == null) {
    print("❌ กรุณาเลือกคอนเสิร์ตก่อนทำการจอง");
    return;
  }

  setState(() {
    selectedZone = zone;
  });

    // เมื่อเลือกโซน จะนำทางไปยังหน้ารายละเอียดของโซนที่เลือก
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZoneDetailPage(
        concertId: int.parse(selectedConcertID!), // ✅ ใช้ค่า selectedConcertID
        zoneName: zone,
        selectedPrice: selectedPrice,
        imagePath: widget.imagePath,
        concertName: widget.concertName,
        date: widget.date,
        time: widget.time,
        location: widget.location,
        price: widget.price,
        ),
      ),
    );
  }

  

Widget buildSeatContainers(String price) {
  return Column(
    children: [
      // 🔹 เพิ่มกล่อง STAGE ด้านบน
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          width: 360,
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.pink, // สีชมพูให้เด่นขึ้น
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Text(
            "STAGE",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      // 🔹 แสดงกล่องโซนเล็กๆ ใต้ STAGE
      Wrap(
        spacing: 8, // ระยะห่างระหว่างกล่อง
        runSpacing: 8, // ระยะห่างระหว่างบรรทัด
        children: _zones.map((zone) {
          String zoneName = zone['name'] ?? 'Unknown';
          Color zoneColor = zoneColors[zoneName] ?? Color.fromARGB(255, 243, 98, 141);

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: zoneColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "$zoneName - $price",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
const Divider(color: Colors.grey, thickness: 1),
      const SizedBox(height: 10), // ระยะห่าง

      // 🔹 แสดงโซนที่นั่งแบบใหญ่
      ..._zones.map((zone) {
        String zoneName = zone['name'] ?? 'Unknown';
        String seatCount = zone['seat_count']?.toString() ?? 'N/A';
        Color zoneColor = zoneColors[zoneName] ?? const Color.fromARGB(255, 233, 59, 111);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            width: 360,
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: zoneColor,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      zoneName,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "ที่นั่ง $seatCount ราคา $price",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    _bookSeat(zoneName);
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ],
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('แผนผังโซนที่นั่ง'),
       backgroundColor: const Color.fromARGB(255, 255, 135, 175),
    ),
    body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFFFFE4E1),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ตัวเลือกคอนเสิร์ต
            DropdownButton<String>(
              value: selectedConcertID,
              hint: Text("เลือกคอนเสิร์ต"),
              onChanged: (String? newValue) {
                setState(() {
                  selectedConcertID = newValue;
                });
                if (newValue != null) {
                  fetchZones(newValue);  // โหลดโซนของคอนเสิร์ตที่เลือก
                }
              },
              items: concerts.map<DropdownMenuItem<String>>((concert) {
                return DropdownMenuItem<String>(
                  value: concert["id"].toString(),
                  child: Text(concert["name"]),
                );
              }).toList(),
            ),
            
            // แสดงข้อมูลโซน
            _isLoading
                ? const CircularProgressIndicator()
                : buildSeatContainers(widget.price),  // ✅ ส่ง widget.price เข้าไป
  // แสดงโซนหากโหลดเสร็จ
          ],
        ),
      ),
    ),
 
  );
}

}