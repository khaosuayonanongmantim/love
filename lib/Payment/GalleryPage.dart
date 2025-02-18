import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  // ฟังก์ชันเลือกภาพ (กล้องหรือแกลเลอรี)
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  // แสดงป๊อปอัปให้ผู้ใช้เลือกว่าจะใช้กล้องหรือแกลเลอรี
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("เลือกรูปจากแกลเลอรี"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ไฟล์รูปภาพ"),
        backgroundColor: const Color.fromARGB(255, 238, 98, 215),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 208, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // ✅ ปุ่มจะอยู่บนสุด
          children: [
            ElevatedButton(
              onPressed: _showImagePickerOptions,
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 68, 146)),
              child: const Text('ดูไฟล์รูปภาพที่บันทึกไว้', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20), // ✅ เพิ่มระยะห่างระหว่างปุ่มกับรูป
            Expanded(
              child: selectedImage != null
                  ? Column(
                      children: [
                        Image.file(selectedImage!, width: 350, height: 400, fit: BoxFit.cover),
                        const SizedBox(height: 10),
                       
                      ],
                    )
                  : const Center(
                      child: Text("", style: TextStyle(color: Colors.red, fontSize: 16)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
