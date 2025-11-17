import 'package:flutter/material.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xFFFFFFFF),
      ),
      constraints: const BoxConstraints(maxWidth: 480),
      child: Column(
        children: [
          // Navigation Bar - iPhone
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                // Materials background
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                    ),
                    child: Container(
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color(0x00FFFFFF),
                      ),
                    ),
                  ),
                ),
                // Status Bar - iPhone
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 439),
                  padding: const EdgeInsets.only(top: 23),
                  child: SizedBox(
                    height: 36,
                    child: Row(
                      children: [
                        // Time section
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 17, right: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '9:41',
                                  style: TextStyle(
                                    color: const Color(0xFF000000),
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'SF Pro',
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Dynamic Island spacer
                        SizedBox(
                          width: 135,
                          height: 11,
                        ),
                        // Levels section
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 7, right: 17),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/7b20f5636a068e3290bf8919382ab7f7fa2c78be?placeholderIfAbsent=true',
                                  width: 21,
                                  height: 13,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                                Image.network(
                                  'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/8f20b20e0d746b32be61f4356dbfe10f722b1cbc?placeholderIfAbsent=true',
                                  width: 19,
                                  height: 13,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Header with back button and title
          Container(
            margin: const EdgeInsets.only(top: 9),
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/81d791c2528a834edfe99ef27e9eb164760eefe4?placeholderIfAbsent=true',
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 23),
                    SizedBox(
                      width: 198,
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: const Color(0xFF000000),
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Information text
          Container(
            margin: const EdgeInsets.only(top: 46),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'As a service provider to allow changes on this page will require some autoriasaion from the admin for security purpose.',
              style: TextStyle(
                color: const Color(0xFF969696),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Josefin Sans',
                height: 24 / 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Profile section with image and form fields
          Container(
            margin: const EdgeInsets.only(top: 24),
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 398),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile image
                Container(
                  width: 105,
                  height: 105,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Image.network(
                      'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/394f9e83c49be9e784a6abff33ee995a75c92cc9?placeholderIfAbsent=true',
                      width: 105,
                      height: 105,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 21),

                // Form fields
                Expanded(
                  child: Column(
                    children: [
                      // Username field
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Color(0xFFF7F7F7),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/ca9f99d586a7f76ce7db8015a3bb6c5bd7b68f3a?placeholderIfAbsent=true',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Username',
                                  style: TextStyle(
                                    color: const Color(0xFF828282),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Josefin Sans',
                                    height: 24 / 14,
                                  ),
                                ),
                              ],
                            ),
                            Image.network(
                              'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/6e88f43e7c6206404102f03dd5e524c2464cc751?placeholderIfAbsent=true',
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 11),

                      // Email Address field
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Color(0xFFF7F7F7),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/e8d85550f4146628f3d7c5e18178b02ca2e00445?placeholderIfAbsent=true',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Email Address',
                                  style: TextStyle(
                                    color: const Color(0xFF828282),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Josefin Sans',
                                    height: 24 / 14,
                                  ),
                                ),
                              ],
                            ),
                            Image.network(
                              'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/6e88f43e7c6206404102f03dd5e524c2464cc751?placeholderIfAbsent=true',
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 11),

                      // Phone number field
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Color(0xFFF7F7F7),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/f60e6322ecdc8ea53b915ca0982432dd8ab4b039?placeholderIfAbsent=true',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Phone number',
                                  style: TextStyle(
                                    color: const Color(0xFF828282),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Josefin Sans',
                                    height: 24 / 14,
                                  ),
                                ),
                              ],
                            ),
                            Image.network(
                              'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/6e88f43e7c6206404102f03dd5e524c2464cc751?placeholderIfAbsent=true',
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 11),

                      // Service provider field
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Color(0xFFF7F7F7),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/9d752643a73696f311626fee874b93f307997ed1?placeholderIfAbsent=true',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'service provider',
                                  style: TextStyle(
                                    color: const Color(0xFF828282),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Josefin Sans',
                                    height: 24 / 14,
                                  ),
                                ),
                              ],
                            ),
                            Image.network(
                              'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/613d814d66b05171318e33f82a51eaea18adc140?placeholderIfAbsent=true',
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 11),

                      // Price field
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Color(0xFFF7F7F7),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          children: [
                            Image.network(
                              'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/9d752643a73696f311626fee874b93f307997ed1?placeholderIfAbsent=true',
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '20\$',
                              style: TextStyle(
                                color: const Color(0xFF828282),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Josefin Sans',
                                height: 24 / 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Spacer
          const SizedBox(height: 379),

          // Update Information button
          Container(
            margin: const EdgeInsets.only(bottom: 48),
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 398),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Color(0xFFF9761E),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 12),
              child: Center(
                child: Text(
                  'Update Information',
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Josefin Sans',
                    height: 24 / 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
