import 'package:queroobras_mobile/mvvm/const/export.dart';

class MessageBubble extends StatelessWidget {
  final String messageType; // "text", "audio", "file", "image"
  final String message;
  final bool isMe;
  final String timestamp;
  final bool isRead;
  final String? avatarUrl;
  final String? duration; // for audio
  final double? progress; // for audio

  const MessageBubble({
    super.key,
    required this.messageType,
    required this.message,
    required this.isMe,
    required this.timestamp,
    required this.isRead,
    this.avatarUrl,
    this.duration,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    Widget messageWidget;

    switch (messageType) {
      case "audio":
        messageWidget = _buildAudioMessage();
        break;
      case "file":
        messageWidget = _buildFileMessage();
        break;
      case "image":
        messageWidget = _buildImageMessage();
        break;
      default:
        messageWidget = _buildTextMessage();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe && avatarUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CustomImageView(
                      imagePath: avatarUrl!,
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Flexible(child: messageWidget),
            ],
          ),
          if (messageType != "image") ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: isMe
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (isMe)
                  Icon(
                    isRead ? Icons.done_all : Icons.check,
                    size: 16,
                    color: isRead ? Colors.blue : Colors.grey,
                  ),
                const SizedBox(width: 5),
                Text(
                  timestamp,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // 🟣 TEXT MESSAGE
  Widget _buildTextMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFF16577F) : const Color(0xFFF4F3F3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 10 : 0),
          topRight: Radius.circular(isMe ? 0 : 10),
          bottomLeft: const Radius.circular(10),
          bottomRight: const Radius.circular(10),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isMe ? Colors.white : Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          fontFamily: 'Josefin Sans',
        ),
      ),
    );
  }

  // 🟢 AUDIO MESSAGE
  Widget _buildAudioMessage() {
    return Container(
      width: 240,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFF16577F) : const Color(0xFFF4F3F3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 10 : 0),
          topRight: Radius.circular(isMe ? 0 : 10),
          bottomLeft: const Radius.circular(10),
          bottomRight: const Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: isMe ? Colors.white : Colors.black,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: isMe
                        ? Colors.white.withValues(alpha: 0.4)
                        : Colors.black26,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress ?? 0.4,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: isMe ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            duration ?? "0:20",
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // 🟡 FILE MESSAGE
  Widget _buildFileMessage() {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFF16577F) : const Color(0xFFF4F3F3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 10 : 0),
          topRight: Radius.circular(isMe ? 0 : 10),
          bottomLeft: const Radius.circular(10),
          bottomRight: const Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.mail_outline,
            color: isMe ? Colors.white : Colors.black,
            size: 28,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Josefin Sans',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🖼️ IMAGE MESSAGE
  Widget _buildImageMessage() {
    return Container(
      margin: isMe
          ? const EdgeInsets.only(left: 151.613)
          : const EdgeInsets.only(right: 151.613),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.43),
              topRight: Radius.circular(20.43),
              bottomLeft: Radius.circular(20.43),
              bottomRight: Radius.circular(20.43),
            ),
            child: CustomImageView(
              imagePath: message,
              width: 245,
              height: 206,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (isMe) _buildCheckMarks(isRead),
              const SizedBox(width: 8),
              Text(
                timestamp,
                style: const TextStyle(
                  color: Color(0x66000000),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Josefin Sans',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ Checkmark builder for images
  static Widget _buildCheckMarks(bool isRead) {
    return Icon(
      isRead ? Icons.done_all : Icons.check,
      size: 16,
      color: isRead ? Colors.blue : Colors.grey,
    );
  }
}

class CheckMarksPainter extends CustomPainter {
  final bool isRead;

  CheckMarksPainter({required this.isRead});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isRead ? const Color(0xFF6EB954) : const Color(0xFFA2A2A2)
      ..strokeWidth = 0.998101
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round;

    final path1 = Path();
    path1.moveTo(6.98688, 11.4783);
    path1.lineTo(11.731, 15.9697);
    path1.lineTo(20.6921, 6.98683);

    final path2 = Path();
    path2.moveTo(10.4639, 11.4783);
    path2.lineTo(15.208, 15.9697);
    path2.lineTo(24.1691, 6.98682);

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isRecording;
  final VoidCallback? onEmojiTap;
  final VoidCallback? onCameraTap;
  final VoidCallback? onMicTap;
  final VoidCallback? onSendTap;

  const ChatInput({
    super.key,
    required this.controller,
    this.isRecording = false,
    this.onEmojiTap,
    this.onCameraTap,
    this.onMicTap,
    this.onSendTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 21, 20, 28),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0x99F3F2F2),
          borderRadius: BorderRadius.circular(25.36),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              // GestureDetector(
              //   onTap: onEmojiTap,
              //   child: CustomImageView(
              //     imagePath: CustomImage.emoji,
              //   ),
              // ),
              // const SizedBox(width: 18),

              // 📝 Text input field
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Write here...',
                    hintStyle: TextStyle(
                      color: Color(0x664C4C4C),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // 📸 Camera button
              // GestureDetector(
              //   onTap: onCameraTap,
              //   child: CustomImageView(
              //     imagePath: CustomImage.inputCamera,
              //   ),
              // ),

              // const SizedBox(width: 12),

              // // 🎤 Mic button (toggled state)
              // GestureDetector(
              //   onTap: onMicTap,
              //   child: Icon(
              //     Icons.mic,
              //     size: 24,
              //     color: isRecording
              //         ? const Color(0xFF6EB954)
              //         : const Color(0xFF6EB954),
              //   ),
              // ),
              // const SizedBox(width: 12),

              // 📩 Send button
              GestureDetector(
                onTap: () {
                  if (controller.text.trim().isNotEmpty) {
                    onSendTap?.call();
                  }
                },
                child: CustomImageView(imagePath: CustomImage.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
