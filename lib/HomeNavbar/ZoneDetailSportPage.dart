import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/BookingSummaryPageSport.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZoneDetailSportPage extends StatefulWidget {
  final String zoneName;
  final String selectedPrice;
  final String imagePath;
  final String sportName;
  final String date;
  final String time;
  final String location;
  final String price;
  final int sportId;

  const ZoneDetailSportPage({
    Key? key,
    required this.zoneName,
    required this.selectedPrice,
    required this.imagePath,
    required this.sportName,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
    required this.sportId,
  }) : super(key: key);

  @override
  _ZoneDetailSportPageState createState() => _ZoneDetailSportPageState();
}

class _ZoneDetailSportPageState extends State<ZoneDetailSportPage> {
  int? userId; // 🆔 เก็บ userId
  List<bool> seats = List.generate(100, (_) => false);
  List<String> selectedSeats = [];
  List<dynamic> _Seat = [];
  bool _isLoading = true;
  late Timer _timer;
  int _remainingTime = 300;

  @override
  void initState() {
    super.initState();
    loadUserId(); // โหลด userId จาก SharedPreferences
    fetchSeat(widget.zoneName, widget.sportId);
    startTimer();
  }

Future<void> loadUserId() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    userId = prefs.getInt("userId"); // ดึง userId เป็น integer
  });

  if (userId != null) {
    print("🔍 Loaded User ID: $userId");
  } else {
    print("❌ No User ID found in SharedPreferences");
  }
}


