import '../../const/export.dart';

import '../../const/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      child: Scaffold(
        body: orientation == Orientation.portrait
            ? _buildPortraitLayout(context, controller, screenWidth)
            : _buildLandscapeLayout(context, controller, screenWidth),
      ),
    );
  }

  // ===================== PORTRAIT LAYOUT =====================
  Widget _buildPortraitLayout(
      BuildContext context, OnboardingController controller, double screenWidth) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => CustomProgressIndicator(width: screenWidth * controller.getProgress())),
              const SizedBox(height: 40),
              Obx(() => SizedBox(
                width: 250,
                height: 250,
                child: CustomImageView(
                    imagePath: controller.images[controller.currentStep.value]),
              )),
            ],
          ),
        ),

        // Bottom section
        Expanded(
          flex: 4,
          child: _buildBottomSection(context, controller),
        ),
      ],
    );
  }

  // ===================== LANDSCAPE LAYOUT =====================
  Widget _buildLandscapeLayout(
      BuildContext context, OnboardingController controller, double screenWidth) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => CustomProgressIndicator(width: screenWidth * 0.4 * controller.getProgress())),
              const SizedBox(height: 20),
              Obx(() => SizedBox(
                width: 180,
                height: 180,
                child: CustomImageView(
                    imagePath: controller.images[controller.currentStep.value]),
              )),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: _buildBottomSection(context, controller),
        ),
      ],
    );
  }

  // ===================== BOTTOM SECTION =====================
  Widget _buildBottomSection(BuildContext context, OnboardingController controller) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Rotated orange background
        Positioned(
          left: -55,
          top: 0,
          child: Transform.rotate(
            angle: 84.329 * 3.14159 / 180,
            child: Container(
              width: 474,
              height: 771,
              decoration: const BoxDecoration(color: CustomColor.primary),
            ),
          ),
        ),

        // Dashed border
        Positioned(
          left: -51,
          top: 5,
          child: Transform.rotate(
            angle: 84.329 * 3.14159 / 180,
            child: CustomPaint(
              size: const Size(474, 744),
              painter: DashedBorderPainter(
                color: CustomColor.primary,
                strokeWidth: 5,
                dashWidth: 10,
                dashSpace: 6,
              ),
            ),
          ),
        ),

        // Foreground content
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              child: Obx(() => Text(
                controller.texts[controller.currentStep.value],
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: CustomColor.white,
                  height: 1.2,
                ),
              )),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() => CustomOnboardButton(
                isLoading: controller.isButtonLoading.value,
                width: double.infinity,
                height: 65,
                text: CustomText.continuar,
                onPressed: () async {
                  await controller.continueToNext();
                },
              )),
            ),
            const SizedBox(height: 20),
            Text(
              CustomText.desenvolvido,
              textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: CustomColor.white.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ===================== CUSTOM WIDGETS =====================

class CustomProgressIndicator extends StatelessWidget {
  final double width;

  const CustomProgressIndicator({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 10,
          decoration: BoxDecoration(
            color: CustomColor.pWhite,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Container(
          width: width,
          height: 10,
          decoration: BoxDecoration(
            color: CustomColor.primary,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ],
    );
  }
}




class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create a dashed path
    final dashPath = _createDashedPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double nextDash = distance + dashWidth;
        dest.addPath(metric.extractPath(distance, nextDash), Offset.zero);
        distance = nextDash + dashSpace;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace;
  }
}
