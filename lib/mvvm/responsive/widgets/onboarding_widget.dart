import 'package:queroobras_mobile/mvvm/const/export.dart';


class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ResponsiveValues.getResponsiveValue(
            context: context, defaultValue: 241),
        bottom: ResponsiveValues.getResponsiveValue(
            context: context, defaultValue: 119),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: ResponsiveValues.getResponsiveValue(
              context: context, defaultValue: 359),
        ),
        child: Column(
          children: [
            Text(
              'Seamless Supply, Simply Reliable',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF221C1C),
                fontFamily: 'Inter',
                fontSize: ResponsiveValues.getResponsiveFontSize(context, 24),
                fontWeight: FontWeight.w700,
                height: 34 / 24,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: ResponsiveValues.getResponsiveValue(
                    context: context, defaultValue: 28),
              ),
              child: Text(
                'Where reliability meets simplicity, ensuring your operations run smoothly every step of the way',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF221C1C),
                  fontFamily: 'Montserrat',
                  fontSize: ResponsiveValues.getResponsiveFontSize(context, 16),
                  fontWeight: FontWeight.w400,
                  height: 24 / 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepperIndicator extends StatelessWidget {
  final int currentStep;

  const StepperIndicator({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stepSize = ResponsiveValues.getResponsiveValue(
      context: context,
      defaultValue: 24,
    );
    final connectorWidth = ResponsiveValues.getResponsiveValue(
      context: context,
      defaultValue: 102,
    );
    final spacing = ResponsiveValues.getResponsiveValue(
      context: context,
      defaultValue: 36,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepNumber(context, 1, currentStep >= 1, stepSize),
            _buildConnector(context, currentStep >= 2, connectorWidth),
            _buildStepNumber(context, 2, currentStep >= 2, stepSize),
            _buildConnector(context, currentStep >= 3, connectorWidth),
            _buildStepNumber(context, 3, currentStep >= 3, stepSize),
          ],
        ),
        SizedBox(
          height: ResponsiveValues.getResponsiveValue(
            context: context,
            defaultValue: 8,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verification',
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(width: spacing),
            Text(
              'Information',
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(width: spacing),
            Text(
              'Complete',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepNumber(
      BuildContext context, int step, bool isActive, double size) {
    final theme = Theme.of(context);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isActive ? CustomColor.success : Colors.transparent,
        borderRadius: BorderRadius.circular(
          ResponsiveValues.getResponsiveValue(
            context: context,
            defaultValue: 100,
          ),
        ),
        border: isActive
            ? null
            : Border.all(color: CustomColor.borderGrey, width: 1),
      ),
      child: Center(
        child: Text(
          step.toString(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isActive ? CustomColor.white : CustomColor.borderGrey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildConnector(BuildContext context, bool isActive, double width) {
    return Container(
      width: width,
      height: 1,
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveValues.getResponsiveValue(
          context: context,
          defaultValue: 4,
        ),
      ),
      color: CustomColor.borderGrey,
    );
  }
}

const List<String> countriesList = [
  "Afghanistan",
  "Albania",
  "Algeria",
  "Andorra",
  "Angola",
  "Antigua and Barbuda",
  "Argentina",
  "Armenia",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bhutan",
  "Bolivia",
  "Bosnia and Herzegovina",
  "Botswana",
  "Brazil",
  "Brunei",
  "Bulgaria",
  "Burkina Faso",
  "Burundi",
  "Cabo Verde",
  "Cambodia",
  "Cameroon",
  "Canada",
  "Central African Republic",
  "Chad",
  "Chile",
  "China",
  "Colombia",
  "Comoros",
  "Congo (Brazzaville)",
  "Congo (Kinshasa)",
  "Costa Rica",
  "Côte d'Ivoire",
  "Croatia",
  "Cuba",
  "Cyprus",
  "Czechia",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Dominican Republic",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Eritrea",
  "Estonia",
  "Eswatini",
  "Ethiopia",
  "Fiji",
  "Finland",
  "France",
  "Gabon",
  "Gambia",
  "Georgia",
  "Germany",
  "Ghana",
  "Greece",
  "Grenada",
  "Guatemala",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Honduras",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran",
  "Iraq",
  "Ireland",
  "Israel",
  "Italy",
  "Jamaica",
  "Japan",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kiribati",
  "Kuwait",
  "Kyrgyzstan",
  "Laos",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Marshall Islands",
  "Mauritania",
  "Mauritius",
  "Mexico",
  "Micronesia",
  "Moldova",
  "Monaco",
  "Mongolia",
  "Montenegro",
  "Morocco",
  "Mozambique",
  "Myanmar (Burma)",
  "Namibia",
  "Nauru",
  "Nepal",
  "Netherlands",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "North Korea",
  "North Macedonia",
  "Norway",
  "Oman",
  "Pakistan",
  "Palau",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Poland",
  "Portugal",
  "Qatar",
  "Romania",
  "Russia",
  "Rwanda",
  "Saint Kitts and Nevis",
  "Saint Lucia",
  "Saint Vincent and the Grenadines",
  "Samoa",
  "San Marino",
  "Sao Tome and Principe",
  "Saudi Arabia",
  "Senegal",
  "Serbia",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "South Korea",
  "South Sudan",
  "Spain",
  "Sri Lanka",
  "Sudan",
  "Suriname",
  "Sweden",
  "Switzerland",
  "Syria",
  "Taiwan",
  "Tajikistan",
  "Tanzania",
  "Thailand",
  "Timor-Leste",
  "Togo",
  "Tonga",
  "Trinidad and Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom",
  "United States",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Vatican City",
  "Venezuela",
  "Vietnam",
  "Yemen",
  "Zambia",
  "Zimbabwe",
];
const List<String> businessType = [
  "Association",
  "Retailer",
  "Manufacturer",
  "Distributor"
];
const List<String> userType = [
  "Mr",
  "Miss",
  "Mrs",
];
