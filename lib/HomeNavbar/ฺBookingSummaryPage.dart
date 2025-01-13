import 'package:flutter/material.dart';

class BookingSummaryPage extends StatefulWidget {
  final String zoneName;
  final List<String> selectedSeats;
  final double totalPrice;
  final double vatAmount;
  final double serviceFee;

  const BookingSummaryPage({
    Key? key,
    required this.zoneName,
    required this.selectedSeats,
    required this.totalPrice,
    required this.vatAmount,
    required this.serviceFee,
  }) : super(key: key);

  @override
  _BookingSummaryPageState createState() => _BookingSummaryPageState();
}

class _BookingSummaryPageState extends State<BookingSummaryPage> {
  bool isChecked = false; // จัดการสถานะของ Checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สรุปการจอง'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ข้อมูลผู้ซื้อบัตร
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ข้อมูลผู้ซื้อบัตร',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'ชื่อ',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'นามสกุล',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'เบอร์โทรศัพท์',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'อีเมล',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // สรุปรายการสั่งซื้อ
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'สรุปรายการสั่งซื้อ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'โซนที่เลือก: ${widget.zoneName}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'ที่นั่งที่เลือก: ${widget.selectedSeats.join(', ')}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'ราคารวม: ฿${widget.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  Text(
                    'Vat: ฿${widget.vatAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  Text(
                    'ค่าธรรมเนียม: ฿${widget.serviceFee.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'มีรหัสโปรโมชั่นหรือไม่?',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.check),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // เงื่อนไขและการชำระเงิน
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'กรุณาตรวจสอบข้อมูลให้ถูกต้อง และยืนยันเงื่อนไขก่อนชำระเงิน',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false; // อัปเดตสถานะ Checkbox
                          });
                        },
                      ),
                      const Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'ฉันยอมรับ ',
                            children: [
                              TextSpan(
                                text: 'ข้อกำหนดและเงื่อนไขการให้บริการ',
                                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            ExpansionTile(
  title: const Text('เดบิต/เครดิตการ์ด', style: TextStyle(color: Colors.red)),
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'หมายเลขบัตรเครดิต',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(
              labelText: 'ชื่อผู้ถือบัตร',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'เดือน',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(
                    12,
                    (index) => DropdownMenuItem(
                      value: '${index + 1}'.padLeft(2, '0'),
                      child: Text('${index + 1}'.padLeft(2, '0')),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'ปี',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(
                    10,
                    (index) => DropdownMenuItem(
                      value: '${DateTime.now().year + index}',
                      child: Text('${DateTime.now().year + index}'),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ข้อมูลบัตรถูกบันทึก')),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'ยืนยันการสั่งซื้อ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
),

    ExpansionTile(
  title: const Text('พร้อมเพย์', style: TextStyle(color: Colors.red)),
  children: [
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'ชำระผ่านช่องทางพร้อมเพย์',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
           const SizedBox(height: 10),
                        // เพิ่ม QR Code ใน Pop-up
                        Image.asset(
                          'assets/qr2.png', // Path ของ QR Code
                          width: 200,
                          height: 200,
                        ),
            const SizedBox(height: 10),
          const Text(
            'ขั้นตอนการชำระเงินหลังจากคลิกยืนยันการชำระเงิน ระบบจะสร้าง QR Code สำหรับชำระเงิน ท่านสามารถสแกน QR Code เพื่อชำระเงินได้ทันที',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // แสดง Pop-up เมื่อกดปุ่ม
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'สแกน QR Code เพื่อชำระเงิน',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // เพิ่ม QR Code ใน Pop-up
                        Image.asset(
                          'assets/qr1.jpg', // Path ของ QR Code
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ยอดชำระ: ฿${widget.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // ปิด Pop-up
                        },
                        child: const Text(
                          'ปิด',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'แสดง QR Code',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        
        ],
      ),
    ),
  ],
)

          ],
        ),
      ),
    );
  }
}
