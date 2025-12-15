import '../../../const/export.dart';

class VendorFormScreen extends StatelessWidget {
  VendorFormScreen({super.key});

  final VendorFormController controller = Get.find();

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

        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),

          child: Container(
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
                          'Faça upload da foto do artigo.',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // 👈 START: DYNAMIC IMAGE ROW
                        Obx(() {
                          final images = controller.selectedImages;

                          // Create a list of image containers
                          List<Widget> imageWidgets = images
                              .asMap()
                              .entries
                              .map((entry) {
                                final index = entry.key;
                                final file = entry.value;

                                return SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: index < controller.maxImages - 1
                                          ? 10
                                          : 0,
                                    ),
                                    child: _ImagePreviewContainer(
                                      file: file,
                                      onRemove: () =>
                                          controller.removeImage(file),
                                    ),
                                  ),
                                );
                              })
                              .toList();
                          if (images.length < controller.maxImages) {
                            imageWidgets.add(
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: _AddImageButton(
                                  onTap: controller.pickImages,
                                  // REMOVE THIS LINE: isFirst: images.isEmpty && images.length < 4,
                                ),
                              ),
                            );
                          }

                          // This uses SizedBox(width: 10) for gaps and an empty Expanded for the remaining slots
                          while (imageWidgets.length < controller.maxImages) {
                            imageWidgets.add(
                              const SizedBox(
                                height: 60,
                                width: 60,
                                child: SizedBox.shrink(),
                              ),
                            ); // Add the placeholder
                          }

                          return Row(
                            children: [
                              // Re-evaluate imageWidgets list to ensure correct spacing
                              ...imageWidgets.sublist(
                                0,
                                images.length,
                              ), // Display selected images
                              // Add the Add button if not full
                              if (images.length < controller.maxImages)
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: _AddImageButton(
                                    onTap: controller.pickImages,
                                  ),
                                ),
                            ],
                          );
                        }),
                        // 👈 END: DYNAMIC IMAGE ROW
                        const SizedBox(height: 20),
                        const Text(
                          'Nome do artigo',
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
                          iconUrl: "assets/images/tool.svg",
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'Escolha o tipo do artigo: ferramenta ou material',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomDropdownField(
                          label: CustomText.registrationType,
                          selectedValue: "Ferramentas",
                          options: ["Ferramentas", "Materiais"],
                          customIcon: const Icon(
                            Icons.verified_user,
                            color: CustomColor.hintText,
                          ),

                          onChanged: (String newValue) {
                            // sync both selectedUserStatus & selectedDocumentType
                            controller.selectedType.value = newValue;
                          },
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'Quantidade',
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
                          hintText: 'Quantos itens você possui',
                          iconUrl: "assets/images/price.svg",
                          iconWidth: 14,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'Preço',
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
                          hintText: 'Digite o preço',
                          iconUrl: "assets/images/price.svg",
                          iconWidth: 14,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'Descrição',
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
                              hintText: 'Digite a descrição',
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
                        Obx(
                          () => CustomButton(
                            text: CustomText.publish,
                            isLoading: controller.isCreateItemLoading.value,
                            onPressed: () async {
                              controller.publishItem(context);
                            },
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
      ),
    );
  }
}

class FormInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String iconUrl;
  final double iconWidth;
  final TextInputType? keyboardType;

  const FormInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconUrl,
    this.iconWidth = 24,
    this.keyboardType,
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
        keyboardType: keyboardType,
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
                    imagePath: "assets/images/calender.svg",
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
              Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

// 👈 New Widget for Image Preview
class _ImagePreviewContainer extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;
  final double height;
  final double borderRadius;

  const _ImagePreviewContainer({
    required this.file,
    required this.onRemove,
    // ignore: unused_element_parameter
    this.height = 49.875,
    // ignore: unused_element_parameter
    this.borderRadius = 4.45,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(image: FileImage(file), fit: BoxFit.cover),
      ),
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: onRemove,
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 14),
        ),
      ),
    );
  }
}

// 👈 New Widget for Add Image Button
class _AddImageButton extends StatelessWidget {
  final VoidCallback onTap;
  final double height;
  final double borderRadius;

  const _AddImageButton({
    required this.onTap,
    // ignore: unused_element_parameter
    this.height = 49.875,
    // ignore: unused_element_parameter
    this.borderRadius = 4.45,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF16577F),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(width: 0.89, color: const Color(0x0D000000)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomImageView(
            height: 17,
            width: 17,
            imagePath: "assets/images/add.svg",
            color: Colors.white, // assuming you want the icon white
          ),
        ),
      ),
    );
  }
}
