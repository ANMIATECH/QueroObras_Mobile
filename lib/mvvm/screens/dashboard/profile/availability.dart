import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceProviderAvailability extends StatefulWidget {
  const ServiceProviderAvailability({super.key});

  @override
  State<ServiceProviderAvailability> createState() => _ServiceProviderAvailabilityState();
}

class _ServiceProviderAvailabilityState extends State<ServiceProviderAvailability> {
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 440),
          margin: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              // Header with back button and title
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 23),
                    const Text(
                      'Availability',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Josefin Sans',
                        height: 0.75,
                      ),
                    ),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(top: 65),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Availability toggle section
                      AvailabilityToggle(
                        isEnabled: isAvailable,
                        onToggle: (value) {
                          setState(() {
                            isAvailable = value;
                          });
                        },
                      ),

                      const SizedBox(height: 9),

                      // Last update text
                      const Text(
                        'Last update on Tuesday 12.5.2026',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                          height: 1.71,
                        ),
                      ),

                      const SizedBox(height: 9),

                      // Schedule list
                      Expanded(
                        child: Column(
                          children: [
                            // Monday (expandable)
                            ExpandableDaySchedule(
                              day: 'MONDAY',
                              startTime: '08am',
                              endTime: '08am',
                            ),

                            const SizedBox(height: 9),

                            // Other days
                            DayScheduleItem(
                              day: 'TUESDAY',
                              timeRange: '08am-9pm',
                            ),

                            const SizedBox(height: 9),

                            DayScheduleItem(
                              day: 'Wenesday',
                              timeRange: '08am-9pm',
                            ),

                            const SizedBox(height: 9),

                            DayScheduleItem(
                              day: 'Thursday',
                              timeRange: '08am-9pm',
                            ),

                            const SizedBox(height: 9),

                            DayScheduleItem(
                              day: 'Friday',
                              timeRange: '08am-9pm',
                            ),

                            const SizedBox(height: 9),

                            DayScheduleItem(
                              day: 'Saturday',
                              timeRange: '08am-9pm',
                            ),
                          ],
                        ),
                      ),

                      // Update button
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 40, bottom: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle update action
                            HapticFeedback.lightImpact();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF9761E),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Josefin Sans',
                              height: 1.71,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignalBarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Draw signal bars
    final bar1 = RRect.fromRectAndRadius(
      const Rect.fromLTWH(0, 8, 3, 7),
      const Radius.circular(1.5),
    );
    final bar2 = RRect.fromRectAndRadius(
      const Rect.fromLTWH(5, 6, 3, 9),
      const Radius.circular(1.5),
    );
    final bar3 = RRect.fromRectAndRadius(
      const Rect.fromLTWH(10, 3, 3, 12),
      const Radius.circular(1.5),
    );
    final bar4 = RRect.fromRectAndRadius(
      const Rect.fromLTWH(15, 0, 3, 15),
      const Radius.circular(1.5),
    );

    canvas.drawRRect(bar1, paint);
    canvas.drawRRect(bar2, paint);
    canvas.drawRRect(bar3, paint);
    canvas.drawRRect(bar4, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class WiFiIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final path = Path();

    // WiFi icon path
    path.moveTo(10, 3.06);
    path.cubicTo(12.71, 3.06, 15.33, 4.07, 17.3, 5.87);
    path.cubicTo(17.44, 6.01, 17.68, 6.01, 17.83, 5.87);
    path.lineTo(19.24, 4.49);
    path.cubicTo(19.32, 4.42, 19.36, 4.32, 19.36, 4.22);
    path.cubicTo(19.36, 4.12, 19.32, 4.02, 19.24, 3.95);
    path.cubicTo(14.07, -0.83, 5.92, -0.83, 0.76, 3.95);
    path.cubicTo(0.68, 4.02, 0.64, 4.12, 0.64, 4.22);
    path.cubicTo(0.64, 4.32, 0.68, 4.42, 0.75, 4.49);
    path.lineTo(2.17, 5.87);
    path.cubicTo(2.32, 6.01, 2.55, 6.01, 2.70, 5.87);
    path.cubicTo(4.67, 4.07, 7.28, 3.06, 10, 3.06);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BatteryIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.09;

    // Battery outline
    final batteryRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.55, 0.55, 22.1, 12.0),
      const Radius.circular(4.15),
    );
    canvas.drawRRect(batteryRect, paint);

    // Battery fill
    final fillPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final fillRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(1.64, 1.64, 20.3, 9.83),
      const Radius.circular(2.73),
    );
    canvas.drawRRect(fillRect, fillPaint);

    // Battery tip
    final tipPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final tipPath = Path();
    tipPath.moveTo(25.9, 5.22);
    tipPath.lineTo(25.9, 9.67);
    tipPath.cubicTo(26.77, 9.29, 27.35, 8.42, 27.35, 7.45);
    tipPath.cubicTo(27.35, 6.47, 26.77, 5.60, 25.9, 5.22);
    tipPath.close();

    canvas.drawPath(tipPath, tipPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AvailabilityToggle extends StatelessWidget {
  final bool isEnabled;
  final ValueChanged<bool> onToggle;

  const AvailabilityToggle({
    super.key,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 28, 17),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3EA),
        border: Border.all(
          color: const Color(0xFFFFE0C9),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 49,
              child: const Text(
                'Trigger the button to update your availability',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Josefin Sans',
                  height: 1.71,
                ),
              ),
            ),
          ),
          const SizedBox(width: 103),
          GestureDetector(
            onTap: () => onToggle(!isEnabled),
            child: Container(
              width: 66,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF16577F),
                borderRadius: BorderRadius.circular(75),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    left: isEnabled ? 38 : 4,
                    top: 4,
                    child: Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(75),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DayScheduleItem extends StatelessWidget {
  final String day;
  final String timeRange;

  const DayScheduleItem({
    super.key,
    required this.day,
    required this.timeRange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 57,
      padding: const EdgeInsets.fromLTRB(16, 16, 18, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3EA),
        border: Border.all(
          color: const Color(0xFFFFE0C9),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
              height: 1.5,
            ),
          ),
          Text(
            timeRange,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
              height: 1.71,
            ),
          ),
        ],
      ),
    );
  }
}


class ExpandableDaySchedule extends StatefulWidget {
  final String day;
  final String startTime;
  final String endTime;

  const ExpandableDaySchedule({
    super.key,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<ExpandableDaySchedule> createState() => _ExpandableDayScheduleState();
}

class _ExpandableDayScheduleState extends State<ExpandableDaySchedule> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3EA),
        border: Border.all(
          color: const Color(0xFFFFE0C9),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day header
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.day,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Josefin Sans',
                  height: 1.5,
                ),
              ),
            ),
          ),

          // Expanded content
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Column(
                children: [
                  // Start time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Start time',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                          height: 1.71,
                        ),
                      ),
                      Text(
                        widget.startTime,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                          height: 1.71,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // End time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'End time',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                          height: 1.71,
                        ),
                      ),
                      Text(
                        widget.endTime,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                          height: 1.71,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
