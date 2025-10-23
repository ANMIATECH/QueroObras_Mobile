import '../../const/export.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: CustomColor.white,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                      child: Text(
                        'Bem-vindo ao Quero Obras, sua melhor ferramenta para todas as necessidades do seu ciclo de vida.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF16577F),
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomImageView(
                      imagePath: CustomImage.welcomeLogo,
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 4,
                child: Stack(
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
                          decoration: const BoxDecoration(
                            color: CustomColor.sprimary,
                          ),
                        ),
                      ),
                    ),

                    // Dashed border (also rotated)
                    Positioned(
                      left: -51,
                      top: 5,
                      child: Transform.rotate(
                        angle: 84.329 * 3.14159 / 180,
                        child: CustomPaint(
                          size: const Size(474, 744),
                          painter: DashedBorderPainter(
                            color: CustomColor.sprimary,
                            strokeWidth: 5,
                            dashWidth: 10,
                            dashSpace: 6,
                          ),
                        ),
                      ),
                    ),

                    // Foreground content (upright)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 230),
                          child: Text(
                            CustomText.deslize,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.josefinSans(
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                              color: CustomColor.white,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // SlideButton replacing CustomButton
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: SlideButton(),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

class SlideButton extends StatelessWidget {
  const SlideButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = (screenWidth - 40).clamp(300.0, 400.0);

    return Container(
      width: buttonWidth,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          // Background text and arrows
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Começar',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF00258B).withOpacity(0.56),
                  ),
                ),
                const SizedBox(width: 20),
                CustomPaint(
                  size: const Size(29, 12),
                  painter: ArrowIconsPainter(),
                ),
              ],
            ),
          ),

          // Sliding button
          Obx(() {
            return Positioned(
              left: 7 + controller.dragPosition.value,
              top: 11,
              child: GestureDetector(
                onPanUpdate: (details) =>
                    controller.onPanUpdate(details, buttonWidth),
                onPanEnd: (_) => controller.onPanEnd(buttonWidth),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9761E),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.55),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Center(
                        child: CustomPaint(
                          size: const Size(30, 30),
                          painter: SendIconPainter(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// Arrow painter
class ArrowIconsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF16577F).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    paint.strokeWidth = 1.33333;
    Path path1 = Path();
    path1.moveTo(0.666748, 3);
    path1.lineTo(4.66675, 7);
    path1.lineTo(0.666748, 11);
    canvas.drawPath(path1, paint);

    paint.strokeWidth = 1.5;
    Path path2 = Path();
    path2.moveTo(10.6667, 2.5);
    path2.lineTo(15.1667, 7);
    path2.lineTo(10.6667, 11.5);
    canvas.drawPath(path2, paint);

    paint.strokeWidth = 2.0;
    Path path3 = Path();
    path3.moveTo(21.1667, 1);
    path3.lineTo(27.1667, 7);
    path3.lineTo(21.1667, 13);
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Send icon painter
class SendIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final path = Path();
    path.moveTo(centerX - 8, centerY - 6);
    path.lineTo(centerX + 8, centerY);
    path.lineTo(centerX - 8, centerY + 6);
    path.lineTo(centerX - 4, centerY);
    path.close();
    canvas.drawPath(path, paint);

    final detailPaint = Paint()
      ..color = Colors.white.withOpacity(0.55)
      ..style = PaintingStyle.fill;

    final detailPath = Path();
    detailPath.moveTo(centerX - 6, centerY - 4);
    detailPath.lineTo(centerX + 6, centerY);
    detailPath.lineTo(centerX - 6, centerY + 4);
    detailPath.lineTo(centerX - 2, centerY);
    detailPath.close();
    canvas.drawPath(detailPath, detailPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}





