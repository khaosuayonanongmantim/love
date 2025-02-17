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
  List<String> seatZones = ['STD']; // รายการโซนที่แสดงผล
  List<String> seatPrices = [];
  List<dynamic> _zones = [];
  String? selectedConcertID;  // เพิ่มตัวแปรเพื่อเก็บ concertID ที่เลือก
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


  // Future<void> fetchZones() async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse('http://192.168.55.228:5000/?concert_id=${concertID.id}'));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         _zones = jsonDecode(response.body);
  //         _isLoading = false;
  //       });
  //     } else {
  //       print('Failed to load concerts: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching concerts: $e');
  //   }
  // }

  @override
  void dispose() {
    _timer.cancel(); 
    super.dispose();
  }

  // เพิ่มตัวแปรสีตามโซน
  Map<String, Color> zoneColors = {
    'STD': Colors.pinkAccent,
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

      // ตรวจสอบให้ seatPrices มีจำนวนรายการเท่ากับ seatZones
      seatPrices = List.generate(seatZones.length, (index) => price);
    });
  }

  void _bookSeat(String zone) {
    setState(() {
      selectedZone = zone;
    });

    // เมื่อเลือกโซน จะนำทางไปยังหน้ารายละเอียดของโซนที่เลือก
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZoneDetailPage(
          zoneName: zone,
          selectedPrice: selectedPrice,
          imagePath: widget.imagePath,
          concertName: widget.concertName,
          date: widget.date,
          time: widget.time,
          location: widget.location,
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
    children: _zones.map((zone) {
      String zoneName = zone['name'] ?? 'Unknown';
      String seatCount = zone['seat_count']?.toString() ?? 'N/A';
      Color zoneColor = zoneColors[zoneName] ?? Color.fromARGB(255, 255, 34, 100);

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
                    "฿$seatCount",
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
      height: double.infinity,
      color: Colors.white,
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
                : buildSeatContainers(),  // แสดงโซนหากโหลดเสร็จ
          ],
        ),
      ),
    ),
 
  );
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
}