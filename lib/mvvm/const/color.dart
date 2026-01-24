

import '../const/export.dart';

/// --------------------------------------------------------------
/// COLORS
/// --------------------------------------------------------------
class CustomColor {
  CustomColor._();

  static const Color primary = Color(0xFFF9761E);
  static const Color sprimary = Color(0xFF16577F);

  static const Color white = Color(0xFFFFFFFF);
  static const Color pWhite = Color(0xFFF1F1F1);
  static const Color whiteNatural = Color(0xFFF9F9F9);

  static const Color black = Color(0xFF000000);
  static const Color textBlack = Color(0xFFB1B1B1);
  static const Color textHash = Color(0xFFA0A0A0);
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF6B7280);

  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color hintText = Color(0xFF9E9E9E);
  static const Color borderColor = Color(0xFFE0E0E0);

  static const Color borderGrey = Color(0xFFD6D4D4);
  static const Color background = Color(0xFFFFFFFF);

  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFF7AB00);
  static const Color info = Color(0xFF2196F3);

  static const Color secondary = Color(0xFF03DAC6);
  static const Color grey = Color(0xFF757575);

  static const Color primaryBlue = Color(0xFF16577F);
  static const Color primaryBlueSlide = Color(0xFF00258B);
}

/// --------------------------------------------------------------
/// SNACKBAR UTIL
/// --------------------------------------------------------------
enum SnackbarType { success, error, warning }
enum MessageType { error, success, info }


class CustomLoading {
  static OverlaySupportEntry showOver = OverlaySupportEntry.empty();
  static CircularProgressIndicator loadingIndicator =
      const CircularProgressIndicator();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Display loading overlay

