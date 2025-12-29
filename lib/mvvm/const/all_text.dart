import '../const/export.dart';

class CustomText {
  CustomText._();

  static const String encontre = 'Encontre o profissional certo para o seu problema.';
  static const String encontre2 = 'Tire uma foto e deixe o app cuidar do resto.';
  static const String encontre3 = 'Conecte-se com prestadores de serviço qualificados.';
  static const String encontre4 = 'Resolva qualquer problema de forma rápida e simples.';
  static const String deslize = 'Deslize o botão para baixo para continuar o processo.';
  static const String enter = 'Adicionar ao carrinho';
  static const String addToCart = 'Adicionar ao carrinho';
  static const String publish = 'Publish';
  static const String resetPassword = 'Reset Password';
  static const String changeUrPassword = 'Change your password ';
  static const String emailAddress = 'Endereço de e-mail';
  static const String password = 'Senha';
  static const String rememberMe = 'Lembrar de mim';
  static const String forgotPassword = 'Esqueceu a senha?';
  static const String forgotPasswordSub = 'Escreva seu endereço de e-mail\nabaixo.';
  static const String orContinueWith = 'Ou continue com';
  static const String dontHaveAccount = 'Não tem uma conta?';
  static const String doHaveAccount = 'Já tem uma conta?';
  static const String signUp = 'Cadastrar-se';
  static const String continuar = 'Continuar';
  static const String otpPin = 'SENHA OTP';
  static const String otpPinSub = 'SENHA OTP';
  static const String deslizeO = 'Deslize o botão para o lado direito';
  static const String entrar = 'Entrar';
  static final String checkOut = 'Finalizar compra de todos os itens: ';
  static const String update = 'Atualizar';

  static const String updateStatus = 'Atualizar status';
  static const String trackOrder = 'Acompanhe seu pedido';
  static const String updateOrder = 'Atualize seu pedido';
  static const String cadastrar = 'Cadastrar-se';
  static const String newPassword = 'New password';
  static const String desenvolvido = 'Desenvolvido por miatech.pro';

   static const String screenTitle =
      "Encontre o profissional certo para o seu problema.";
  static const String continueButton = "Continuar";
  static const String comecar= "Começar";
  static const String developedBy = "Desenvolvido por miatech.pro";
  static const String bemVindo = "Bem-vindo ao Quero Obras, sua melhor ferramenta para todas as necessidades do seu ciclo de vida.";

  static const registrationType = "Tipo de cadastro";
  static const fullName = "Nome completo";
  static const name = "Nome";
  static const cooperateName = "Razão Social";
  static const companyName = "Nome da Empresa";
  static const businessEmail = "E-mail Comercial";
  static const legalRepName = "Nome do Representante Legal";
  static const tradeName = "Nome Fantasia";
  static const motherName = "Nome da Mãe";
  static const birthDate = "Data de nascimento";
  static const role = "Função";
  static const cnpj = "CNPJ";
  static const cpf = "CPF";
  static const cep = "CEP";
  static const stateRegistration = "Inscrição Estadual";
  static const address = "Endereço";
  static const houseNumber = "Número";
  static const commercialEmail = "E-mail Comercial";
  static const confirmPassword = "Confirmar senha";

  // --- Hint Text ---
  static const hintFullName = "Digite seu nome completo";
  static const hintCompanyName = "Digite o nome da empresa";
  static const hintTradeName = "Digite o nome fantasia";
  static const hintLegalRep = "Representante legal";
  static const hintEmail = "exemplo@dominio.com";
  static const hintBirthDate = "dd/mm/aaaa";
  static const hintPassword = "Digite sua senha";
  static const hintConfirmPassword = "Confirme sua senha";
  static const hintAddress = "Digite seu endereço";
  static const hintCEP = "Digite o CEP";
  static const hintCNPJ = "Digite o CNPJ";
  static const hintCPF = "Digite o CPF";
  static const hintPhone = "Digite o número";


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
