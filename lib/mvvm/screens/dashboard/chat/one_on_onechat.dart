import 'package:queroobras_mobile/mvvm/const/export.dart';

class OneOnOneChat extends StatefulWidget {
  final String id;
  final String userName;

  const OneOnOneChat({
    super.key,
    required this.id,
    this.userName = "Conversa",
  });

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
    print(widget.id);
    chatController.getAllChatOneOnOne(widget.id);
    chatController.startPolling(widget.id);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (chatController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages =
                    chatController.chatModel.value.data ?? [];

                /// EMPTY CHAT STATE
                if (messages.isEmpty) {
                  return Center(
                    child: Text(
                      'Ainda não há nenhuma conversa com este usuário.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                _scrollToBottom();

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];

                    /// If sender_id != chat partner ID → it's me
                    final bool isMe =
                        msg.senderId.toString() != widget.id;

                    return MessageBubble(
                      message: msg.message ?? "",
                      isMe: isMe,
                      timestamp: msg.createdAt
                          ?.toLocal()
                          .toString()
                          .substring(11, 16) ??
                          "",
                      isRead: msg.isRead == "1",
                      messageType: 'text',
                    );
                  },
                );
              }),
            ),

            /// INPUT
            ChatInput(
              controller: productController.controller,
              isRecording: productController.isRecording,
              onEmojiTap: () => debugPrint('Emoji tapped'),
              onCameraTap: () => debugPrint('Camera tapped'),
              onMicTap: () {},
              onSendTap: () =>
                  productController.handleSend(widget.id),
            ),
          ],
        ),
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

