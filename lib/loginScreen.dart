import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_new/bottom_navber.dart';
import 'package:project_new/regScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  // Function สำหรับการเข้าสู่ระบบ
  Future<void> login() async {
  setState(() {
    _isLoading = true;
  });

  // ตรวจสอบว่าอีเมลและรหัสผ่านถูกกรอกหรือไม่
  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill in both email and password")),
    );
    setState(() {
      _isLoading = false;
    });
    return; // หยุดการทำงานถ้ากรอกข้อมูลไม่ครบ
  }
// http://127.0.0.1/
// 172.18.121.190:5000
   final String apiUrl = "http://192.168.144.137:5000/login";
  try {
    final response = await http.post(
  Uri.parse(apiUrl),
  headers: {"Content-Type": "application/json"},
  body: jsonEncode({
    "email": _emailController.text.trim(),
    "password": _passwordController.text,
  }),
);

     // พิมพ์ข้อมูล Response เพื่อดูใน Terminal
  print("Response Status Code: ${response.statusCode}");
  print("Response Body: ${response.body}");

   if (response.statusCode == 200) {
  final data = json.decode(response.body);
  print("Parsed Data: $data");

  if (data['role'] == "user") {
    String firstName = data['first_name'] ?? "User"; // Handle null values
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Welcome, $firstName")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavbar()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: Invalid role.")),
    );
  }
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Error: ${response.statusCode}")),
  );
}

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: Unable to connect to the server")),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}
//   final String apiUrl = "http://172.18.114.161/LoveProject/login.php"; // URL ไฟล์ PHP
//   try {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       body: {
//         "email": _emailController.text,
//         "password": _passwordController.text,
//       },
//     );

//     final data = json.decode(response.body);
// print("Response Body: ${response.body}");
//     if (data['status'] == "success") {
//       // หากเข้าสู่ระบบสำเร็จ
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Welcome, ${data['data']['first_name']}")),
//       );
//       print("Login Successful: ${data['data']}");

//       // เปลี่ยนหน้าไปยัง BottomNavBar
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => BottomNavbar()), // เปลี่ยนเป็นหน้าของคุณ
//       );
//     } else {
//       // หากเกิดข้อผิดพลาด
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(data['message'])),
//       );
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error: Unable to connect to the server")),
//     );
//   } finally {
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 103, 102, 175),
                  Color.fromARGB(255, 158, 221, 232),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 22),
              child: const Text(
                'Hello\nSign in!',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      offset: Offset(2, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Main Login Container
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Email Input Field
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        suffixIcon: Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 157, 23, 184),
                        ),
                      ),
                      cursorColor: const Color.fromARGB(255, 157, 23, 184),
                    ),
                    const SizedBox(height: 20),
                    // Password Input Field
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Color.fromARGB(255, 157, 23, 184),
                        ),
                      ),
                      cursorColor: const Color.fromARGB(255, 157, 23, 184),
                    ),
                    const SizedBox(height: 20),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xff281537),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Sign In Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : login,
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 164, 60, 244),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 100),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    const SizedBox(height: 50),
                    // Sign Up Option
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegScreen()),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
