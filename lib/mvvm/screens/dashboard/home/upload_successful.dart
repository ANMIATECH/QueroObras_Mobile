import '../../../const/export.dart';

class UploadSuccessScreen extends StatelessWidget {
  const UploadSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              // Main content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 19, top: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),

                      // Success icon
                      Container(
                        margin: const EdgeInsets.only(top: 75),
                        child: CustomImageView(
                          imagePath: "assets/images/success_check.svg",
                          width: 160,
                          height: 160,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Success message
                      Container(
                        width: 291,
                        margin: const EdgeInsets.only(top: 74),
                        child: const Text(
                          'Seus itens foram carregados com sucesso',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Josefin Sans',
                            height: 1.65,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Spacer to push button to bottom
                      const Spacer(),

                      // Go to home button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: CustomButton(
                          text: 'Ir para a página inicial',
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
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
    );
  }
}
