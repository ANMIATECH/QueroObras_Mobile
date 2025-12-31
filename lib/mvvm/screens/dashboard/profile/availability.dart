import '/mvvm/const/export.dart';

import '../../../controller/profile_controller.dart';

class ServiceProviderAvailabilityScreen extends StatelessWidget {
  ServiceProviderAvailabilityScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  Future<void> _pickTime(
      BuildContext context,
      AvailabilityUI day,
      bool isStart,
      ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Localizations.override(
          context: context,
          locale: const Locale('pt', 'BR'),
          child: child!,
        );
      },
    );

    if (picked != null) {
      isStart
          ? day.startTime.value = picked
          : day.endTime.value = picked;
    }
  }


  Widget _toggle(AvailabilityUI day) {
    return Obx(
          () => GestureDetector(
        onTap: () => day.isActive.toggle(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 26,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: day.isActive.value
                ? const Color(0xFF16577F) // ON color
                : const Color(0xFFBDBDBD), // OFF color (grey)
          ),
          child: Align(
            alignment: day.isActive.value
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dayCard(BuildContext context, AvailabilityUI day) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3EA),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFFFE0C9)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day.uiDay,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _toggle(day),
              ],
            ),
            if (day.isActive.value) ...[
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Horário de início',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () => _pickTime(context, day, true),
                    child: Text(
                      day.startTime.value == null
                          ? 'Selecionar'
                          : day.startTime.value!.format(context),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Horário de término',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () => _pickTime(context, day, false),
                    child: Text(
                      day.endTime.value == null
                          ? 'Selecionar'
                          : day.endTime.value!.format(context),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Disponibilidade'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: Get.back,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView(
                    children: controller.days
                        .map((d) => _dayCard(context, d))
                        .toList(),
                  ),
                ),
              ),
              Obx(
                () => CustomButton(
                  text: CustomText.update,
                  isLoading: controller.isLoading.value,
                  onPressed: () async {
                    await controller.updateDaysOfAvailabilityFromUI(
                      controller.days,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
