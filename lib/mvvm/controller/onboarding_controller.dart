import '../const/export.dart';

class OnboardingController extends GetxController {
  RxInt currentStep = 0.obs;
  RxBool isButtonLoading = false.obs; // Add this for button loading
  late Timer _timer;

  final List<String> images = [
    CustomImage.onboarding1,
    CustomImage.onboarding2,
    CustomImage.onboarding3,
    CustomImage.onboarding4,
  ];

  final List<String> texts = [
    CustomText.encontre,
    CustomText.encontre2,
    CustomText.encontre3,
    CustomText.encontre4,
  ];

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      currentStep.value = (currentStep.value + 1) % images.length;
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  double getProgress() => (currentStep.value + 1) / images.length;

  Future<void> continueToNext() async {
    isButtonLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // simulate loading
    isButtonLoading.value = false;
    Get.offAllNamed(RouteNameV1.welcome);
  }

  var dragPosition = 0.0.obs;
  var isCompleted = false.obs;

  void onPanUpdate(DragUpdateDetails details, double maxWidth) {
    dragPosition.value += details.delta.dx;
    dragPosition.value = dragPosition.value.clamp(0.0, maxWidth - 64);
  }

  void onPanEnd(double maxWidth) {
    if (dragPosition.value > maxWidth * 0.7) {
      dragPosition.value = maxWidth - 64;
      isCompleted.value = true;

      // Perform action after completion
      Future.delayed(const Duration(milliseconds: 500), () {
        print('Slide completed!');
        // Example: navigate to next screen
        Get.offAllNamed(RouteNameV1.bottomNav);
      });
    } else {
      dragPosition.value = 0.0;
    }
  }
}
