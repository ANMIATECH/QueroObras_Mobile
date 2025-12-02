import '/mvvm/const/export.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
          ),
          title: const Text(
            'Edit Profile', // 🇧🇷
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
              height: 0.75,
            ),
          ),
          centerTitle: false,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [

              // Information text
              Container(
                margin: const EdgeInsets.only(top: 26),
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
                        child:   CustomImageView(imagePath:
                        'assets/images/profile_dummy.png',
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
                                   Icon(Icons.person),
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
                                Icon(Icons.edit_rounded),
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
                                    Icon(Icons.email_outlined),
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
                                Icon(Icons.edit_rounded),
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
                                    Icon(Icons.phone),
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
                                Icon(Icons.edit_rounded),
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
                                    Icon(Icons.shopping_bag_rounded),
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
                                Icon(Icons.edit_rounded),
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
                                Icon(Icons.money),
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
        ),
      ),
    );
  }
}
