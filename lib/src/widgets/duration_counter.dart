import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'digits.dart';

class DurationCounter extends StatefulWidget {
  const DurationCounter(this.scheduledDate, {super.key});

  final DateTime scheduledDate;

  @override
  State<DurationCounter> createState() => _DurationCounterState();
}

class _DurationCounterState extends State<DurationCounter> with SingleTickerProviderStateMixin {
  late Ticker _ticker;

  bool _isDone = false;
  String _durationStr = '';

  @override
  void initState() {
    super.initState();

    _ticker = createTicker((elapsed) {
      setState(() {
        final Duration duration = widget.scheduledDate.difference(DateTime.now());

        // 0をカウントしない
        int t = duration.inSeconds + 1;

        if (t < 1) {
          _isDone = true;

          _ticker.stop();
        } else {
          String durationStr;

          // 秒
          {
            final ss = '${t % 60}'.padLeft(2, '0');

            t = (t / 60).floor();
            durationStr = ss;
          }

          // 分
          if (0 < t) {
            final mm = '${t % 60}'.padLeft(2, '0');

            t = (t / 60).floor();
            durationStr = '$mm:$durationStr';

            // 時
            if (0 < t) {
              final hH = '${t % 24}'.padLeft(2, '0');

              t = (t / 24).floor();
              durationStr = '$hH:$durationStr'.padLeft(2, '0');

              // 日
              if (0 < t) {
                durationStr = '$t $durationStr';
              }
            }
          }

          _durationStr = durationStr;
        }
      });
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isDone
        ? const Text(
            'Time is up!',
            style: TextStyle(color: Colors.red),
          )
        : Digits(_durationStr, charWidth: 8);
  }
}
