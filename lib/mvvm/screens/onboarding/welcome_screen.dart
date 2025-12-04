import '../../const/export.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              // TOP CONTENT
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      verticalSpace(screenHeight * 0.05),

                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  CustomText.bemVindo,
                                  textAlign: TextAlign.center,
                                  style: CustomFontStyle.developedByStyle(
                                    context,
                                  ).copyWith(color: CustomColor.primaryBlue),
                                ),
                                OnboardingIllustration(
                                  imagePath: CustomImage.welcomeLogo,
                                  screenWidth: screenWidth,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // BOTTOM CURVED SECTION
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    TextSeperatedTwo(title: CustomText.deslizeO),

                    // ANGLED DASHED LINE OVER THE SHAPE
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 40, // only paint area where dash should be
                      child: CustomPaint(
                        painter: SlantedDashedLinePainterTwo(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // STATUS BAR PLACEHOLDER
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 44,
            child: Container(color: CustomColor.white),
          ),
        ],
      ),
    );
  }
}

class TextSeperatedTwo extends StatelessWidget {
  const TextSeperatedTwo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomCurveClipperTwo(),
      child: Container(
        width: double.infinity,
        color: CustomColor.primaryBlue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: CustomFontStyle.onboardingHeading(context),
              ),
              const SizedBox(height: 32),

              // 🚀 REPLACED PRIMARY BUTTON WITH SlideToConfirm 🚀
              ConfirmationSlider(
                // The widget to display inside the slider
                text: CustomText.comecar,

                textStyle: CustomFontStyle.developedByStyle(context).copyWith(
                  color: CustomColor.primaryBlueSlide.withValues(alpha: 0.56),
                ),
                // The color of the slider's track (the blue part)
                backgroundColor: CustomColor.white,
                // The color of the slider's background when confirmed
                foregroundColor: CustomColor.primary,
                // The color of the slider's icon (the orange part)
                iconColor: CustomColor.white,

                height: 60,

                onConfirmation: () {
                                    Navigator.of(context).pushNamed(AppRoutes.cpfBottomNav);

                },
              ),

              const SizedBox(height: 16),

              Text(
                CustomText.developedBy,
                style: CustomFontStyle.developedByStyle(
                  context,
                ).copyWith(color: CustomColor.white.withValues(alpha: 0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomCurveClipperTwo extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Top-left lower
    path.moveTo(0, 40);

    // Top-right higher
    path.lineTo(size.width, 18);

    // Down & around
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class SlantedDashedLinePainterTwo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 8.0;
    const dashSpace = 6.0;

    final paint = Paint()
      ..color = CustomColor.primaryBlue
      ..strokeWidth = 2;

    // Start + end = MUST match the clipper curve
    const double yLeft = 28;
    const double yRight = 10;

    final double dx = size.width;
    final double dy = yRight - yLeft;
    final double lineLength = sqrt(dx * dx + dy * dy);

    final double angle = atan2(dy, dx);

    double distance = 0;

    while (distance < lineLength) {
      final double x1 = distance * cos(angle);
      final double y1 = yLeft + distance * sin(angle);

      final double x2 = (distance + dashWidth) * cos(angle);
      final double y2 = yLeft + (distance + dashWidth) * sin(angle);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);

      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
