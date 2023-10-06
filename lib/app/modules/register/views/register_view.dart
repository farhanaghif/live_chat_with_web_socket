import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:neumedira_farhan_test/generated/assets.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(Assets.lottiePeopleChat),
              const Text(
                "Get started global chat!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Masukkan Nama Anda',
                  ),
                  controller: controller.usernameController,
                ),
              ),
              Obx(() => controller.hasError.value
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 60, top: 8),
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    )
                  : Container()),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Mulai Chat Sekarang'.toUpperCase()),
                  onPressed: () {
                    controller.startChat();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
