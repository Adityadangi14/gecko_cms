import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class ConsoleLog {
  static StreamController<ConsoleData> consoleStream = StreamController();

  static void add({required LogType logType, required String data}) {
    consoleStream.add(ConsoleData.fromLogType(data, logType));
  }
}

enum LogType { error, message, success, inprogress }

class ConsoleData {
  Widget text;
  LogType logType;

  ConsoleData(this.logType, this.text);

  factory ConsoleData.fromLogType(String data, LogType logType) {
    switch (logType) {
      case LogType.error:
        return ConsoleData(
            logType,
            ReadMoreText(
              data,
              style: GoogleFonts.robotoMono(color: Colors.red),
            ));
      case LogType.message:
        return ConsoleData(
            logType,
            ReadMoreText(
              data,
              style: GoogleFonts.robotoMono(color: Colors.white),
            ));
      case LogType.success:
        return ConsoleData(
            logType,
            ReadMoreText(
              data,
              style: GoogleFonts.robotoMono(color: Colors.lightGreen),
            ));
      case LogType.inprogress:
        return ConsoleData(
            logType,
            ReadMoreText(
              data,
              style: GoogleFonts.robotoMono(color: Colors.yellow),
            ));

      default:
        return ConsoleData(
            logType,
            ReadMoreText(
              data,
              style: GoogleFonts.robotoMono(color: Colors.blue),
            ));
    }
  }
}
