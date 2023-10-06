// ignore_for_file: library_prefixes, avoid_print
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:neumedira_farhan_test/app/data/models/message_model.dart';
import 'package:neumedira_farhan_test/app/data/models/message_resp.dart';
import 'package:neumedira_farhan_test/app/helper/helper_storage.dart';
import 'package:neumedira_farhan_test/app/network/dio.dart';
import 'package:neumedira_farhan_test/app/routes/app_pages.dart';
import 'package:neumedira_farhan_test/app/utils/const.dart';
import 'package:neumedira_farhan_test/app/utils/custom_widget.dart';
import 'package:neumedira_farhan_test/generated/assets.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeController extends GetxController {
  final dio = MyDio().dio;
  RxString username = ''.obs;
  late IO.Socket socket;
  final TextEditingController messageInputController = TextEditingController();
  RxList<Message> messages = <Message>[].obs;
  final ScrollController scrollController = ScrollController();

  @override
  @override
  void onInit() {
    super.onInit();
    username.value = HelperStorage().getUsername ?? Get.arguments['name'];
    socket = IO.io(
      "$baseUrl:3000",
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'username': username.value}).build(),
    );
    getMessage();
    connectSocket(username.value);
  }

  getMessage() async {
    try {
      final response = await dio.get(
        '/message/all',
      );
      final messageResp =
          MessageResp.fromJson(response.data as Map<String, dynamic>);
      messages.assignAll(messageResp.result);
      Future.delayed(const Duration(milliseconds: 500), () {
        scrollToBottom();
      });
    } catch (e, stakeholder) {
      if (kDebugMode) {
        print(e);
        print(stakeholder);
      }
    }
  }

  sendMessage() {
    print("ini username yang dipakai di sendMessage : ${username.value}");
    socket.emit('message', {
      'message': messageInputController.text.trim(),
      'sender': username.value
    });
    messageInputController.clear();
    Future.delayed(const Duration(seconds: 2), () {
      scrollToBottom();
    });
  }

  connectSocket(String newUsername) {
    print("ini username yang dipakai di connectSocket : $newUsername");
    socket.onConnect((data) {
      HelperStorage().setUsername = newUsername;
      HelperStorage().getUsername != null
          ? print('berhasil tersimpan')
          : print('gagal tersimpan');
      print('Terhubung');
    });
    socket.onConnectError((data) => print('Gagal Terhubung: $data'));
    socket.onDisconnect((data) => print('Socket.IO server terputus'));
    socket.on('message', (data) {
      messages.add(Message.fromJson(data));
      Future.delayed(const Duration(milliseconds: 500), () {
        scrollToBottom();
      });
    });
  }

  scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialogPopUp(
            titleModal: 'Konfirmasi Logout',
            leftButtonText: 'Nanti',
            rightButtonText: 'Keluar',
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: LottieBuilder.asset(Assets.lottieLogout),
                ),
                const SizedBox(
                  height: 16,
                ),
                const CustomText(text: 'Yakin ingin keluar?')
              ],
            ))).then((confirmed) {
      if (confirmed && confirmed != null) {
        removeUsername();
        Get.delete<HomeController>();
        Get.offNamed(Routes.register);
      }
    });
  }

  removeUsername() {
    HelperStorage().remove('username');
    HelperStorage().getUsername == null
        ? print('berhasil dihapus')
        : print('gagal dihapus');
  }
}
