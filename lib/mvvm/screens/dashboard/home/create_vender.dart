import '../../../const/export.dart';

class VendorFormScreen extends StatelessWidget {
  VendorFormScreen({super.key});

  final VendorFormController controller = Get.put(VendorFormController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,

          title: const Text(
            'Vender',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
            ),
          ),
        ),

        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      const Text(
                        'Upload the picture of the article.',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const ImageGallery(),
                      const SizedBox(height: 20),

                      const Text(
                        'Name of the article',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormInputField(
                        controller: controller.nameController,
                        hintText: 'Nome completo',
                        iconUrl:
                            'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/fb4753ea2332e5437e9408b1130e2de59f521eb7?placeholderIfAbsent=true',
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'Choose the article either a tools or material',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const DropdownField(),
                      const SizedBox(height: 20),

                      const Text(
                        'Quantity',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormInputField(
                        controller: controller.quantityController,
                        hintText: 'How many items you have',
                        iconUrl:
                            'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/a84a0bd6672e79c110437efd07915f43c5c1458f?placeholderIfAbsent=true',
                        iconWidth: 14,
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'Price',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormInputField(
                        controller: controller.priceController,
                        hintText: 'Enter price',
                        iconUrl:
                            'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/5ba60caad6eb7e1df41ad8cfaebe06628481be23?placeholderIfAbsent=true',
                        iconWidth: 14,
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'Description',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 97,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFF6F3F3),
                          border: Border.all(
                            color: const Color(0x0D000000),
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          controller: controller.descriptionController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: const TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Enter description',
                            hintStyle: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFB1B1B1),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Publish Button
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(217),
                          color: const Color(0xFFF9761E),
                        ),
                        child: TextButton(
                          onPressed: controller.publishItem,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 23,
                              horizontal: 70,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(217),
                            ),
                          ),
                          child: const Text(
                            'Publish',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 41),
                    ],
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

class FormInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String iconUrl;
  final double iconWidth;

  const FormInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconUrl,
    this.iconWidth = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xFFF6F3F3),
        border: Border.all(color: const Color(0x0D000000), width: 1),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Josefin Sans',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFFB1B1B1),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 15,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.all(15),
            child: CustomImageView(
              imagePath: iconUrl,
              width: iconWidth,
              height: iconWidth,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 44,
            minHeight: 44,
          ),
        ),
      ),
    );
  }
}

class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/5671a58cba5440f23b5cb7a9fde5de63c8fca2bd?placeholderIfAbsent=true',
    ];

    return Row(
      children: imageUrls
          .map(
            (url) => Container(
              margin: const EdgeInsets.only(right: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CustomImageView(
                  imagePath: url,
                  width: 75,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class DropdownField extends StatefulWidget {
  const DropdownField({super.key});

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(217),
        color: const Color(0xFF16577F),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        borderRadius: BorderRadius.circular(217),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 21),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomImageView(
                    imagePath:
                        'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/f172e9dc86845c3fccd2e1c14f9098dc5a85642f?placeholderIfAbsent=true',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Choose the type of item',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              CustomImageView(
                imagePath:
                'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/c6d652b80f01e6b68b1e604566302c9bd07d19f0?placeholderIfAbsent=true',
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
