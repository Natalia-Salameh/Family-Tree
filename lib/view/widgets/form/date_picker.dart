import 'package:flutter/cupertino.dart';

class DatePicker extends StatelessWidget {
  final void Function(DateTime) onDateTimeChanged;
  final CupertinoDatePickerMode mode;
  const DatePicker(
      {Key? key, required this.onDateTimeChanged, required this.mode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
          CupertinoDatePicker(onDateTimeChanged: onDateTimeChanged, mode: mode),
    );
  }
}
