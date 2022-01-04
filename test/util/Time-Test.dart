import 'package:flutter_test/flutter_test.dart';
import 'package:future_contract/Resource/Timer-Helper.dart';
import 'package:future_contract/Resource/PrefManager.dart';
import 'package:future_contract/Resource/controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  group("Timer Test", () {
    DateTime currentTime = DateTime.now();

    /// Unit test 1

    test("Time Test Morning ", () {
      /// Unit test 1

      if (currentTime.hour < 12) {
        String timeDay = TimerHelper.greeting(currentTime);

        expect(timeDay, 'Good Morning');
      }
    });

    /// Unit test 2

    test("Time Test Afternoon ", () {
      if (currentTime.hour > 12 && currentTime.hour < 17) {
        String timeDay = TimerHelper.greeting(currentTime);

        expect(timeDay, "Good Afternoon");
      }
    });

    /// unit test 3

    test("test for auth change", () {
      final controller = StateChange();
      expect(controller.isOtpSend.value, false);
      Get.put(StateChange());
    });
  });
}
