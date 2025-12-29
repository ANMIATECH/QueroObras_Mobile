import '../../const/export.dart';

class RequestService extends StatelessWidget {
  const RequestService({super.key, required this.serviceProviderId});
  final String serviceProviderId;

  @override
  Widget build(BuildContext context) {
    final ServiceController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
    
        title: const Text(
          'Request',
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
                        'Upload the picture (optional)',
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
                        'Address',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormInputField(
                        controller: controller.addressRequest,
                        hintText: 'Address',
                        iconUrl: "assets/images/tool.svg",
                      ),
    
                      const SizedBox(height: 20),
    
                      const Text(
                        'What service do you want to make?',
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
                          controller: controller.serviceToMake,
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
                            hintText: 'Write here',
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
                            controller.sendRequest(
                              context,
                              serviceProviderId,
                            );
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
