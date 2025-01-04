import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shoppy/controller/auth_controller.dart';
import 'package:shoppy/view/widgets/custom_button_widget.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

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
            Text(
              "OTP Verification",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 10),
            const Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: "Enter the OTP sent to ",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: '123456789',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Pinput(
              length: 6,
              showCursor: true,
              controller: authController.otpController,
              keyboardType: TextInputType.number,
              onSubmitted: (value) async {
                authController.countryController.text = value;
                await authController.verifyOtp();
              },
              onCompleted: (pin) => log(pin),
            ),
            const SizedBox(height: 30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       "Dont recive the OTP?",
            //       style: TextStyle(
            //         color: Colors.grey,
            //         fontSize: 14,
            //       ),
            //     ),
            //     const SizedBox(width: 5),
            //     TextButton(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(
            //         foregroundColor: Colors.orange,
            //       ),
            //       child: const Text(
            //         "Resend OTP",
            //         style: TextStyle(
            //           color: Colors.orange,
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            SizedBox(
              width: double.infinity,
              child: CustomFilledButton(
                text: "VERIFY & PROCEED",
                onPressed: () async {
                  await authController.verifyOtp();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
