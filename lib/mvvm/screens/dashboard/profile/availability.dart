import '/mvvm/const/export.dart';

import '../../../controller/profile_controller.dart';


class ServiceProviderAvailability extends StatelessWidget {
  ServiceProviderAvailability({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    controller.getAvailability();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Disponibilidade',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// 🔥 AVAILABILITY TOGGLE
              AvailabilityToggle(
                isEnabled: controller.isAvailable.value,
                onToggle: controller.updateIsAvailability,
              ),

              const SizedBox(height: 20),

              /// 🔥 SCHEDULE LIST
              Expanded(
                child: ListView.builder(
                  itemCount: controller.availabilityList.length,
                  itemBuilder: (_, index) {
                    final item = controller.availabilityList[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: ExpandableDaySchedule(
                        day: item.dayPt?.toUpperCase() ?? "",
                        startTime: item.startTime ?? "--",
                        endTime: item.endTime ?? "--",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
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
