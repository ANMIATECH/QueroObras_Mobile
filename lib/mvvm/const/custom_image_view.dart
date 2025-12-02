// ignore_for_file: must_be_immutable

import '../const/export.dart';

class CustomImageView extends StatelessWidget {
  CustomImageView({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/Image_not_found.png',
  });

  ///[imagePath] is required parameter for showing image
  String? imagePath;

  double? height;

  double? width;

  Color? color;

  BoxFit? fit;

  final String placeHolder;

  Alignment? alignment;

  VoidCallback? onTap;

  EdgeInsetsGeometry? margin;

  BorderRadius? radius;

  BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget())
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color: Colors.transparent, // avoid unwanted background color

        child: InkWell(onTap: onTap, child: _buildCircleImage()),
      ),
    );
  }

  ///build the image with border radius
  dynamic _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(border: border, borderRadius: radius),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      final type = imagePath!.imageType;
      switch (type) {
        case ImageType.svg:
          if (imagePath!.startsWith('http')) {
            return SvgPicture.network(
              imagePath!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              placeholderBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
            );
          } else {
            return SvgPicture.asset(
              imagePath!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
            );
          }
        case ImageType.file:
          return Image.file(
            File(imagePath!),
            height: height,
            width: width,
            fit: fit,
          );
        case ImageType.network:
          return CachedNetworkImage(
            imageUrl: imagePath!,
            height: height,
            width: width,
            fit: fit,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => Image.asset(
              placeHolder,
              height: height,
              width: width,
              fit: fit,
            ),
          );
        case ImageType.png:
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit,
          );
      }
    }
    return const SizedBox();
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }

class CustomImageViewTwo extends StatelessWidget {
  ///[imagePath] is required parameter for showing image
  String? imagePath;

  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomImageViewTwo({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/image_not_found.png',
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget())
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(onTap: onTap, child: _buildCircleImage()),
    );
  }

  ///build the image with border radius
  dynamic _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(border: border, borderRadius: radius),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    return Image.file(
      File(imagePath!),
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      color: color,
    );
  }
}

class CustomImageViewProfile extends StatelessWidget {
  ///[imagePath] is required parameter for showing image
  String? imagePath;

  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomImageViewProfile({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/image_not_found.png',
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget())
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(onTap: onTap, child: _buildCircleImage()),
    );
  }

  ///build the image with border radius
  dynamic _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  Widget _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(border: border, borderRadius: radius),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: fit,
      imageUrl: imagePath!,
      color: color,
      // placeholder: (context, url) => SizedBox(
      //   height: 30,
      //   width: 30,
      //   child: LinearProgressIndicator(
      //     color: Colors.grey.shade200,
      //     backgroundColor: Colors.grey.shade100,
      //   ),
      // ),
      errorWidget: (context, url, error) => Image.asset(
        "https://pbs.twimg.com/media/D8dDZukXUAAXLdY.jpg",
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}

class CustomOnboardButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomOnboardButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white, // Button background
          borderRadius: BorderRadius.circular(217.391),
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: isLoading ? 0.5 : 1.0,
            duration: const Duration(milliseconds: 600),
            child: Text(
              isLoading ? 'Carregando...' : text,
              style: GoogleFonts.josefinSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF16577F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String text;
  final bool isLoading;
  final bool isActive; // NEW
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isActive = true, // default active
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isLoading) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant CustomButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLoading && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isLoading && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool disabled = !widget.isActive;

    return GestureDetector(
      onTap: (disabled || widget.isLoading) ? null : widget.onPressed,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          // 🔥 logic: keep primary while loading
          color: widget.isLoading
              ? CustomColor.primary
              : disabled
              ? Colors.grey
              : CustomColor.primary,
          borderRadius: BorderRadius.circular(217.391),
        ),
        child: Center(
          child: widget.isLoading
              ? FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Loading...',
                    style: GoogleFonts.josefinSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                )
              : Text(
                  widget.text,
                  style: GoogleFonts.josefinSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

// Mock for CustomFontStyle and PrimaryButton
class CustomFontStyle {
  static TextStyle onboardingHeading(BuildContext context) {
    return TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: CustomColor.white, // Text color is white in the orange section
    );
  }

  static TextStyle developedByStyle(BuildContext context) {
    return TextStyle(color: CustomColor.white, fontSize: 12);
  }

  static TextStyle heading(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineSmall!
      .copyWith(color: CustomColor.textBlack, fontWeight: FontWeight.bold);
  static TextStyle body(BuildContext context) => Theme.of(
    context,
  ).textTheme.bodyMedium!.copyWith(color: CustomColor.textBlack);
  static TextStyle primaryTitle(BuildContext context) => Theme.of(context)
      .textTheme
      .titleMedium!
      .copyWith(color: CustomColor.primary, fontWeight: FontWeight.w600);
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;
  final Color bgActive;
  final Color textColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.bgActive = CustomColor.white,
    this.textColor = CustomColor.primaryBlue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: isSecondary
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: CustomColor.primary, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: CustomColor.primary),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: bgActive, // Filled button is white
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 0,
              ),
              child: Text(
                text,
                style: CustomFontStyle.developedByStyle(
                  context,
                ).copyWith(color: textColor),
              ),
            ),
    );
  }
}

// Mock for flutter_screenutil height spacing
Widget verticalSpace(double height) => SizedBox(height: height);
Widget horizontalSpace(double width) => SizedBox(width: width);

// --- END MOCK CONSTANTS ---

// Assuming CustomColor and other constants are defined elsewhere

class OnboardingIllustration extends StatelessWidget {
  final String imagePath;
  final double screenWidth;
  final VoidCallback?
  onTap; // Added extension: A callback for tapping the image

  const OnboardingIllustration({
    super.key,
    required this.imagePath,
    required this.screenWidth,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // You can extend functionality here, for example, by adding a gesture detector
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          // Use a calculated size for responsiveness (60% of screen width)
          // width: screenWidth * 0.6,
          // height: screenWidth * 0.6,
          // Use your provided placeholder for errors
          errorBuilder: (context, error, stackTrace) =>
              _buildImagePlaceholder(context),
        ),
      ),
    );
  }

  // Helper method for the placeholder visual (moved inside the new widget)
  Widget _buildImagePlaceholder(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 280,
            height: 200,
            decoration: BoxDecoration(
              // Assuming CustomColor has a definition for 'grey' and 'withValues'
              color: CustomColor.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          // Note: Changed CustomColor.primary to CustomColor.primaryOrange
          const Icon(Icons.build, size: 80, color: CustomColor.primary),
        ],
      ),
    );
  }
}

class OnboardingIllustrationSVG extends StatelessWidget {
  final String imagePath;
  final double screenWidth;
  final VoidCallback? onTap;

  const OnboardingIllustrationSVG({
    super.key,
    required this.imagePath,
    required this.screenWidth,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          // --- 💡 KEY CHANGE: Use SvgPicture.asset for SVG files ---
          child: SvgPicture.asset(
            imagePath,
            fit: BoxFit.contain,
            // Use a calculated size for responsiveness (60% of screen width)
            width: screenWidth * 0.6,
            height: screenWidth * 0.6,
            // SvgPicture.asset uses a builder for errors, not errorBuilder
            placeholderBuilder: (context) => _buildImagePlaceholder(context),
          ),
        ),
      ),
    );
  }

  // Helper method for the placeholder visual
  Widget _buildImagePlaceholder(BuildContext context) {
    return Container(
      // Ensure the placeholder also uses the same responsive sizing
      width: screenWidth * 0.6,
      height: screenWidth * 0.6,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width:
                screenWidth * 0.5, // Slightly smaller than the main container
            height: screenWidth * 0.35,
            decoration: BoxDecoration(
              color: CustomColor.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          // const Icon(Icons.build, size: 80, color: CustomColor.primary),
        ],
      ),
    );
  }
}
