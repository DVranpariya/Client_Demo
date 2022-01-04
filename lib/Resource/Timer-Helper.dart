class TimerHelper {
  static String greeting(DateTime timeNow) {
    // var timeNow = DateTime.now().hour;

    if (timeNow.hour < 12) {
      return 'Good Morning';
    } else if (timeNow.hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