Future<int?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt("userId"); // ให้แน่ใจว่าเป็นประเภท int
}


  Future<int?> fetchZoneId(String sportZoneName, int sportId) async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.55.228:5000/getZoneSport?sport_id=$sportId'));

      if (response.statusCode == 200) {
        final List<dynamic> zones = json.decode(response.body);

        for (var zone in zones) {
          if (zone['name'] == sportZoneName && zone['sport_id'] == sportId) {
            return zone['id']; // คืนค่า zone_id ที่ถูกต้อง
          }
        }
      }
    } catch (e) {
      print('❌ Error fetching zone ID: $e');
    }
    return null; // ถ้าไม่เจอ zoneId
  }

  Future<void> fetchSeat(String sportZoneName, int sportId) async {
    try {
      print("📡 Fetching zone ID for: $sportZoneName");

      int? zoneId = await fetchZoneId(sportZoneName, sportId);

      if (zoneId == null) {
        throw Exception('❌ ไม่พบ zoneId สำหรับโซน: $sportZoneName');
      }

      final response = await http
          .get(Uri.parse('http://192.168.55.228:5000/api/seatSport/$zoneId'));

      print("🚀 API Response Code: ${response.statusCode}");
      print("📥 API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          _Seat = data
              .map((sport_seats) => {
                    "id": sport_seats["id"],
                    "zoneSp_id ": sport_seats["zoneSp_id "],
                    "seat_number": sport_seats["seat_number"],
                    "is_reserved": sport_seats["is_reserved"]
                  })
              .toList();
          _isLoading = false;
        });
      } else {
        throw Exception('❌ ไม่สามารถโหลดข้อมูลที่นั่งได้');
      }
    } catch (e) {
      print('❌ Error fetching seats: $e');
    }
  }

  Future<void> updateSeatsInDatabase(List<String> selectedSeats) async {
    try {
      for (String seatNumber in selectedSeats) {
        print("📡 Updating seat: $seatNumber");

        final response = await http.post(
          Uri.parse("http://192.168.55.228:5000/api/update-seatSport"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "seatNumber": seatNumber,
            "status": 1, // เปลี่ยนสถานะเป็นจองแล้ว
          }),
        );

        if (response.statusCode == 200) {
          print("✅ อัปเดตที่นั่งสำเร็จ: $seatNumber");
        } else {
          print("❌ อัปเดตที่นั่งล้มเหลว: ${response.body}");
        }
      }

      print("🎉 ที่นั่งทั้งหมดถูกอัปเดตเรียบร้อย");
    } catch (e) {
      print("❌ ข้อผิดพลาดในการอัปเดตที่นั่ง: $e");
    }
  }

  Future<void> bookSeats(int? userId, int sportId, int zoneId,
      List<String> selectedSeats, double totalPrice) async {
    final url = Uri.parse("http://192.168.55.228:5000/api/book-seatSport");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userid": userId,
        "sport_id": sportId,
        "zoneSp_id": zoneId,
        "selectedSeats": selectedSeats,
        "total_price": totalPrice,
      }),
    );

    print("📡 Sending booking request...");
    print("📤 Request Body: ${jsonEncode({
          "userid": userId,
          "sport_id": sportId,
          "zoneSp_id": zoneId,
          "selectedSeats": selectedSeats,
          "total_price": totalPrice,
        })}");

    print("📥 Response Code: ${response.statusCode}");
    print("📥 Response Body: ${response.body}");

    if (response.statusCode == 200) {
      print("✅ Booking successful!");

      // โหลดข้อมูลที่นั่งใหม่
      await fetchSeat(widget.zoneName, widget.sportId);
    } else {
      print("❌ Booking failed: ${response.body}");
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Stop timer when the page is closed
    super.dispose();
  }

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

  void _onTick(Timer timer) {
    if (_remainingTime > 0) {
      setState(() {
        _remainingTime--;
      });
    } else {
      timer.cancel();
    }
  }

  String get formattedTime {
    int minutes = _remainingTime ~/ 60;
    int seconds = _remainingTime % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  Map<String, double> calculateTotalPrice() {
    try {
      // ใช้ค่า price จาก widget โดยตรง
      double ticketPrice = double.tryParse(widget.price) ?? 0.0;
      int selectedCount = selectedSeats.length;
      double totalSeatPrice = ticketPrice * selectedCount;

      // คำนวณ VAT (7%) และค่าธรรมเนียม (7%)
      const double vatRate = 0.07;
      const double serviceFeeRate = 0.07;

      double vatAmount = totalSeatPrice * vatRate;
      double serviceFee = totalSeatPrice * serviceFeeRate;
      double totalPrice = totalSeatPrice + vatAmount + serviceFee;

      return {
        "totalPrice": totalPrice,
        "vatAmount": vatAmount,
        "serviceFee": serviceFee,
      };
    } catch (e) {
      print("❌ Error calculating total price: $e");
      return {
        "totalPrice": 0.0,
        "vatAmount": 0.0,
        "serviceFee": 0.0,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดโซน ${widget.zoneName}'),
        backgroundColor: const Color.fromARGB(255, 255, 135, 175),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Timer section
              Text(
                'เวลาที่ทำรายการ: $formattedTime',
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(height: 20),

              // Legend section
              Column(
                children: [
                  // 🔹 แถวแรก: ฟ้า - เขียว - เทา (จัดให้อยู่ห่างเท่ากัน)
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // กระจายไอเทมให้ห่างกันเท่ากัน
                    children: [
                      _buildLegendItem(Colors.blue, 'ที่นั่งว่าง'),
                      _buildLegendItem(Colors.green, 'ที่นั่งที่เลือก'),
                      _buildLegendItem(Colors.grey, 'ที่นั่งถูกจองแล้ว'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Stage label
              Center(
                child: Container(
                  width: 120, // กำหนดให้เป็นวงกลม (กว้าง = สูง)
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 6, 153, 133),
                    shape: BoxShape.circle, // ทำให้เป็นวงกลม
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'STAGE',
                    style: TextStyle(
                      fontSize: 18, // ปรับขนาดให้เหมาะสม
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Seat grid
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount:
                    _Seat.isEmpty ? 1 : _Seat.length, // ตรวจสอบจำนวนที่นั่ง
                itemBuilder: (context, index) {
                  if (_Seat.isEmpty) {
                    return Center(
                        child: Text("ไม่มีข้อมูลที่นั่ง",
                            style: TextStyle(color: Colors.red)));
                  }

                  var seat = _Seat[index];
                  String seatLabel = seat['seat_number'] ?? "N/A";
                  bool isBooked =
                      seat['is_reserved'] == true || seat['is_reserved'] == 1;
                  bool isPaid = seat['is_paid'] == true || seat['is_paid'] == 1;

                  bool isSelected = selectedSeats.contains(seatLabel);

                  return GestureDetector(
                    onTap: () {
                      if (!isBooked && !isPaid) {
                        setState(() {
                          if (isSelected) {
                            selectedSeats.remove(seatLabel);
                          } else {
                            selectedSeats.add(seatLabel);
                          }
                          print(
                              "Updated Total Price: ${calculateTotalPrice()}");
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isPaid
                            ? Colors.red // 🔴 ชำระเงินแล้ว
                            : isBooked
                                ? Colors.grey // 🔘 จองแล้ว
                                : isSelected
                                    ? Colors.green // ✅ ที่นั่งที่เลือก
                                    : Colors.blue, // 🔵 ว่าง
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(2, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Selected zone and price
              Text(
                'คุณเลือกโซน: ${widget.zoneName}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'ราคา: ${widget.price}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Selected seats
              Text(
                'ที่นั่งที่เลือก: ${selectedSeats.isNotEmpty ? selectedSeats.join(', ') : 'ไม่มีที่นั่งที่เลือก'}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent),
              ),
              const SizedBox(height: 20),

              // Total price
              Text(
                //'ราคารวม: ฿${(double.tryParse(widget.price)! * selectedSeats.length).toStringAsFixed(2)}',
                'ราคารวม: ฿${calculateTotalPrice()["totalPrice"]!.toStringAsFixed(2)}',

                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(height: 20),

              // Booking button
              ElevatedButton(
                onPressed: () async {
                  if (selectedSeats.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('แจ้งเตือน'),
                        content: const Text('กรุณาเลือกที่นั่งก่อนทำการจอง'),
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
                  } else {
                    int? userId =
                        await getUserId(); // เปลี่ยนจาก String? เป็น int?
                    if (userId == null) {
                      print("❌ User ID not found!");
                      return;
                    }

                    int? zoneId =
                        await fetchZoneId(widget.zoneName, widget.sportId);
                    if (zoneId == null) {
                      print("❌ Zone ID not found!");
                      return;
                    }

                    Map<String, double> priceDetails = calculateTotalPrice();

                    // ✅ เรียก API เพื่อทำการจอง
                    await bookSeats(userId, widget.sportId, zoneId,
                        selectedSeats, priceDetails["totalPrice"]!);

                    // ✅ โหลดข้อมูลที่นั่งใหม่หลังจากจอง
                    await fetchSeat(widget.zoneName, widget.sportId);

                    // ✅ นำทางไปหน้า Booking Summary
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingSummaryPageSport(
                          zoneName: widget.zoneName,
                          selectedSeats: selectedSeats,
                          totalPrice: priceDetails["totalPrice"]!,
                          vatAmount: priceDetails["vatAmount"]!,
                          serviceFee: priceDetails["serviceFee"]!,
                          imagePath: widget.imagePath,
                          sportName: widget.sportName,
                          date: widget.date,
                          time: widget.time,
                          location: widget.location,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 221, 42, 221),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'จองที่นั่ง',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for legend items
  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
