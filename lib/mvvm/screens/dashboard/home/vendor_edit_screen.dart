import '../../../const/export.dart';

// Assuming you pass the item ID when navigating to this screen
class VendorEditScreen extends StatelessWidget {
  final Item itemId;
  VendorEditScreen({super.key, required this.itemId}) {
    // 1. Find the controller
    final controller = Get.find<VendorFormController>();

    // 2. Initialize it with the item ID
    controller.initializeWithItem(itemId);
    // controller.fetchItemDetails(); // Fetch existing data
  }

  // We reuse the same controller, but we now need to retrieve it by type
  final VendorFormController controller = Get.find<VendorFormController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
    
        title: Text(
          // 👈 UPDATED TITLE
          'Editar ${controller.nameControllerEdit.text}',
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
                        'Upload the picture of the article.',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // 👈 START: DYNAMIC IMAGE ROW (Must handle both existing URLs and new Files)
                      Obx(() {
                        // Combine existing image URLs and new File objects for display
                        final allImages = [
                          ...controller.existingImageUrlsEdit ?? [],
                          ...controller.selectedImages,
                        ];
                        const int maxItems = 5; // Assuming max 5 images
                        const double spacing = 10;
    
                        // Build the row children
                        List<Widget> children = [];
    
                        for (int i = 0; i < maxItems; i++) {
                          // 👈 NEW: Use the helper function to determine and return the widget for slot 'i'
                          children.add(
                            _buildImageSlotWidget(
                              i,
                              controller,
                              allImages,
                              maxItems,
                              spacing,
                            ),
                          );
                        }
    
                        // The row children now contains 5 Expanded widgets (image, add button, or placeholder)
                        // We need to insert the SizedBox spacing *between* these Expanded widgets.
    
                        List<Widget> rowChildren = [];
                        for (int i = 0; i < children.length; i++) {
                          rowChildren.add(children[i]);
                          // Add spacing only if it's not the last item
                          if (i < children.length - 1) {
                            rowChildren.add(const SizedBox(width: spacing));
                          }
                        }
    
                        return Row(children: rowChildren);
                      }),
    
                      const SizedBox(height: 20),
                      const Text('Name of the article', style: TextStyle()),
                      const SizedBox(height: 20),
                      FormInputField(
                        controller: controller.nameControllerEdit,
                        hintText: 'Nome completo',
                        iconUrl: "assets/images/tool.svg",
                      ),
                      const SizedBox(height: 20),
                      // ... (Other fields)
                      const Text(
                        'Choose the article either a tools or material',
                        style: TextStyle(/* ... */),
                      ),
                      const SizedBox(height: 20),
                      CustomDropdownField(
                        // Note: You need to ensure CustomDropdownField uses the controller value
                        label: CustomText.registrationType,
                        selectedValue: controller
                            .selectedTypeEdit
                            .value, // 👈 Use the controller's observable value
                        options: ["Ferramentas", "Materiais"],
                        customIcon: const Icon(
                          Icons.verified_user,
                          color: CustomColor.hintText,
                        ),
                        onChanged: (String newValue) {
                          controller.selectedType.value = newValue;
                        },
                      ),
                      const SizedBox(height: 20),
    
                      // ... Quantity, Price, Description fields ...
                      const Text('Quantity', style: TextStyle(/* ... */)),
                      const SizedBox(height: 20),
                      FormInputField(
                        controller: controller.quantityControllerEdit,
                        hintText: 'How many items you have',
                        iconUrl: "assets/images/price.svg",
                        iconWidth: 14,
                      ),
                      const SizedBox(height: 20),
                      const Text('Price', style: TextStyle(/* ... */)),
                      const SizedBox(height: 20),
                      FormInputField(
                        controller: controller.priceControllerEdit,
                        hintText: 'Enter price',
                        iconUrl: "assets/images/price.svg",
                        iconWidth: 14,
                      ),
                      const SizedBox(height: 20),
                      const Text('Description', style: TextStyle(/* ... */)),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 97,
                        child: FormInputField(
                          controller: controller.descriptionControllerEdit,
                          hintText: 'Enter price',
                          iconUrl: "assets/images/price.svg",
                          iconWidth: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => CustomButton(
                          // 👈 UPDATED BUTTON TEXT
                          text: CustomText.update,
                          isLoading: controller.isCreateItemLoading.value,
                          onPressed: () async {
                            controller.updateItem(context, "${itemId.slug}");
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
    );
  }

  // ... (other classes like _RemoteImagePreviewContainer, _LocalImagePreviewContainer, etc.)

  Widget _buildImageSlotWidget(
    int index,
    VendorFormController controller,
    List<dynamic> allImages,
    int maxItems,
    double spacing,
  ) {
    // 1. Get the current image count (remote URLs + new Files)
    final int currentImageCount = allImages.length;

    // Check if this slot contains an actual image (remote or local)
    if (index < currentImageCount) {
      final image = allImages[index];

      // Determine the type and return the correct preview widget
      Widget previewWidget;

      if (image is String) {
        // Existing remote image (String URL)
        previewWidget = _RemoteImagePreviewContainer(
          imageUrl: image,
          onRemove: () => controller.removeExistingImage(image),
          height: 60,
        );
      } else if (image is File) {
        // Newly picked local image (File object)
        previewWidget = _LocalImagePreviewContainer(
          file: image,
          onRemove: () => controller.removeImage(image),
          height: 60,
        );
      } else {
        // Fallback: Should not be reached if allImages only contains String or File
        previewWidget = const SizedBox.shrink();
      }

      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: index < maxItems - 1 ? spacing : 0),
          child: previewWidget,
        ),
      );

      // 2. Check if this slot should be the ADD button
    } else if (index == currentImageCount && currentImageCount < maxItems) {
      // This is the first empty slot, so it becomes the ADD button
      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: index < maxItems - 1 ? spacing : 0),
          child: _AddImageButton(onTap: controller.pickImages, height: 60),
        ),
      );

      // 3. This slot is an empty placeholder
    } else {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: index < maxItems - 1 ? spacing : 0),
          child: Container(),
        ),
      );
    }
  }
}

// ---------------------------------------------------
// Add new Image Preview Widget for remote images
// ---------------------------------------------------

class _RemoteImagePreviewContainer extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onRemove;
  final double height;

  const _RemoteImagePreviewContainer({
    required this.imageUrl,
    required this.onRemove,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.5),
        // Use a NetworkImage for existing images
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
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
// Renamed the original local image container for clarity
// The original widget for showing a local File:

class _LocalImagePreviewContainer extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;
  final double height;

  const _LocalImagePreviewContainer({
    required this.file,
    required this.onRemove,
    this.height = 60,
    // Add required super.key here if needed: required super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.5),
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

// Your existing _RemoteImagePreviewContainer is fine:

// Your existing _AddImageButton is fine:
class _AddImageButton extends StatelessWidget {
  final VoidCallback onTap;
  final double height;

  const _AddImageButton({required this.onTap, this.height = 60});

  @override
  Widget build(BuildContext context) {
    // 👈 THIS WAS LIKELY MISSING
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF16577F),
          borderRadius: BorderRadius.circular(4.5),
          border: Border.all(width: 0.89, color: const Color(0x0D000000)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomImageView(
            height: 17,
            width: 17,
            imagePath: "assets/images/add.svg",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
