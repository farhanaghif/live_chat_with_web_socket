import 'package:get/get.dart';
import 'package:neumedira_farhan_test/app/helper/helper_storage.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final initial =
      HelperStorage().getUsername == null ? Routes.register : Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
  ];
}
