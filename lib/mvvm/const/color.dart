import '../const/export.dart';

class CustomColor {
  CustomColor._();

  static const Color primary = Color(0xFFF9761E);
  static const Color sprimary = Color(0xFF16577F);
  static const Color white = Colors.white;
  static const Color btnLightPrimary = Color(0xFF6A979D);
  static const Color pWhite = Color(0xFFF1F1F1);
  static const Color black = Color(0xFF000000);


  // Add more colors as needed
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF6B7280);


  static const Color borderGrey = Color(0xFFD6D4D4);

  static const Color secondary = Color(0xFF03DAC6); // Teal
  static const Color grey = Color(0xFF757575); // Medium Gray
  static const Color error = Color(0xFFB00020); // Error Red

  // Add more if needed:
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning =Color(0xFFF7AB00); // Amber
  static const Color info = Color(0xFF2196F3);
}

enum SnackbarType { success, error, warning }

class SnackbarUtil {
  // Private constructor to prevent instantiation
  SnackbarUtil._();


  static void showSnackbar({
    required String title,
    required String message,
    required SnackbarType type,
    SnackPosition snackPosition = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color textColor;
    IconData iconData;
    Color iconColor;

    switch (type) {
      case SnackbarType.success:
        textColor = CustomColor.textSecondary; // Or a specific success color if preferred
        iconData = Icons.check_circle_outline;
        iconColor = CustomColor.primary; // Using primary for the checkmark as in the image style
        break;
      case SnackbarType.error:
        textColor = CustomColor.error;
        iconData = Icons.error_outline;
        iconColor = CustomColor.error;
        break;
      case SnackbarType.warning:
        textColor = CustomColor.warning;
        iconData = Icons.warning_amber_outlined;
        iconColor = CustomColor.warning;
        break;
    }

    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      backgroundColor: CustomColor.white, // White background as per image
      colorText: textColor,
      borderRadius: 20, // Rounded corners as per image
      margin: const EdgeInsets.all(10), // Margin around the snackbar
      icon: Icon(iconData, color: iconColor),
      duration: duration,
      boxShadows: [
        BoxShadow(
          color: CustomColor.black.withValues(alpha: 0.3), // Shadow color and opacity
          spreadRadius: 2, // How much the shadow spreads
          blurRadius: 5, // How blurry the shadow is
          offset: const Offset(0, 3), // Shadow offset (x, y)
        ),
      ],
      // Optional: Add a border for more definition if needed
      // borderWidth: 1,
      // borderColor: Colors.grey.shade300,
    );
  }
}