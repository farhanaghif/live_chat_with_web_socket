// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:neumedira_farhan_test/generated/assets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '# general',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black),
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                controller.logout(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.logout_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.group,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Obx(() => ListView.separated(
                      controller: controller.scrollController,
                      itemCount: controller.messages.isEmpty
                          ? 1
                          : controller.messages.length,
                      padding: const EdgeInsets.all(16),
                      separatorBuilder: (_, index) => const SizedBox(
                        height: 5,
                      ),
                      itemBuilder: (context, index) {
                        if (controller.messages.isNotEmpty) {
                          final message = controller.messages[index];
                          return message.senderUsername ==
                                  controller.username.value
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ChatBubble(
                                      clipper: ChatBubbleClipper1(
                                          type: BubbleType.sendBubble),
                                      alignment: Alignment.topRight,
                                      margin: const EdgeInsets.only(top: 20),
                                      backGroundColor: Colors.blue,
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.71,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              message.message,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  DateFormat('hh:mm a')
                                                      .format(message.sentAt),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CircleAvatar(
                                          backgroundColor: Colors.grey.shade400,
                                          backgroundImage: NetworkImage(
                                              'https://robohash.org/${message.senderUsername}')),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CircleAvatar(
                                          backgroundColor: Colors.grey.shade400,
                                          backgroundImage: NetworkImage(
                                              'https://robohash.org/${message.senderUsername}')),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ChatBubble(
                                      clipper: ChatBubbleClipper1(
                                          type: BubbleType.receiverBubble),
                                      backGroundColor: const Color(0xffE7E7ED),
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                message.senderUsername,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                message.message,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    DateFormat('hh:mm a')
                                                        .format(message.sentAt),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade800,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LottieBuilder.asset(Assets.lottieLetsChat),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Hai ${controller.username.value}, Belum ada riwayat chat. Ayo mulai chat!",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ))),
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.messageInputController,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Ketik Pesan Disini',
                          hintMaxLines: 1,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 0.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.black26,
                              width: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: InkWell(
                        child: const Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 24,
                        ),
                        onTap: () {
                          if (controller.messageInputController.text
                              .trim()
                              .isNotEmpty) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.sendMessage();
                            controller.scrollToBottom();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
