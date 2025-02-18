import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/ZoneDetailSportPage.dart';

class SportPlan extends StatefulWidget {
  final String imagePath;
  final String sportName;
  final String date;
  final String time;
  final String location;
  final String price;

  const SportPlan({
    Key? key,
    required this.imagePath,
    required this.sportName,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
  }) : super(key: key);

  @override
  State<SportPlan> createState() => _SportPlanState();
}

class _SportPlanState extends State<SportPlan> {
  late Timer _timer;
  int _remainingTime = 300; // ตั้งค่าเวลานับถอยหลัง (300 วินาที = 5 นาที)
  String selectedPrice = "฿2,500"; // ราคาเริ่มต้นที่เลือก
  String selectedZone = "STD"; // โซนที่เลือก
  List<dynamic> _zones = [];
  String? selectedSportID;
  List<dynamic> sports = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSports(); // แก้ให้เป็น concert_id ที่ถูกต้อง
    startTimer();
  }

  Future<void> fetchSports() async {
    try {
      final response =
          await http.get(Uri.parse("http://192.168.55.228:5000/getAllSports"));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          sports = data;
        });
      } else {
        print("❌ โหลดคอนเสิร์ตล้มเหลว");
      }
    } catch (e) {
      print("❌ เกิดข้อผิดพลาดในการโหลดคอนเสิร์ต: $e");
    }
  }

  Future<void> fetchZones(String sportID) async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.55.228:5000/getZoneSport?sport_id=$sportID'));

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
    if (selectedSportID == null) {
      print("❌ กรุณาเลือกการดูกีฬาก่อนทำการจอง");
      return;
    }

    setState(() {
      selectedZone = zone;
    });

    // เมื่อเลือกโซน จะนำทางไปยังหน้ารายละเอียดของโซนที่เลือก
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZoneDetailSportPage(
          sportId: int.parse(selectedSportID!), // ✅ ใช้ค่า
          zoneName: zone,
          selectedPrice: selectedPrice,
          imagePath: widget.imagePath,
          sportName: widget.sportName,
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
     Column(
  children: [
    // 🔹 Row สำหรับ STAGE และ 2 โซนแรก
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 🔹 โซนซ้ายของ STAGE (ถ้ามี)
        if (_zones.isNotEmpty)
          Container(
            width: 110,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: zoneColors[_zones[0]['name']] ?? Color.fromARGB(255, 177, 26, 190),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "${_zones[0]['name']} - $price",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        // 🔹 STAGE (อยู่ตรงกลาง)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            width: 110,
            height: 110,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 6, 153, 133),
              shape: BoxShape.circle,
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
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // 🔹 โซนขวาของ STAGE (ถ้ามี)
        if (_zones.length > 1)
          Container(
            width: 110,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: zoneColors[_zones[1]['name']] ?? Color.fromARGB(255, 177, 26, 190),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "${_zones[1]['name']} - $price",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),

    const SizedBox(height: 10), // ระยะห่างระหว่าง Row และ Wrap

    // 🔹 แสดงกล่องโซนที่เหลือด้านล่าง STAGE
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _zones.skip(2).map((zone) { // ข้าม 2 อันแรก
        String zoneName = zone['name'] ?? 'Unknown';
        Color zoneColor = zoneColors[zoneName] ?? Color.fromARGB(255, 177, 26, 190);

        return SizedBox(
          width: 110,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: zoneColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "$zoneName - $price",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    ),
  ],
),

        const Divider(color: Colors.grey, thickness: 1),
        const SizedBox(height: 10), // ระยะห่าง

        // 🔹 แสดงโซนที่นั่งแบบใหญ่
        ..._zones.map((zone) {
          String zoneName = zone['name'] ?? 'Unknown';
          String seatCount = zone['seat_count']?.toString() ?? 'N/A';
          Color zoneColor =
              zoneColors[zoneName] ?? Color.fromARGB(255, 85, 0, 119);

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
              DropdownButton<String>(
                value: selectedSportID,
                hint: Text("เลือกกีฬา"),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSportID = newValue;
                  });
                  if (newValue != null) {
                    fetchZones(newValue);
                  }
                },
                items: sports.map<DropdownMenuItem<String>>((sports) {
                  return DropdownMenuItem<String>(
                    value: sports["id"].toString(),
                    child: Text(sports["name"]),
                  );
                }).toList(),
              ),

              // แสดงข้อมูลโซน
              _isLoading
                  ? const CircularProgressIndicator()
                  : buildSeatContainers(
                      widget.price), // ✅ ส่ง widget.price เข้าไป
              // แสดงโซนหากโหลดเสร็จ
            ],
          ),
        ),
      ),
    );
  }
}
