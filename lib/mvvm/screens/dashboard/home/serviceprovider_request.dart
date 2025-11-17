import '../../../const/export.dart';

class ServiceRequestScreen extends StatelessWidget {
  const ServiceRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Request an electricista',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
              height: 1,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 70),
                child: Column(
                  children: [
                    SizedBox(
                      width: 195,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: 'assets/images/location_pointer.png',
                            width: 74,
                            height: 74,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 66),
                            child: CustomImageView(
                              imagePath: 'assets/images/location_pointer.png',
                              width: 74,
                              height: 74,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 35),
                      width: 285,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: 'assets/images/location_pointer.png',
                            width: 74,
                            height: 74,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 63),
                            child: CustomImageView(
                              imagePath: 'assets/images/location_pointer.png',
                              width: 74,
                              height: 74,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 23),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ServiceProviderCard(),
                      const SizedBox(height: 6),
                      Column(
                        children: [
                          ActionButton(
                            text: 'Start chat',
                            backgroundColor: const Color(0xFFF9761E),
                            textColor: Colors.white,
                            onPressed: () {
                              Get.toNamed(RouteNameV1.oneOnOneChat);
                            },
                          ),
                          const SizedBox(height: 10),
                          ActionButton(
                            text: 'Cancel',
                            backgroundColor: const Color(0xFFF4F3F3),
                            textColor: Colors.black,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
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

class ActionButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;

  const ActionButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 70),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textColor,
            fontFamily: 'Josefin Sans',
          ),
        ),
      ),
    );
  }
}

class ServiceProviderCard extends StatelessWidget {
  const ServiceProviderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F3F3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomImageView(
                      imagePath: 'assets/images/user.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                SizedBox(
                  width: 74,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "David",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Eletricista",
                        style: const TextStyle(
                          color: Color(0xFF7E7878),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: 'assets/images/rating.svg',
                            width: 16,
                            height: 13,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "4.5",
                            style: const TextStyle(
                              color: Color(0xFF7E7878),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Josefin Sans',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Text(
                'R\$ 50',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: 'Josefin Sans',
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Estimated arrival: 23min',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF979797),
                  fontFamily: 'Josefin Sans',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
