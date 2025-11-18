import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceProviderAvailability extends StatefulWidget {
  const ServiceProviderAvailability({super.key});

  @override
  State<ServiceProviderAvailability> createState() =>
      _ServiceProviderAvailabilityState();
}

class _ServiceProviderAvailabilityState
    extends State<ServiceProviderAvailability> {
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
          ),
          title: const Text(
            'Disponibilidade', // 🇧🇷
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
              height: 0.75,
            ),
          ),
          centerTitle: false,
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 440),
          margin: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [

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
                        'Última atualização na terça-feira 12/05/2026', // 🇧🇷
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
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            ExpandableDaySchedule(
                              day: 'SEGUNDA-FEIRA',
                              startTime: '08h',
                              endTime: '08h',
                            ),
                            const SizedBox(height: 9),

                            const DayScheduleItem(day: 'TERÇA-FEIRA', timeRange: '08h-21h'),
                            const SizedBox(height: 9),

                            const DayScheduleItem(day: 'QUARTA-FEIRA', timeRange: '08h-21h'),
                            const SizedBox(height: 9),

                            const DayScheduleItem(day: 'QUINTA-FEIRA', timeRange: '08h-21h'),
                            const SizedBox(height: 9),

                            const DayScheduleItem(day: 'SEXTA-FEIRA', timeRange: '08h-21h'),
                            const SizedBox(height: 9),

                            const DayScheduleItem(day: 'SÁBADO', timeRange: '08h-21h'),
                          ],
                        ),
                      ),

                      // Update button
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 40, bottom: 20),
                        child: ElevatedButton(
                          onPressed: () {
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
                            'Atualizar', // 🇧🇷
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
                'Ative o botão para atualizar sua disponibilidade',
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
