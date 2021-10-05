class Helper {
  bool convertIntToBool(int a) {
    if (a == 1) return true;
    return false;
  }

  int convertBoolToInt(bool a) {
    if (a == true) return 1;
    return 0;
  }
  // int convertDateTimeToDays(DateTime from dateTime to){
  //   DateTime.now()
  // }

  int daysBetween(String toString) {
    DateTime to = DateTime.parse(toString);
    // from = DateTime.now();
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(DateTime.now()).inHours / 24).round();
  }
}

