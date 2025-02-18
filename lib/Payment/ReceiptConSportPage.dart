import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:project_new/navbar/home.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReceiptConSportPage extends StatefulWidget {
  final String concertName;
  final String date;
  final String time;
  final String location;
  final String zoneName;
  final List<String> selectedSeats;
  final double totalPrice;
  final double vatAmount;
  final double serviceFee;

  const ReceiptConSportPage({
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
  }) : super(key: key);

  @override
  _ReceiptConSportPageState createState() => _ReceiptConSportPageState();
}

class _ReceiptConSportPageState extends State<ReceiptConSportPage> {
  ScreenshotController screenshotController = ScreenshotController(); // ✅ ใช้ ScreenshotController แทน RepaintBoundary

  /// 📌 ฟังก์ชันจับภาพใบเสร็จและบันทึกลงแกลเลอรี
  Future<void> _saveScreenshot() async {
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      Fluttertoast.showToast(msg: "❌ กรุณาให้สิทธิ์เข้าถึงพื้นที่จัดเก็บไฟล์");
      return;
    }

    try {
      await Future.delayed(const Duration(milliseconds: 500)); // ✅ รอ UI โหลดเสร็จ
      screenshotController.capture(pixelRatio: 3.0).then((Uint8List? image) async {
        if (image != null) {
          final result = await ImageGallerySaver.saveImage(image);
          if (result['isSuccess']) {
            Fluttertoast.showToast(msg: "✅ บันทึกภาพสำเร็จ 🎉");
          } else {
            Fluttertoast.showToast(msg: "❌ บันทึกภาพล้มเหลว");
          }
        } else {
          Fluttertoast.showToast(msg: "⚠️ ไม่สามารถจับภาพได้");
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "เกิดข้อผิดพลาด: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ใบเสร็จ', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '🎉 ชำระเงินสำเร็จแล้ว 🎉',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const SizedBox(height: 10),
                        Text('คอนเสิร์ต : ${widget.concertName}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                        buildReceiptRow('วันที่:', widget.date),
                        buildReceiptRow('เวลา:', widget.time),
                        buildReceiptRow('สถานที่:', widget.location),
                        buildReceiptRow('โซนที่เลือก:', widget.zoneName),
                        buildReceiptRow('ที่นั่งที่เลือก:', widget.selectedSeats.join(', '), color: Colors.pink),
                        const Divider(color: Colors.grey, thickness: 1),
                        buildReceiptRow('VAT:', '฿${widget.vatAmount.toStringAsFixed(2)}', color: Colors.green),
                        buildReceiptRow('ค่าธรรมเนียม:', '฿${widget.serviceFee.toStringAsFixed(2)}', color: Colors.green),
                        const Divider(color: Colors.grey, thickness: 1),
                        buildReceiptRow('ราคารวม:', '฿${widget.totalPrice.toStringAsFixed(2)}',
                            color: Colors.red, boldValue: true),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _saveScreenshot,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text(
              '📷 บันทึกภาพใบเสร็จ',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              'กลับไปหน้าหลัก',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// 📌 ฟังก์ชันสร้างแถวข้อมูลใบเสร็จ
  Widget buildReceiptRow(String label, String value, {Color? color, bool boldValue = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: boldValue ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
