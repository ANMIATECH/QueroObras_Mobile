import 'package:queroobras_mobile/mvvm/const/export.dart';

class OneOnOneChat extends StatelessWidget {
  const OneOnOneChat({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final TextEditingController controller = TextEditingController();
    bool isRecording = false;

    void handleSend() {
      final message = controller.text.trim();
      if (message.isNotEmpty) {
        debugPrint('Sending message: $message');
        controller.clear();
      }
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header
            _buildHeader(context),

            // Messages
            Expanded(
              child: _buildMessagesList(scrollController),
            ),

            // Input Field
             ChatInput(controller: controller,
               isRecording: isRecording,
               onEmojiTap: () => debugPrint('Emoji tapped'),
               onCameraTap: () => debugPrint('Camera tapped'),
               onMicTap: () {},
               onSendTap: handleSend,),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 33),
          const Text(
            'David',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Messages List
  Widget _buildMessagesList(ScrollController scrollController) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: const [
        MessageBubble(
          messageType: "text",
          message:
          "Oi técnico, estou com um problema urgente e preciso da sua ajuda imediatamente.",
          isMe: true,
          timestamp: "Jan 23 ::: 8:35 Am",
          isRead: true,
        ),
        SizedBox(height: 17),

        MessageBubble(
          messageType: "text",
          message:
          "Oi, não se preocupe, estou aqui. Me conte qual é a sua situação.",
          isMe: false,
          timestamp: "Jan 23 ::: 8:37 Am",
          isRead: false,
          avatarUrl:
          "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=2340",
        ),
        SizedBox(height: 17),

        MessageBubble(
          messageType: "audio",
          message: "",
          isMe: true,
          timestamp: "Jan 23 ::: 8:38 Am",
          isRead: true,
          duration: "0:20",
          progress: 0.3,
        ),
        SizedBox(height: 17),

        MessageBubble(
          messageType: "file",
          message: "Arquivo de diagnóstico enviado.",
          isMe: false,
          timestamp: "Jan 23 ::: 8:40 Am",
          isRead: true,
          avatarUrl:
          "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=2340",
        ),
        SizedBox(height: 17),

        MessageBubble(
          messageType: "text",
          message: "Tudo certo, problema resolvido!",
          isMe: true,
          timestamp: "Jan 23 ::: 8:45 Am",
          isRead: true,
        ),
        SizedBox(height: 20),
        MessageBubble(
          messageType: "image",
          message:
          "assets/images/chat_image.png",
          isMe: true,
          timestamp: "Jan 23 ::: 8:35 Am",
          isRead: true,
        )

      ],
    );
  }

}


