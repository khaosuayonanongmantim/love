import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project_new/Payment/PaymentproSuccess.dart';

class ReceiptProductPage extends StatefulWidget {
  final Map<int, int> itemCounts;
  final List<Map<String, String>> items;
  final double totalPrice;

  ReceiptProductPage({
    required this.itemCounts,
    required this.items,
    required this.totalPrice,
  });

  @override
  _ReceiptProductPageState createState() => _ReceiptProductPageState();
}

class _ReceiptProductPageState extends State<ReceiptProductPage> {
  String? selectedPaymentMethod;
  bool isCreditCardSelected = false;
  File? slip;
  

  // Function to pick an image for the slip
  Future<void> _pickSlipImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        slip = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 135, 175),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product List Section
            ...widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final itemCount = widget.itemCounts[index] ?? 0;
              if (itemCount > 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      // SizedBox(
                      //   height: 50,
                      //   width: 50,
                      //   child: Image.asset(entry.value['image']!),
                      // ),

                      Expanded(
                        child: Text(
                          '${entry.value['title']}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // จัดให้อยู่ทางซ้าย
                        children: [
                          Text('จำนวน: $itemCount'),
                          Text('ราคา: ${entry.value['newPrice']}',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            }).toList(),
            Divider(height: 32, thickness: 1, color: Colors.black),
            // Total Price Section
            Text(
              'ราคารวมทั้งหมด: ${widget.totalPrice.toStringAsFixed(2)} บาท',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(height: 35, thickness: 1, color: Colors.black),
            // User Information Form
            _buildTextField(label: 'ชื่อ *'),
            _buildTextField(label: 'นามสกุล *'),
            _buildTextField(label: 'ที่อยู่ *', maxLines: 3),
            _buildTextField(
                label: 'เบอร์โทรศัพท์ *', keyboardType: TextInputType.phone),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'วิธีชำระเงิน *',
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 'credit', child: Text('บัตรเครดิต')),
                DropdownMenuItem(value: 'cash', child: Text('QR Code')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                  isCreditCardSelected = value == 'credit';
                });
              },
            ),
            SizedBox(height: 16),
            // Show a message depending on the selected payment method
            if (isCreditCardSelected) ...[
              // Display Credit Card Form when credit is selected
              _buildTextField(label: 'หมายเลขบัตร *'),
              _buildTextField(label: 'ชื่อผู้ถือบัตร *'),
              _buildTextField(label: 'วันหมดอายุ (MM/YY) *'),
              _buildTextField(label: 'รหัส CVV *'),
            ] else if (selectedPaymentMethod == 'cash') ...[
              // Text and QR Code display for QR code payment method
              Center(
                child: Text(
                  'สแกน QR Code เพื่อชำระเงินผ่านพร้อมเพย์',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
            SizedBox(height: 16),
            // Display QR Code when QR code payment is selected
            if (selectedPaymentMethod == 'cash') ...[
              Center(
                child: Image.asset('assets/qr1.jpg', height: 350),
              ),
            ],
            SizedBox(height: 16),
            // Upload Slip Section - Show only when QR Code (cash) is selected
            if (selectedPaymentMethod == 'cash') ...[
              Center(
                child: Text(
                  'อัปโหลดสลิปการโอนเงิน:',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: _pickSlipImage,
                  child: Text('เลือก...'),
                ),
              ),
              SizedBox(height: 16),
              // Display the uploaded slip if available
              if (slip != null) ...[
                Text('ตัวอย่างสลิปที่แนบมา:', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Image.file(
                  slip!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ],
            SizedBox(height: selectedPaymentMethod == 'credit' ? 10 : 24),
            // Confirm Payment Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // แสดง Snackbar ก่อนเปลี่ยนหน้า
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('การชำระเงินสำเร็จ!')),
                  );

                  // นำทางไปยังหน้า PaymentSuccessPage
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentSuccess()),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFF1A79), // Pink color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  elevation: 5,
                ),
                child: Text(
                  'ยืนยันการชำระเงิน',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
