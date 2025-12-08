import '../../../const/export.dart';

// Assuming you pass the item ID when navigating to this screen
class ApproveRequest extends StatelessWidget {
  const ApproveRequest({super.key, this.dd});
  final DatumCpnf? dd;

  // We reuse the same controller, but we now need to retrieve it by type

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,

          title: Text(
            // 👈 UPDATED TITLE
            'Service provider',
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
                          'What is the price ?',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 20),
                        FormInputField(
                          controller: controller.requestPricing,
                          hintText: '2000',
                          iconUrl: "assets/images/tool.svg",
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 97,
                          child: FormInputField(
                            controller: controller.notePricing,
                            hintText: 'Enter Note',
                            iconUrl: "assets/images/price.svg",
                            iconWidth: 14,
                          ),
                        ),

                        const SizedBox(height: 20),
                        Obx(
                          () => CustomButton(
                            // 👈 UPDATED BUTTON TEXT
                            text: CustomText.update,
                            isLoading: controller.approveRequestIsLoading.value,
                            onPressed: () async {
                              controller.approveRequest(id: "${dd?.slug}");
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
