import '../../../const/export.dart';


class SellerProgressTracking extends StatelessWidget {
  const SellerProgressTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( title: Text(
        "Meu pedidos",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          fontFamily: 'Josefin Sans',
          height: 1,
        ),
      ),
        backgroundColor: Colors.white,
        elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 35),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  color: const Color(0xFFF5F5F5),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 39, left: 80, right: 80, bottom: 5),
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 170,
                            child: Column(
                              children: [
                                Expanded(
                                  child: CustomImageView(imagePath:
                                  'assets/images/cement.png',
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: 94,
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            'Título',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Josefin Sans',
                                              color: Colors.black,
                                              height: 37 / 20,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const Text(
                                            'Legenda',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Josefin Sans',
                                              color: Colors.black,
                                              height: 37 / 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '\$180',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Josefin Sans',
                                              color: Colors.black,
                                              height: 1.5,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            '3 items',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Josefin Sans',
                                              color: Colors.black,
                                              height: 1.5,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 44),
              ProgressTracker(currentStatus: 'Em Verificação'),
              const SizedBox(height: 36),
              CustomButton(
                text: CustomText.updateStatus,
                onPressed: () async {
                  // Navigator.of(
                  //   context,
                  // ).pushNamed(AppRoutes.progressTracker);
                },
              ),

              const SizedBox(height: 37),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressTracker extends StatelessWidget {
  final String currentStatus;

  const ProgressTracker({super.key, required this.currentStatus});

  static const List<String> statuses = [
    'Em Embalagem',           // Packaging
    'Em Trânsito',            // In Road
    'Em Verificação',         // In Checking
    'Revisando Pacote',       // In Reviewing package
    'A Caminho de Envio',     // In your way to be shipped
    'Entregue',               // Deliver
  ];

  @override
  Widget build(BuildContext context) {
    final int activeIndex = statuses.indexOf(currentStatus);

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: List.generate(statuses.length, (index) {
          final isActive = index <= activeIndex;
          final isLast = index == statuses.length - 1;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left dot + line
              Column(
                children: [
                  // Dot
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? const Color(0xFF16577F) : Colors.grey.shade300,
                    ),
                  ),
                  // Line connecting to next dot
                  if (!isLast)
                    Container(
                      width: 4,
                      height: 40,
                      color: isActive ? const Color(0xFF16577F) : Colors.grey.shade300,
                    ),
                ],
              ),
              const SizedBox(width: 12),
              // Status text
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    statuses[index],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Josefin Sans',
                      color: isActive ? Colors.black : const Color(0xFFABABAB),
                    ),
                  ),
                ),
              ),
              // Right check dot
              Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(top: 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? const Color(0xFF16577F) : Colors.grey.shade300,
                ),
                child: isActive
                    ? const Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                )
                    : null,
              ),
            ],
          );
        }),
      ),
    );
  }
}

