import '../const/export.dart';

class CustomColor {
  CustomColor._();

  static const Color primary = Color(0xFFF9761E);
  static const Color sprimary = Color(0xFF16577F);
  static const Color white = Color(0xFFffffff);
  static const Color btnLightPrimary = Color(0xFF6A979D);
  static const Color pWhite = Color(0xFFF1F1F1);
  static const Color black = Color(0xFF000000);

  static const Color background = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFFB1B1B1);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color hintText = Color(0xFF9E9E9E);

  static const Color borderColor = Color(
    0xFFE0E0E0,
  ); // Placeholder for inactive border
  static const Color whiteNatural = Color(
    0xFFF9F9F9,
  ); // Placeholder for a near-white background

  static const Color primaryBlue = Color(0xFF16577F); // Used for button text
  static const Color primaryBlueSlide = Color(
    0xFF00258B,
  ); // Used for button text
  // Add more colors as needed
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF6B7280);

  static const Color borderGrey = Color(0xFFD6D4D4);

  static const Color secondary = Color(0xFF03DAC6); // Teal
  static const Color grey = Color(0xFF757575); // Medium Gray
  static const Color error = Color(0xFFB00020); // Error Red

  // Add more if needed:
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFF7AB00); // Amber
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
        textColor = CustomColor
            .textSecondary; // Or a specific success color if preferred
        iconData = Icons.check_circle_outline;
        iconColor = CustomColor
            .primary; // Using primary for the checkmark as in the image style
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
          color: CustomColor.black.withValues(
            alpha: 0.3,
          ), // Shadow color and opacity
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

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget icon;
  final bool isPassword;
  final Widget? customContent;
  final TextInputType keyboardType;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.customContent,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F7),
        borderRadius: BorderRadius.circular(217.391),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Expanded(
              child: isPassword && customContent != null
                  ? customContent!
                  : TextField(
                      controller: controller,
                      obscureText: isPassword,
                      keyboardType: keyboardType,
                      style: const TextStyle(
                        color: CustomColor.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Josefin Sans',
                      ),
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: const TextStyle(
                          color: Color(0xFFB1B1B1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Josefin Sans',
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInputFieldLive extends StatefulWidget {
  const CustomInputFieldLive({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText,
    this.prefixWidget,
    this.suffixWidget,
    this.isPhoneNumber = false,
    this.onTap,
    this.isPassword = true,
    this.height,
    this.readOnly = false,
    this.keyboardType,
    // 🚨 NEW: Callbacks for Tappable Prefix and Suffix
    this.onPrefixTap,
    this.onSuffixTap,
    // 🚨 NEW: Added validation property for live update
    this.validator,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? hintText;

  /// Widget displayed before the TextField content (e.g., an icon or country code).
  final Widget? prefixWidget;

  /// 🚨 NEW: Callback when the prefix widget is tapped.
  final VoidCallback? onPrefixTap;

  /// Widget displayed after the TextField content (e.g., a clear button or validation icon).
  final Widget? suffixWidget;

  /// 🚨 NEW: Callback when the suffix widget is tapped.
  final VoidCallback? onSuffixTap;

  /// Enables the specialized phone number layout with a flag and country code.
  final bool isPhoneNumber;

  final double? height;

  /// Callback for when the field is tapped (useful for dropdowns/modals).
  final VoidCallback? onTap;

  /// If true, the field cannot be edited.
  final bool readOnly;
  final bool isPassword;
  final bool? obscureText;

  final TextInputType? keyboardType;

  // 🚨 NEW: Live validation function (returns String error or null)
  final String? Function(String?)? validator;

  // 🚨 NEW: On change callback
  final ValueChanged<String>? onChanged;

  @override
  State<CustomInputFieldLive> createState() => _CustomInputFieldLiveState();
}

class _CustomInputFieldLiveState extends State<CustomInputFieldLive> {
  // FocusNode is essential for managing the active/inactive state (the border color).
  final FocusNode _focusNode = FocusNode();
  // State to hold the current validation error message
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    // Initial validation if a controller is provided
    if (widget.controller != null && widget.validator != null) {
      _errorText = widget.validator!(widget.controller!.text);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      // Rebuilds the widget to update the border color.
    });
  }

  void _validate(String? text) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(text);
      });
    }
    // Also call the external onChanged callback
    widget.onChanged?.call(text ?? '');
  }

  /// -----------------------------------------------------------
  /// 1. REUSABLE BOX DECORATION
  /// -----------------------------------------------------------
  BoxDecoration getInputDecoration({bool hasFocus = false}) {
    Color color;

    if (_errorText != null) {
      // Use red color for error state
      color = CustomColor.error;
    } else {
      // Use primary color if focused, otherwise border color
      color = hasFocus
          ? CustomColor.inputBorder.withValues(alpha: 0.3)
          : CustomColor.inputBorder.withValues(alpha: 0.3);
    }

    return BoxDecoration(
      // The background color from the original widget
      color: CustomColor.inputBorder.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: color, width: 1.5),
    );
  }

  /// -----------------------------------------------------------
  /// 2. WIDGET BUILDERS
  /// -----------------------------------------------------------

  /// Builds the complex prefix for the phone number input (mocked).
  Widget _buildPhoneNumberPrefix(BuildContext context) {
    return Row(
      children: [
        // Mock Flag Image
        Image.asset(
          CustomImage.nigeriaFlag,
          width: 24,
          height: 16,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 24,
            height: 16,
            color: Colors.green,
            child: const Center(
              child: Text(
                'NG',
                style: TextStyle(fontSize: 10, color: CustomColor.white),
              ),
            ),
          ),
        ),
        horizontalSpace(8),
        Text(
          '+234',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            color: CustomColor.black,
          ),
        ),
        horizontalSpace(8),
        Container(width: 1, height: 24, color: CustomColor.borderColor),
        horizontalSpace(8),
      ],
    );
  }

  Widget _buildInputContent(BuildContext context) {
    final bool hasFocus = _focusNode.hasFocus;

    return Container(
      // Height is controlled by contentPadding in InputDecoration of the original field
      // Here, we use a fixed height or let padding control it, mirroring the original structure
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: getInputDecoration(hasFocus: hasFocus),

      child: TextField(
        // Keep the original style properties
        keyboardType:
            widget.keyboardType ??
            (widget.isPhoneNumber ? TextInputType.phone : TextInputType.text),
        obscureText:
            widget.obscureText ??
            widget.isPassword, // Use the new prop or fallback to the old
        controller: widget.controller,
        focusNode: _focusNode,
        readOnly: widget.readOnly,
        onTap: widget.onTap, // Pass onTap to TextField
        // 🚨 LIVE VALIDATION: Perform validation on every change
        onChanged: _validate,

        style: CustomFontStyle.body(
          context,
        ).copyWith(color: CustomColor.textBlack),

        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Enter value',
          hintStyle: CustomFontStyle.body(
            context,
          ).copyWith(color: CustomColor.hintText),

          // --- Input Border & Content Padding ---
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: _errorText != null
                  ? CustomColor.error
                  : CustomColor.inputBorder.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          enabledBorder: InputBorder.none,

          // Keep the original content padding
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),

          // --- Prefix/Suffix Configuration ---

          // Custom Prefix: Wraps the original prefixIcon if not phone number
          prefixIcon: widget.isPhoneNumber
              ? _buildPhoneNumberPrefix(context)
              : widget.prefixWidget != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  // 🚨 WRAP THE PREFIX WIDGET IN GestureDetector
                  child: GestureDetector(
                    onTap: widget.onPrefixTap,
                    child: widget.prefixWidget,
                  ),
                )
              : null,

          // Custom Suffix: If the user provides a suffix, use it.
          suffixIcon: widget.suffixWidget != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                  // 🚨 WRAP THE SUFFIX WIDGET IN GestureDetector
                  child: GestureDetector(
                    onTap: widget.onSuffixTap,
                    child: widget.suffixWidget,
                  ),
                )
              : null,

          // Keep the original constraints
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildInputContent(context),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0),
            child: Text(
              _errorText!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

// class CustomDropdownField extends StatefulWidget {
//   const CustomDropdownField({
//     super.key,
//     required this.hintText,
//     this.prefixIcon,
//     this.initialValue,
//     required this.options, // 🚨 NEW: List of selectable options
//     required this.onOptionSelected, // 🚨 NEW: Callback to notify parent of selection
//   });
//
//   final String hintText;
//   final Widget? prefixIcon;
//   final String? initialValue;
//   final List<String> options;
//   final ValueChanged<String> onOptionSelected;
//
//   @override
//   State<CustomDropdownField> createState() => _CustomDropdownFieldState();
// }
//
// class _CustomDropdownFieldState extends State<CustomDropdownField> {
//   String? _selectedValue;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedValue = widget.initialValue;
//   }
//
//   /// Handles the tap event and displays the list of options.
//   void _handleTap() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent, // Important for rounded corners
//       builder: (context) => _OptionsListSheet(
//         options: widget.options,
//         onSelect: _updateSelection,
//       ),
//     );
//   }
//
//   /// Updates the internal state and notifies the parent widget.
//   void _updateSelection(String selectedOption) {
//     setState(() {
//       _selectedValue = selectedOption;
//     });
//     widget.onOptionSelected(selectedOption); // Notify the parent
//   }
//
//   /// -----------------------------------------------------------
//   /// 1. REUSABLE BOX DECORATION
//   /// -----------------------------------------------------------
//   BoxDecoration getDropdownDecoration() {
//     return BoxDecoration(
//       color: CustomColor.primaryBlue,
//       borderRadius: BorderRadius.circular(25),
//       border: Border.all(color: CustomColor.primaryBlue, width: 1.5),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final String displayText = _selectedValue ?? widget.hintText;
//     const Color textColor = CustomColor.white;
//     const Color iconColor = CustomColor.white;
//
//     return GestureDetector(
//       onTap: _handleTap, // 🚨 Call the new handler
//       child: Container(
//         height: 50,
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         decoration: getDropdownDecoration(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // 1. Prefix Icon
//             if (widget.prefixIcon != null) ...[
//               IconTheme(
//                 data: const IconThemeData(color: iconColor, size: 20),
//                 child: widget.prefixIcon!,
//               ),
//               horizontalSpace(8),
//             ],
//
//             // 2. Displayed Text
//             Expanded(
//               child: Text(
//                 displayText,
//                 style: CustomFontStyle.body(context).copyWith(
//                   color: textColor,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//
//             // 3. Suffix Icon (Dropdown Arrow)
//             horizontalSpace(8),
//             const Icon(Icons.keyboard_arrow_down, color: iconColor, size: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final List<String> options;
  final Function(String) onChanged;
  final IconData? icon;
  final Widget? customIcon;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
    this.icon,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF16577F),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF16577F),
            borderRadius: BorderRadius.circular(217.391),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            style: const TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            dropdownColor: const Color(0xFF16577F),
            decoration: InputDecoration(
              prefixIcon: customIcon != null
                  ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: customIcon,
              )
                  : icon != null
                  ? Icon(icon, color: Colors.white, size: 24)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(217.391),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18,
              ),
              filled: true,
              fillColor: const Color(0xFF16577F),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 24,
            ),
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}


// ----------------------------------------------------------------------
// 🚨 New Widget: The Modal Bottom Sheet that shows the list of options
// ----------------------------------------------------------------------

class _OptionsListSheet extends StatelessWidget {
  final List<String> options;
  final ValueChanged<String> onSelect;

  const _OptionsListSheet({required this.options, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select an Option',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.textBlack,
                ),
              ),
            ),
            const Divider(height: 1, color: CustomColor.inputBorder),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    MediaQuery.of(context).size.height * 0.5, // Limit height
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return ListTile(
                    title: Text(
                      option,
                      style: CustomFontStyle.body(
                        context,
                      ).copyWith(color: CustomColor.textBlack),
                    ),
                    onTap: () {
                      onSelect(option);
                      Navigator.pop(context); // Close the sheet
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
