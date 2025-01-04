import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/screens/login/otp_screen.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Image.asset(
              'assets/images/login.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 50),
            const Text(
              'OTP Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 5),
            const Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: "We will send you an ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: "One Time Password ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "on this mobile number",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Mobile Number is...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 55,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      // controller: countryController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Text(
                    "|",
                    style: TextStyle(fontSize: 33, color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: CustomFilledButton(
                text: 'Get OTP',
                onPressed: () => Get.to(() => const OTPScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
