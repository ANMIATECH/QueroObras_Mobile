import '../const/export.dart';

class CustomText {
  CustomText._();

  static const String encontre = 'Encontre o profissional certo para o seu problema.';
  static const String encontre2 = 'Tire uma foto e deixe o app cuidar do resto.';
  static const String encontre3 = 'Conecte-se com prestadores de serviço qualificados.';
  static const String encontre4 = 'Resolva qualquer problema de forma rápida e simples.';
  static const String deslize = 'Deslize o botão para baixo para continuar o processo.';

  static const String continuar = 'Continuar';
  static const String entrar = 'Entrar';
  static const String cadastrar = 'Cadastrar-se';
  static const String desenvolvido = 'Desenvolvido por miatech.pro';


}

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.theme,
    required this.title,
    this.onTap,
  });

  final ThemeData theme;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: ResponsiveValues.getResponsiveValue(
          context: context,
          defaultValue: 48,
          minValue: 42,
          maxValue: 56,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: theme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveValues.getResponsiveFontSize(context, 16),
              color: CustomColor.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class CustomBtnLine extends StatelessWidget {
  const CustomBtnLine({
    super.key,
    required this.theme,
    required this.title,
    this.onTap,
  });

  final ThemeData theme;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: ResponsiveValues.getResponsiveValue(
          context: context,
          defaultValue: 48,
          minValue: 42,
          maxValue: 56,
        ),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blue, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.white,
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: theme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveValues.getResponsiveFontSize(context, 16),
              color: CustomColor.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class CountryDropdownField extends StatelessWidget {
  final String selectedCountry;
  final Function(String?) onChanged;
  final List<String> countries;

  const CountryDropdownField({
    super.key,
    required this.selectedCountry,
    required this.onChanged,
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: ResponsiveValues.getResponsivePadding(
        context,
        const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          ResponsiveValues.getResponsiveValue(
              context: context, defaultValue: 8),
        ),
        border: Border.all(
          color: CustomColor.primary,
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        icon: Icon(
          Icons.arrow_drop_down,
          size: ResponsiveValues.getResponsiveValue(
            context: context,
            defaultValue: 28,
          ),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(0),
        ),
        decoration: const InputDecoration.collapsed(hintText: ''),
        isExpanded: true,
        onChanged: onChanged,
        items: countries.map((String country) {
          return DropdownMenuItem<String>(
            value: country,
            child: Text(
              country,
              style: theme.textTheme.displayMedium,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CountryDropdownFieldTap<T> extends StatelessWidget {
  final T? selectedCountry;
  final Function(T?) onChanged;
  final List<DropdownMenuItem<T>>? countries;

  const CountryDropdownFieldTap({
    super.key,
    required this.selectedCountry,
    required this.onChanged,
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveValues.getResponsivePadding(
        context,
        const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          ResponsiveValues.getResponsiveValue(
              context: context, defaultValue: 8),
        ),
        border: Border.all(
          color: CustomColor.primary,
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<T>(
        icon: Icon(
          Icons.arrow_drop_down,
          size: ResponsiveValues.getResponsiveValue(
            context: context,
            defaultValue: 28,
          ),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(0)),
        decoration: const InputDecoration.collapsed(hintText: ''),
        isExpanded: true,
        onChanged: onChanged,
        items: countries,
      ),
    );
  }
}

class CountryDropdownFieldHard extends StatelessWidget {
  final String selectedCountry;
  final Function(String?) onChanged;
  final List<DropdownMenuItem<String>>? items;
  const CountryDropdownFieldHard({
    super.key,
    required this.selectedCountry,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveValues.getResponsivePadding(
        context,
        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          ResponsiveValues.getResponsiveValue(
              context: context, defaultValue: 8),
        ),
        border: Border.all(
          color: CustomColor.primary,
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        icon: Icon(
          Icons.arrow_drop_down,
          size: ResponsiveValues.getResponsiveValue(
            context: context,
            defaultValue: 28,
          ),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(0),
        ),
        decoration: const InputDecoration.collapsed(hintText: ''),
        isExpanded: true,
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}

class CountryTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final String labelText;
  final bool enabled;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? hintText;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;

  const CountryTextFormField({
    super.key,
    this.controller,
    this.onTap,
    this.validator,
    required this.keyboardType,
    this.labelText = 'Select Country',
    this.enabled = true,
    this.obscureText,
    this.hintText,
    this.suffixIcon,
    this.maxLines,
    this.onChanged,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines, // ✅ Fix: Ensure maxLines is 1 for password field
      minLines: minLines,
      onTap: enabled ? onTap : null,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: CustomColor.black,
      ),
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        alignLabelWithHint: true,
        filled: true,

        //labelText: labelText,
        contentPadding: ResponsiveValues.getResponsivePadding(
          context,
          const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        ),
        //constraints: const BoxConstraints.tightFor(height: 37),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveValues.getResponsiveValue(
              context: context,
              defaultValue: 8,
            ),
          ),
          borderSide: const BorderSide(
            color: CustomColor.primary,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveValues.getResponsiveValue(
              context: context,
              defaultValue: 8,
            ),
          ),
          borderSide: const BorderSide(
            color: CustomColor.error,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveValues.getResponsiveValue(
              context: context,
              defaultValue: 8,
            ),
          ),
          borderSide: const BorderSide(
            color: CustomColor.primary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveValues.getResponsiveValue(
              context: context,
              defaultValue: 8,
            ),
          ),
          borderSide: const BorderSide(
            color: CustomColor.primary,
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            ResponsiveValues.getResponsiveValue(
              context: context,
              defaultValue: 8,
            ),
          ),
          borderSide: const BorderSide(
            color: CustomColor.grey,
            width: 1,
          ),
        ),

        enabled: enabled,
      ),
    );
  }
}
