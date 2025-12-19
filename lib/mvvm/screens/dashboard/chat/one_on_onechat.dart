import 'package:queroobras_mobile/mvvm/const/export.dart';
// import 'package:queroobras_mobile/mvvm/const/extension.dart';

// class OneOnOneChat extends StatelessWidget {
//   const OneOnOneChat({
//     super.key,
//     required this.id,
//     this.userName = "Chat with Seller",
//   });
//   final String id;
//   final String userName;

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<ProductDetailsController>();
//     final controllerChat = Get.put(ChatController());

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             // Header
//             _buildHeader(context, userName),

//             // Messages
//             Expanded(
//               child: _buildMessagesList(
//                 controller.scrollController,
//                 controllerChat,
//                 id,
//               ),
//             ),

//             // Input Field
//             ChatInput(
//               controller: controller.controller,
//               isRecording: controller.isRecording,
//               onEmojiTap: () => debugPrint('Emoji tapped'),
//               onCameraTap: () => debugPrint('Camera tapped'),
//               onMicTap: () {},
//               onSendTap: () => controller.handleSend(id),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context, String? userName) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: const Icon(Icons.arrow_back, size: 24, color: Colors.black),
//           ),
//           const SizedBox(width: 33),
//           Text(
//             userName ?? 'David',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 24,
//               fontWeight: FontWeight.w700,
//               fontFamily: 'Josefin Sans',
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Messages List
//   Widget _buildMessagesList(
//     ScrollController scrollController,
//     ChatController controllerChat,
//     String id,
//   ) {
//     return FutureBuilder(
//       future: controllerChat.getAllChatOneOnOne(id),
//       builder: (context, asyncSnapshot) {
//         if (asyncSnapshot.connectionState == ConnectionState.waiting &&
//             controllerChat.chatModel.value.data == null) {
//           return Center(
//             child: Padding(
//               padding: EdgeInsets.all(12.0),
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//         return ListView(
//           controller: scrollController,
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           children: List.generate(
//             controllerChat.chatModel.value.data?.length ?? 0,
//             (index) {
//               var dd = controllerChat.chatModel.value.data?[index];
//               return MessageBubble(
//                 messageType: "text",
//                 message: "${dd?.message}",
//                 isMe: "${dd?.sender?.id}" == id.toString() ? true : false,
//                 timestamp: "${dd?.createdAt?.toYearMonthDay}",
//                 isRead: true,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

class OneOnOneChat extends StatefulWidget {
  final String id;
  final String userName;
  const OneOnOneChat({super.key, required this.id, this.userName = "Chat"});

  @override
  State<OneOnOneChat> createState() => _OneOnOneChatState();
}

class _OneOnOneChatState extends State<OneOnOneChat> {
  final chatController = Get.put(ChatController());
  final productController = Get.find<ProductDetailsController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initial fetch and start background sync
    chatController.getAllChatOneOnOne(widget.id);
    chatController.startPolling(widget.id);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final messages = chatController.chatModel.value.data ?? [];

              if (messages.isEmpty) {
                return const Center(child: Text("No messages yet."));
              }

              _scrollToBottom(); // Auto scroll when new messages arrive

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  // Logic: If sender_id matches the current user ID, it's 'Me'
                  // Note: Adjust 'currentUserId' to your auth storage ID
                  bool isMe = msg.senderId.toString() != widget.id;

                  return MessageBubble(
                    message: msg.message ?? "",
                    isMe: isMe,
                    timestamp:
                        msg.createdAt?.toLocal().toString().substring(11, 16) ??
                        "",
                    isRead: msg.isRead == "1",
                    messageType: 'text',
                  );
                },
              );
            }),
          ),
          ChatInput(
            controller: productController.controller,
            isRecording: productController.isRecording,
            onEmojiTap: () => debugPrint('Emoji tapped'),
            onCameraTap: () => debugPrint('Camera tapped'),
            onMicTap: () {},
            onSendTap: () => productController.handleSend(widget.id),
            //   onSendTap: () => productController.sendChatMessage(
            //   widget.id,
            //   message: productController.controller.text,
            // ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text(
        widget.userName,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
