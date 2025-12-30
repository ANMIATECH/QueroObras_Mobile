import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Success Icon with a Circle Background
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
            ),
            const SizedBox(height: 40),

            // 2. Main Title
            const Text(
              "Pagamento realizado com sucesso!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // 3. Subtitle / Description
            const Text(
              "Seu pedido foi processado com sucesso. Agora você pode acompanhar o status do seu pedido no painel de controle.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 50),

            // 4. Action Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to the very beginning (Home)
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "De volta para casa",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