  static void loading() {
    if (kIsWeb) {
      // Show Web Loading Bar using GetX Snackbar as a Top Bar Indicator
      Get.snackbar(
        '',
        '',
        titleText: const SizedBox.shrink(), // Remove title
        messageText: LinearProgressIndicator(
          backgroundColor: Colors.grey[300],
          color: CustomColor.primary, // Change color as needed
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        barBlur: 0,
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
        duration: const Duration(seconds: 30), // Keep it for loading duration
      );
    } else {
      // Default Overlay for Mobile/Desktop
      showOver = showOverlay(
        duration: const Duration(seconds: 30),
        (context, progress) => Container(
          color: Color.lerp(
              Colors.transparent, Colors.black.withValues(
                alpha: 0.9
              ), progress),
          child: FractionalTranslation(
            translation:
                Offset.lerp(const Offset(0, -1), const Offset(0, 0), progress)!,
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
  }

  // Dismiss loading overlay
  static void loadingStop() {
    if (kIsWeb) {
      // Dismiss Web Loading Bar
      Get.closeAllSnackbars();
    } else {
      // Dismiss overlay for Mobile/Desktop
      showOver.dismiss();
    }
  }

  // Show notification
  static void showNotification({
    required String message,
    MessageType messageType = MessageType.success, // Default type is success
  }) {
    final Color backgroundColor = messageType == MessageType.error
        ? CustomColor.error
        : messageType == MessageType.info
            ? CustomColor.warning
            : CustomColor.success;

    const Color textColor = Colors.white; // Consistent white text

    if (kIsWeb) {
      // Show Snackbar for Web
      Get.snackbar(
        messageType == MessageType.error ? "Error" : "Notification",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: backgroundColor,
        colorText: textColor,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    } else {
      // Handle Native Toast for Android & iOS
      Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0,
      );
    }
  }
}

class SnackbarUtil {
  SnackbarUtil._();

  static void showSnackbar({
    required String title,
    required String message,
    required SnackbarType type,
    SnackPosition snackPosition = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color textColor;
    IconData icon;
    Color iconColor;

    switch (type) {
      case SnackbarType.success:
        textColor = CustomColor.textSecondary;
        icon = Icons.check_circle_outline;
        iconColor = CustomColor.primary;
        break;

      case SnackbarType.error:
        textColor = CustomColor.error;
        icon = Icons.error_outline;
        iconColor = CustomColor.error;
        break;

      case SnackbarType.warning:
        textColor = CustomColor.warning;
        icon = Icons.warning_amber_outlined;
        iconColor = CustomColor.warning;
        break;
    }

    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      backgroundColor: CustomColor.white,
      colorText: textColor,
      borderRadius: 20,
      margin: const EdgeInsets.all(10),
      icon: Icon(icon, color: iconColor),
      duration: duration,
      boxShadows: [
        BoxShadow(
          color: CustomColor.black.withValues(alpha:  0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}

/// --------------------------------------------------------------
/// SIMPLE CUSTOM INPUT FIELD
/// --------------------------------------------------------------
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
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '',
                      isDense: true,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// --------------------------------------------------------------
/// ADVANCED LIVE INPUT FIELD WITH VALIDATION
/// --------------------------------------------------------------
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
    this.onPrefixTap,
    this.onSuffixTap,
    this.validator,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? hintText;

  final Widget? prefixWidget;
  final VoidCallback? onPrefixTap;

  final Widget? suffixWidget;
  final VoidCallback? onSuffixTap;

  final bool isPhoneNumber;
  final double? height;

  final bool readOnly;
  final bool isPassword;
  final bool? obscureText;
  final TextInputType? keyboardType;

  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  State<CustomInputFieldLive> createState() => _CustomInputFieldLiveState();
}

class _CustomInputFieldLiveState extends State<CustomInputFieldLive> {
  final FocusNode _focusNode = FocusNode();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));

    if (widget.controller != null && widget.validator != null) {
      _errorText = widget.validator!(widget.controller!.text);
    }
  }

  void _validate(String? text) {
    if (widget.validator != null) {
      setState(() => _errorText = widget.validator!(text));
    }
    widget.onChanged?.call(text ?? '');
  }

  BoxDecoration _inputDecoration({required bool focused}) {
    return BoxDecoration(
      color: CustomColor.inputBorder.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        color: _errorText != null
            ? CustomColor.error
            : (focused
                  ? CustomColor.inputBorder
                  : CustomColor.inputBorder.withValues(alpha:  0.3)),
        width: 1.5,
      ),
    );
  }

  Widget _buildPhonePrefix(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          CustomImage.nigeriaFlag,
          width: 24,
          height: 16,
          errorBuilder: (_, _, _) => Container(
            width: 24,
            height: 16,
            color: Colors.green,
            alignment: Alignment.center,
            child: const Text('NG', style: TextStyle(color: Colors.white)),
          ),
        ),
        horizontalSpace(8),
        const Text('+234', style: TextStyle(fontSize: 16)),
        horizontalSpace(8),
        Container(width: 1, height: 24, color: CustomColor.borderColor),
        horizontalSpace(8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final focused = _focusNode.hasFocus;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: _inputDecoration(focused: focused),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText ?? widget.isPassword,
            onTap: widget.onTap,
            onChanged: _validate,
            keyboardType:
                widget.keyboardType ??
                (widget.isPhoneNumber
                    ? TextInputType.phone
                    : TextInputType.text),
            style: CustomFontStyle.body(
              context,
            ).copyWith(color: CustomColor.textPrimary),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: CustomFontStyle.body(
                context,
              ).copyWith(color: CustomColor.hintText),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              prefixIcon: widget.isPhoneNumber
                  ? _buildPhonePrefix(context)
                  : widget.prefixWidget != null
                  ? GestureDetector(
                      onTap: widget.onPrefixTap,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: widget.prefixWidget,
                      ),
                    )
                  : null,
              suffixIcon: widget.suffixWidget != null
                  ? GestureDetector(
                      onTap: widget.onSuffixTap,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: widget.suffixWidget,
                      ),
                    )
                  : null,
            ),
          ),
        ),

        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              _errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

/// --------------------------------------------------------------
/// CUSTOM DROPDOWN FIELD
/// --------------------------------------------------------------
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
            color: CustomColor.sprimary,
          ),
        ),
        const SizedBox(height: 14),

        Container(
          decoration: BoxDecoration(
            color: CustomColor.sprimary,
            borderRadius: BorderRadius.circular(217.391),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            isExpanded: true, // ✅ CRITICAL FIX
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
            dropdownColor: CustomColor.sprimary,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Josefin Sans',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              prefixIcon: customIcon != null
                  ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: customIcon,
              )
                  : icon != null
                  ? Icon(icon, color: Colors.white)
                  : null,
              filled: true,
              fillColor: CustomColor.sprimary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(217.391),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14, // ⬅ reduced to avoid squeeze
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            items: options.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis, // ✅ prevents overflow
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class Role {
  final int id;
  final String name;
  final bool isSelected;

  const Role({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  Role copyWith({int? id, String? name, bool? isSelected}) {
    return Role(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class RoleItem extends StatelessWidget {
  final Role role;
  final VoidCallback onTap;

  const RoleItem({
    super.key,
    required this.role,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: role.isSelected ? const Color(0xFF16577F) : Colors.white,
        border: Border.all(
          color: const Color(0xFFF0F0F0),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 17),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: role.isSelected ? const Color(0xFF1C81BF) : const Color(0xFFD9D9D9),
                  ),
                  child: role.isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 14)
                      : null,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    role.name,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: role.isSelected ? Colors.white : const Color(0xFF444444),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class MultiSelectDropdownField extends StatefulWidget {
  final String label;
  final List<Role> roles;
  final Function(List<Role>) onSelectionChanged;

  const MultiSelectDropdownField({
    super.key,
    required this.label,
    required this.roles,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectDropdownField> createState() =>
      _MultiSelectDropdownFieldState();
}

class _MultiSelectDropdownFieldState extends State<MultiSelectDropdownField> {
  late List<Role> _roles;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _roles = List.from(widget.roles);
  }

  List<Role> get _filteredRoles {
    if (_searchQuery.isEmpty) return _roles;
    return _roles
        .where((r) => r.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void _toggleRole(int index) {
    setState(() {
      _roles[index] = _roles[index].copyWith(isSelected: !_roles[index].isSelected);
    });
  }

  void _submitSelection() {
    widget.onSelectionChanged(_roles.where((r) => r.isSelected).toList());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _roles.where((r) => r.isSelected).length;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Drag handle
            Container(
              width: 49,
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            const SizedBox(height: 20),
      
            // Header
            Text(
              '${widget.label} ($selectedCount Selecionado)',
              style: const TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
      
            // Search field
            CustomSearchField(
              hintText: 'Pesquisar ${widget.label}',
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
            const SizedBox(height: 20),
      
            // List of roles
            Expanded(
              child: ListView(
                children: _filteredRoles.asMap().entries.map((entry) {
                  int index = entry.key;
                  Role role = entry.value;
                  return RoleItem(
                    role: role,
                    onTap: () => _toggleRole(_roles.indexOf(role)),
                  );
                }).toList(),
              ),
            ),
      
            // Submit button
            CustomSubmitButton(
              text: 'Selecionar ${widget.label}',
              onPressed: _submitSelection,
            ),
          ],
        ),
      ),
    );
  }
}


class CustomSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomSubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(217),
        color: const Color(0xFFF9761E),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(217),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 19),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;

  const CustomSearchField({
    super.key,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFF0F0F0),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Icon(Icons.search_outlined),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF444444),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF444444),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/// --------------------------------------------------------------
/// OPTIONS BOTTOM SHEET
/// --------------------------------------------------------------
class OptionsListSheet extends StatelessWidget {
  final List<String> options;
  final ValueChanged<String> onSelect;

  const OptionsListSheet({
    super.key,
    required this.options,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select an Option',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: CustomColor.black,
              ),
            ),
          ),
          const Divider(height: 1, color: CustomColor.inputBorder),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: ListView(
              shrinkWrap: true,
              children: options.map((option) {
                return ListTile(
                  title: Text(
                    option,
                    style: const TextStyle(color: CustomColor.black),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onSelect(option);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
