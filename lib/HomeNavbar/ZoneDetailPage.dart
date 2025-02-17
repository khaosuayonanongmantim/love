import 'dart:async';
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

  const ZoneDetailPage({
    Key? key,
    required this.zoneName,
    required this.selectedPrice,
    required this.imagePath,
    required this.concertName,
    required this.date,
    required this.time,
    required this.location,
  }) : super(key: key);

  @override
  _ZoneDetailPageState createState() => _ZoneDetailPageState();
}

class _ZoneDetailPageState extends State<ZoneDetailPage> {
  List<bool> seats = List.generate(100, (_) => false); // Seat statuses
  List<String> selectedSeats = []; // Track selected seats

  // Timer for countdown
  late Timer _timer;
  int _remainingTime = 300; // 5 minutes (300 seconds)

  @override
  void initState() {
    super.initState();
    startTimer();
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
      // ล้างข้อมูล widget.selectedPrice ให้แน่ใจว่าไม่มีปัญหา
      String cleanedPrice = widget.selectedPrice
          .replaceAll(RegExp(r'[^\d.]'), ''); // เก็บเฉพาะตัวเลขและจุดทศนิยม
      double ticketPrice = double.tryParse(cleanedPrice) ?? 0.0;

      // ตรวจสอบค่า selectedSeats ว่ามีจำนวนถูกต้อง
      int selectedCount = selectedSeats.length;
      double totalSeatPrice = ticketPrice * selectedCount;

      // คำนวณ VAT และค่าธรรมเนียมบริการ
      const double vatRate = 0.07; // VAT 7%
      const double serviceFeeRate = 0.07 * 1.07; // ค่าธรรมเนียม 5%

      double vatAmount = totalSeatPrice * vatRate;
      double serviceFee = totalSeatPrice * serviceFeeRate;
      double totalPrice = totalSeatPrice + vatAmount + serviceFee;

      // คืนค่าทั้งหมด
      return {
        "totalPrice": totalPrice,
        "vatAmount": vatAmount,
        "serviceFee": serviceFee,
      };
    } catch (e) {
      print("Error calculating total price: $e");
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: _buildLegendItem(
                              Colors.grey, 'ที่นั่งถูกจองแล้ว')),
                      Expanded(
                          child: _buildLegendItem(
                              Colors.red, 'ที่นั่งที่ชำระเงินแล้ว')),
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
                itemCount: 100,
                itemBuilder: (context, index) {
                  String seatLabel =
                      '${widget.zoneName}${(index ~/ 10) + 1}-${(index % 10) + 1}';

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        seats[index] = !seats[index];
                        if (seats[index]) {
                          selectedSeats.add(seatLabel);
                        } else {
                          selectedSeats.remove(seatLabel);
                        }
                        // เรียกคำนวณราคารวมใหม่
                        print("Updated Total Price: ${calculateTotalPrice()}");
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: seats[index] ? Colors.green : Colors.blue,
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
                'ราคา: ${widget.selectedPrice}',
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
