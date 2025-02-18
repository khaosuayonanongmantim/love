import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_new/HomeNavbar/BookingSummaryPageCon.dart';

class ZoneDetailPage extends StatefulWidget {
  final String zoneName;
  final String selectedPrice;
  final String imagePath;
  final String concertName;
  final String date;
  final String time;
  final String location;
  final String price;
  final int concertId;

  const ZoneDetailPage({
    Key? key,
    required this.zoneName,
    required this.selectedPrice,
    required this.imagePath,
    required this.concertName,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
    required this.concertId,
  }) : super(key: key);

  @override
  _ZoneDetailPageState createState() => _ZoneDetailPageState();
}

class _ZoneDetailPageState extends State<ZoneDetailPage> {
  List<bool> seats = List.generate(100, (_) => false); // Seat statuses
  List<String> selectedSeats = []; // Track selected seats
  List<dynamic> _Seat = [];
  bool _isLoading = true;

  // Timer for countdown
  late Timer _timer;
  int _remainingTime = 300; // 5 minutes (300 seconds)

  @override
  void initState() {
    super.initState();
    fetchSeat(widget.zoneName, widget.concertId);
// 🔹 ส่งค่าโซนไปดึงข้อมูลที่นั่งจาก API
    startTimer();
  }
Future<int?> fetchZoneId(String concertZoneName, int concertId) async {
  try {
    final response = await http.get(Uri.parse(
        'http://192.168.55.228:5000/getZones?name=$concertZoneName&concert_id=$concertId'));

    if (response.statusCode == 200) {
      final List<dynamic> zones = json.decode(response.body);
      
      for (var zone in zones) {
        if (zone['name'] == concertZoneName && zone['concert_id'] == concertId) {
          return zone['id'];  // คืนค่า zone_id ที่ถูกต้อง
        }
      }
    }
  } catch (e) {
    print('❌ Error fetching zone ID: $e');
  }
  return null; // ถ้าไม่เจอ zoneId
}

Future<void> fetchSeat(String concertZoneName, int concertId) async {
  try {
    print("📡 Fetching zone ID for: $concertZoneName");
    
    int? zoneId = await fetchZoneId(concertZoneName, concertId);
    
    if (zoneId == null) {
      throw Exception('❌ ไม่พบ zoneId สำหรับโซน: $concertZoneName');
    }

    final response = await http.get(Uri.parse('http://192.168.55.228:5000/api/seats/$zoneId'));

    print("🚀 API Response Code: ${response.statusCode}");
    print("📥 API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        _Seat = data.map((seat) => {
          "id": seat["id"],
          "zone_id": seat["zone_id"],
          "seat_number": seat["seat_number"],
          "is_reserved": seat["is_reserved"]
        }).toList();
        _isLoading = false;
      });
    } else {
      throw Exception('❌ ไม่สามารถโหลดข้อมูลที่นั่งได้');
    }
  } catch (e) {
    print('❌ Error fetching seats: $e');
  }
}

  Future<void> updateSeatStatus(String seatNumber, int status) async {
    final url = Uri.parse("http://192.168.55.228:5000/api/update-seat");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"seatNumber": seatNumber, "status": status}),
    );

    if (response.statusCode == 200) {
      print("Seat updated successfully!");
    } else {
      print("Failed to update seat: ${response.body}");
    }
  }

  Future<void> bookSeats(String userId, int concertId, int zoneId,
      List<String> selectedSeats, double totalPrice) async {
    final url = Uri.parse("http://192.168.55.228:5000/api/book-seats");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "concertId": concertId,
        "zoneId": zoneId,
        "selectedSeats": selectedSeats,
        "total_price": totalPrice,
      }),
    );

    if (response.statusCode == 200) {
      print("Booking successful!");
    } else {
      print("Booking failed: ${response.body}");
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
        backgroundColor: Colors.pinkAccent,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: _buildLegendItem(Colors.blue, 'ที่นั่งว่าง')),
                      Expanded(
                          child: _buildLegendItem(
                              Colors.green, 'ที่นั่งที่เลือก')),
                    ],
                  ),
                  const SizedBox(height: 10), // ระยะห่างระหว่างแถว
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: _buildLegendItem(
                              Colors.grey, 'ที่นั่งถูกจองแล้ว')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Stage label
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.pinkAccent,
                child: const Center(
                  child: Text(
                    'STAGE',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                  bool isPaid =
                      seat['seat_number'] == true || seat['is_paid'] == 1;
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
                onPressed: () {
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
                    String bookedSeats = selectedSeats.join(', ');
                    Map<String, double> priceDetails = calculateTotalPrice();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('ยืนยันการจอง'),
                        content: Text(
                            'คุณได้จองที่นั่ง: $bookedSeats\nในโซน: ${widget.zoneName}'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // นำทางไปหน้า BookingSummaryPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingSummaryPageCon(
                                    zoneName: widget.zoneName,
                                    selectedSeats: selectedSeats,
                                    totalPrice: priceDetails["totalPrice"]!,
                                    vatAmount: priceDetails["vatAmount"]!,
                                    serviceFee: priceDetails["serviceFee"]!,
                                    imagePath: widget.imagePath,
                                    concertName: widget.concertName,
                                    date: widget.date,
                                    time: widget.time,
                                    location: widget.location,
                                  ),
                                ),
                              );
                            },
                            child: const Text('ตกลง'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
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
