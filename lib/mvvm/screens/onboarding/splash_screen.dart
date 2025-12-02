import '../../const/export.dart';

// Define the content for each slide
class OnboardingSlideData {
  final String imagePath;
  final String title;

  const OnboardingSlideData({required this.imagePath, required this.title});
}

const List<OnboardingSlideData> slideData = [
  OnboardingSlideData(
    imagePath: CustomImage.onboarding1,
    title: CustomText.encontre,
  ),
  OnboardingSlideData(
    imagePath: CustomImage.onboarding2,
    title: CustomText.encontre2,
  ),
  OnboardingSlideData(
    imagePath: CustomImage.onboarding3,
    title: CustomText.encontre3,
  ),
  OnboardingSlideData(
    imagePath: CustomImage.onboarding4,
    title: CustomText.encontre4,
  ),
];

// --- END MOCK CONSTANTS ---

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Page controller to manage auto-sliding and page tracking
  late final PageController _pageController;
  int _currentPage = 0;
  final Duration _slideDuration = const Duration(seconds: 4);
  final Duration _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    Future.delayed(_slideDuration, () {
      if (!mounted) return;

      int nextPage = (_currentPage + 1) % slideData.length;

      _pageController
          .animateToPage(
            nextPage,
            duration: _animationDuration,
            curve: Curves.easeIn,
          )
          .then((_) {
            // Recursively call the function to continue the sliding cycle
            _startAutoSlide();
          });
    });
  }

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
                      _buildProgressBar(_currentPage / (slideData.length - 1)),
                      verticalSpace(screenHeight * 0.05),

                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: slideData.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemBuilder: (context, index) => SvgPicture.asset(
                                slideData[index].imagePath,
                                width: screenWidth * 0.6,
                                height: screenWidth * 0.6,
                                fit: BoxFit.contain,
                              ),
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
                    TextSeperated(title: slideData[_currentPage].title),

                    // ANGLED DASHED LINE OVER THE SHAPE
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 40, // only paint area where dash should be
                      child: CustomPaint(painter: SlantedDashedLinePainter()),
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
            child: Container(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Column(
      children: [
        verticalSpace(8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: CustomColor.borderGrey,
          valueColor: AlwaysStoppedAnimation<Color>(CustomColor.primary),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }
}

class TextSeperated extends StatelessWidget {
  const TextSeperated({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomCurveClipper(),
      child: Container(
        width: double.infinity,
        color: CustomColor.primary,
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

              PrimaryButton(
                text: CustomText.continueButton,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.welcome);
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

class BottomCurveClipper extends CustomClipper<Path> {
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

class SlantedDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 8.0;
    const dashSpace = 6.0;

    final paint = Paint()
      ..color = CustomColor.primary
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
