import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:project_new/Payment/ReceiptConSportPage.dart';

class BookingSummaryPageCon extends StatefulWidget {
  final String concertName;
  final String date;
  final String time;
  final String location;
  final String zoneName;
  final List<String> selectedSeats;
  final double totalPrice;
  final double vatAmount;
  final double serviceFee;
  final String imagePath; // เพิ่มตัวแปรรับรูปภาพ

    const BookingSummaryPageCon({
    Key? key,
    required this.concertName,
    required this.date,
    required this.time,
    required this.location,
    required this.zoneName,
    required this.selectedSeats,
    required this.totalPrice,
    required this.vatAmount,
    required this.serviceFee,
    required this.imagePath, // รับค่ารูปภาพจาก ZoneDetailPage
  }) : super(key: key);
  
  @override
  _BookingSummaryPageConState createState() => _BookingSummaryPageConState();
}

class _BookingSummaryPageConState extends State<BookingSummaryPageCon> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isChecked = false; // จัดการสถานะของ Checkbox
  File? selectedImage;

    // ตัวแปรสำหรับเก็บค่าฟอร์มของบัตรเครดิต
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  String? selectedMonth;
  String? selectedYear;

    String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

    Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

   // ฟังก์ชันตรวจสอบฟอร์มบัตรเครดิต
  bool _validateCardForm() {
    return cardNumberController.text.isNotEmpty &&
        cardHolderController.text.isNotEmpty &&
        cvvController.text.isNotEmpty &&
        selectedMonth != null &&
        selectedYear != null;
  }


  bool _isLoading = true; // เพิ่มตัวแสดง Loading

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

Future<void> _loadUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  setState(() {
    _firstNameController.text = prefs.getString('firstName') ?? '';
    _lastNameController.text = prefs.getString('lastName') ?? '';
    _phoneController.text = prefs.getString('phone') ?? '';
    _emailController.text = prefs.getString('email') ?? '';
    _isLoading = false;
  });
}
  @override
  Widget build(BuildContext context) {
        String formattedDate = formatDate(widget.date);
    return Scaffold(
      appBar: AppBar(
        title: const Text("สรุปการจอง"),
         backgroundColor: Colors.pinkAccent,
        ),
      
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // แสดง Loading
          : SingleChildScrollView(
      
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(labelText: 'ชื่อ', border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(labelText: 'นามสกุล', border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                 
                  const SizedBox(height: 10),
               TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'อีเมล', border: OutlineInputBorder()),
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
                mainAxisAlignment:
                    MainAxisAlignment.start, // จัดแนวทางตั้ง (แนวหลัก)
                crossAxisAlignment:
                    CrossAxisAlignment.start, // จัดแนวขวาง (แนวขวาง)
                children: [
                  // เพิ่มรูปภาพที่ด้านบนสุด
                  const Text(
                    'สรุปรายการสั่งซื้อ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  Row(
                    children: [
                      // รูปภาพด้านซ้าย
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.imagePath,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                          width: 10), // ช่องว่างระหว่างรูปภาพกับข้อความ

                      // ข้อความด้านขวา
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.concertName,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              'วันที่ : $formattedDate',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 30, 141, 34)),
                            ),
                            Text(
                              'เวลา : ${widget.time}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 39, 163, 201)),
                            ),
                            Text(
                              'สถานที่ : ${widget.location}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 42, 39, 201)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 32, thickness: 1, color: Colors.black),
                  Text(
                    'โซนที่เลือก: ${widget.zoneName}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'ที่นั่งที่เลือก: ${widget.selectedSeats.join(', ')}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),

                  Text(
                    'Vat: ฿${widget.vatAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  Text(
                    'ค่าธรรมเนียม: ฿${widget.serviceFee.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  Text(
                    'ราคารวม: ฿${widget.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const SizedBox(height: 20),

                  // ฟอร์มกรอกข้อมูลรหัสโปรโมชั่น
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
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
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
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
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
              title: const Text('เดบิต/เครดิตการ์ด',
                  style: TextStyle(color: Colors.red)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: cardNumberController,
                        decoration: const InputDecoration(
                          labelText: 'หมายเลขบัตรเครดิต',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: cardHolderController,
                        decoration: const InputDecoration(
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
                              onChanged: (value) {
                                setState(() {
                                  selectedMonth = value;
                                });
                              },
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
                              onChanged: (value) {
                                setState(() {
                                  selectedYear = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: cvvController,
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
                          onPressed: _validateCardForm()
                              ? () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('ยืนยันการสั่งซื้อ'),
                                        content: const Text(
                                            'คุณแน่ใจหรือไม่ว่าต้องการยืนยันการสั่งซื้อ?'),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('ยกเลิก'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReceiptConSportPage(
                                                    concertName:widget.concertName,
                                                    date: widget.date,
                                                    imagePath: widget.imagePath,
                                                    time: widget.time,
                                                    location: widget.location,
                                                    zoneName: widget.zoneName,
                                                    selectedSeats:widget.selectedSeats,
                                                    totalPrice:widget.totalPrice,
                                                    vatAmount: widget.vatAmount,
                                                    serviceFee:widget.serviceFee,
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.redAccent),
                                            child: const Text('ยืนยัน', style: TextStyle(
                              color: Colors.white,
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'ยืนยันการสั่งซื้อ',
                            style: TextStyle(
                              color: Colors.white,
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ExpansionTile(
              title:
                  const Text('พร้อมเพย์', style: TextStyle(color: Colors.red)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'ชำระผ่านช่องทางพร้อมเพย์',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
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
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: _pickImage,
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blueAccent),
                                      child: const Text('แนบไฟล์รูป',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                    selectedImage != null
                                        ? Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              Image.file(
                                                selectedImage!,
                                                width: 150,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReceiptConSportPage(
                                            concertName: widget.concertName,
                                            date: widget.date,
                                            time: widget.time,
                                            imagePath: widget.imagePath,
                                            location: widget.location,
                                            zoneName: widget.zoneName,
                                            selectedSeats: widget.selectedSeats,
                                            totalPrice: widget.totalPrice,
                                            vatAmount: widget.vatAmount,
                                            serviceFee: widget.serviceFee,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'ยืนยันการชำระเงิน',
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'แสดง QR Code',
                          
                          style: TextStyle(
                            color: Colors.white,
                              fontSize: 16,
                               fontWeight: FontWeight.bold,),
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
