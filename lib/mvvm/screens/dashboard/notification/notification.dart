import '../../../const/export.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              width: double.infinity,
              child: Column(
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_outlined),
                        ),
                        const SizedBox(width: 33),
                        Expanded(
                          child: Container(
                            height: 34,
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Notification',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: 'Josefin Sans',
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Notifications Section
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    margin: const EdgeInsets.only(top: 44),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Service Provider Notification
                        NotificationCard(
                          title: 'Service Provider',
                          description:
                              'The service provider [username] [specialisation] accept your request and the price is [price].',
                          actions: [
                            Row(
                              children: [
                                NotificationButton(
                                  text: 'Cancel',
                                  backgroundColor: const Color(0xFFD10000),
                                  onPressed: () {},
                                ),
                                const SizedBox(width: 10),

                                NotificationButton(
                                  text: 'Pay',
                                  backgroundColor: const Color(0xFF16577F),
                                  onPressed: () {},
                                ),
                              ],
                            ),

                          ],
                        ),

                        const SizedBox(height: 15),

                        // System Update Notification
                        const NotificationCard(
                          title: '[!] New Update',
                          description:
                              'Check the new update that we share in your system.',
                        ),
                      ],
                    ),
                  ),

                  // Bottom padding
                  const SizedBox(height: 472),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget>? actions;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFFFF3EA),
        border: Border.all(color: const Color(0xFFFFE0C9), width: 1),
      ),
      padding: EdgeInsets.fromLTRB(15, 18, 15, actions != null ? 18 : 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: 'Josefin Sans',
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: 'Josefin Sans',
                  height: 1.5,
                ),
              ),
            ],
          ),
          if (actions != null) ...[
            const SizedBox(height: 43),
            Row(children: actions!),
          ],
        ],
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const NotificationButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontFamily: 'Josefin Sans',
            height: 1.7,
          ),
        ),
      ),
    );
  }
}
