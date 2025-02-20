import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {


  const ImagePickerScreen({
    Key? key,
  }) : super(key: key);

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
              leading: const Icon(Icons.camera_alt),
              title: const Text("ถ่ายรูป"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
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
      appBar: AppBar(title: const Text("แนบไฟล์รูป")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _showImagePickerOptions,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: const Text('แนบไฟล์รูป', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            selectedImage != null
                ? Column(
                    children: [
                      Image.file(selectedImage!, width: 150, height: 150, fit: BoxFit.cover),
                      const SizedBox(height: 10),
                      const Text("อัพโหลดสำเร็จ!", style: TextStyle(color: Colors.green)),
                    ],
                  )
                : const Text("ยังไม่ได้เลือกไฟล์", style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
