import '../../const/export.dart';

class CNPJProfileUploadScreen extends StatelessWidget {
  const CNPJProfileUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // final screenWidth = MediaQuery.of(context).size.width;
    // final isSmallScreen = screenWidth <= 640;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
      
              // ✔ Profile Picture Picker
              GestureDetector(
                onTap: () => controller.pickProfileImage(),
                child: Obx(() {
                  return Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFF16577F),
                        shape: BoxShape.circle,
                        image: controller.profileImage.value != null
                            ? DecorationImage(
                          image:
                          FileImage(controller.profileImage.value!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: controller.profileImage.value == null
                          ? const Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 74,
                          color: Colors.white,
                        ),
                      )
                          : null,
                    ),
                  );
                }),
              ),
      
              const SizedBox(height: 20),
      
              const Text(
                'Envie sua foto de perfil',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Josefin Sans',
                ),
                textAlign: TextAlign.center,
              ),
      
              const SizedBox(height: 40),
      
              // ✔ Document Upload
              GestureDetector(
                onTap: () => controller.pickCnpjDocumentImage(),
                child: Obx(() {
                  return Container(
                    width: double.infinity,
                    height: 171,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16577F),
                      borderRadius: BorderRadius.circular(10),
                      image: controller.cnpjDocumentImage.value != null
                          ? DecorationImage(
                        image: FileImage(
                            controller.cnpjDocumentImage.value!),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: controller.cnpjDocumentImage.value == null
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CustomPaint(
                              painter: UploadIconPainter(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Envie o documento do CNPJ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Josefin Sans',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                        : null,
                  );
                }),
              ),
      
              const Spacer(),
      
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 30),
                child: CustomButton(
                  text: 'Continuar',
                  isLoading: controller.isLoading.value,
                  onPressed: () async {
                    if (controller.profileImage.value == null ||
                        controller.cnpjDocumentImage.value == null) {
                      Get.snackbar(
                        "Erro",
                        "Por favor, envie a foto de perfil e o documento",
                      );
                      return;
                    }
      
                    await controller.uploadProfilePicNDocCnpj(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final _ = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw upload arrow
    final path = Path();

    // Arrow shaft (vertical line)
    path.moveTo(size.width / 2, size.height * 0.625); // 15
    path.lineTo(size.width / 2, size.height * 0.375); // 9

    // Left arrow head
    path.moveTo(size.width * 0.3125, size.height * 0.375); // 7.5, 9
    path.lineTo(size.width / 2, size.height * 0.1875); // 12, 4.5

    // Right arrow head
    path.moveTo(size.width * 0.6875, size.height * 0.375); // 16.5, 9
    path.lineTo(size.width / 2, size.height * 0.1875); // 12, 4.5

    canvas.drawPath(path, strokePaint);

    // Draw bottom line
    final bottomLinePath = Path();
    bottomLinePath.moveTo(size.width * 0.25, size.height * 0.792); // 6, 19
    bottomLinePath.lineTo(size.width * 0.75, size.height * 0.792); // 18, 19

    canvas.drawPath(bottomLinePath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
