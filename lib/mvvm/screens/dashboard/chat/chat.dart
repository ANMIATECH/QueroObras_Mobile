import 'package:queroobras_mobile/mvvm/const/export.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Chat Title
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 400),
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  SizedBox(
                    width: 122,
                    child: const Text(
                      'Chat',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Chat Messages List
            FutureBuilder(
              future: controller.getAllChat(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting &&
                    controller.chatModel.value.data == null) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: controller.chatModel.value.data?.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        var ddd = controller.chatModel.value.data?[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 11.0,
                            left: 16,
                            right: 16,
                          ),
                          child: ChatMessageCard(
                            avatarUrl: "${ddd?.receiver?.profile?.avatar}",
                            username: "${ddd?.receiver?.name}",
                            status: '',
                            message: "${ddd?.latestMessage}",
                            onTap: () {
                              Get.to(
                                () => OneOnOneChat(
                                  id: '${ddd?.receiver?.profile?.id}',
                                  userName: '${ddd?.receiver?.name}',
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
