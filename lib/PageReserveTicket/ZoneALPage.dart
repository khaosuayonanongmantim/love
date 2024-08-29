import 'package:flutter/material.dart';
import 'package:project_new/Payment/PaymentPage1.dart'; // Import PaymentPage1

class ZoneALPage extends StatefulWidget {
  const ZoneALPage({super.key});

  @override
  State<ZoneALPage> createState() => _ZoneALPageState();
}

class _ZoneALPageState extends State<ZoneALPage> {
  Set<int> selectedSeats = Set();
  Set<int> bookedSeats = Set(); // Set to keep track of booked seats
  static const double seatPrice = 4000.0;

  @override
  Widget build(BuildContext context) {
    final seatNumbers = selectedSeats.map((e) => e + 1).join(', ');
    final totalAmount = seatPrice * selectedSeats.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('เลือกที่นั่งในโซน AL'),
        backgroundColor: const Color.fromARGB(255, 102, 51, 153), // Updated color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status legend
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 248, 255), // Match color with seating chart
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'สถานะที่นั่ง',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.white,
                        margin: const EdgeInsets.only(right: 8.0),
                        child: const Center(child: Text(' ', style: TextStyle(fontSize: 14))),
                      ),
                      const Text('Available'),
                      const SizedBox(width: 16),
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.grey,
                        margin: const EdgeInsets.only(right: 8.0),
                        child: const Center(child: Text(' ', style: TextStyle(fontSize: 14))),
                      ),
                      const Text('Booked'),
                      const SizedBox(width: 16),
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.green,
                        margin: const EdgeInsets.only(right: 8.0),
                        child: const Center(child: Text(' ', style: TextStyle(fontSize: 14))),
                      ),
                      const Text('Selected'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Seating chart
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 248, 255), // Updated color
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'เลือกที่นั่งในโซน AL',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'คลิกที่ที่นั่งเพื่อเลือก.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 320), // Adjust height as needed
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      itemCount: 40,
                      itemBuilder: (context, index) {
                        final isSelected = selectedSeats.contains(index);
                        final isBooked = bookedSeats.contains(index);
                        return GestureDetector(
                          onTap: () {
                            if (!isBooked) {
                              setState(() {
                                if (isSelected) {
                                  selectedSeats.remove(index);
                                } else {
                                  selectedSeats.add(index);
                                }
                              });
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: isBooked
                                  ? Colors.grey // Booked seat color
                                  : isSelected
                                      ? Colors.green // Selected seat color
                                      : Colors.white, // Available seat color
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.black45, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Summary section
            SizedBox(
              width: double.infinity, // Make container span the full width
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 248, 255), // Match color with seating chart
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ที่นั่งที่เลือก',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ที่นั่งที่เลือก: $seatNumbers',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'ราคา: ฿${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: selectedSeats.isEmpty
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('ยืนยันการจอง'),
                                  content: Text(
                                    'คุณต้องการยืนยันการจองที่นั่ง: $seatNumbers\nยอดรวม: ฿${totalAmount.toStringAsFixed(2)}',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('ยกเลิก'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PaymentPage(
                                              seatNumbers: seatNumbers,
                                              totalAmount: totalAmount.toStringAsFixed(2),
                                              onBookingComplete: () {
                                                setState(() {
                                                  bookedSeats.addAll(selectedSeats);
                                                  selectedSeats.clear();
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('ยืนยัน'),
                                    ),
                                  ],
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'ยืนยันการจองที่นั่ง',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  final String seatNumbers;
  final String totalAmount;
  final VoidCallback onBookingComplete;

  const PaymentPage({
    super.key,
    required this.seatNumbers,
    required this.totalAmount,
    required this.onBookingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ชำระเงิน'),
        backgroundColor: Colors.deepPurple, // Updated color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'คุณกำลังจองที่นั่ง: $seatNumbers',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'ยอดรวม: ฿$totalAmount',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage1(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5,
              ),
              child: const Text(
                'ดำเนินการชำระเงิน',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}