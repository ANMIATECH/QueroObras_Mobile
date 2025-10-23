import 'package:queroobras_mobile/mvvm/const/export.dart';

class ResponsiveValues {
  static double getResponsiveValue({
    required BuildContext context,
    required double defaultValue,
    double? minValue,
    double? maxValue,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    const baseWidth = 480.0; // Design base width

    double scaleFactor = screenWidth / baseWidth;
    double responsiveValue = defaultValue * scaleFactor;

    if (minValue != null && responsiveValue < minValue) {
      return minValue;
    }
    if (maxValue != null && responsiveValue > maxValue) {
      return maxValue;
    }

    return responsiveValue;
  }

  static double getResponsiveFontSize(BuildContext context, double fontSize) {
    return getResponsiveValue(
      context: context,
      defaultValue: fontSize,
      minValue: fontSize * 0.8,
      maxValue: fontSize * 1.2,
    );
  }

  static EdgeInsets getResponsivePadding(
      BuildContext context, EdgeInsets padding) {
    return EdgeInsets.only(
      left: getResponsiveValue(context: context, defaultValue: padding.left),
      top: getResponsiveValue(context: context, defaultValue: padding.top),
      right: getResponsiveValue(context: context, defaultValue: padding.right),
      bottom:
          getResponsiveValue(context: context, defaultValue: padding.bottom),
    );
  }
}
