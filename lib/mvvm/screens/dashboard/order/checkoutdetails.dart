import 'package:flutter/material.dart';
import 'package:queroobras_mobile/mvvm/const/custom_image_view.dart';

import '../../../const/export.dart';

class CheckoutNow extends StatelessWidget {
  const CheckoutNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 11, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 15),
                      _buildProductSection(),
                      const SizedBox(height: 20),
                      _buildDescriptionSection(),
                      const SizedBox(height: 20),
                      _buildTotalExpenseSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(onPressed: () {
Get.back();        },
            icon: Icon(Icons.arrow_back_outlined)),
        const SizedBox(width: 33),
        Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
          ),
        ),
      ],
    );
  }

  Widget _buildProductSection() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFEEEEEE),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Center(
                child: CustomImageView(
                  imagePath: "assets/images/cement.png",
                  width: 221,
                  height: 340,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Título',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Josefin Sans',
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Legenda',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Josefin Sans',
                      height: 24 / 14,
                    ),
                  ),
                  const SizedBox(height: 11),
                  Text(
                    '\$20.00',
                    style: TextStyle(
                      color: const Color(0xFFF9761E),
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Josefin Sans',
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 100),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Josefin Sans',
                      height: 24 / 14,
                    ),
                    children: [
                      const TextSpan(text: 'Available in stock :\n'),
                      TextSpan(
                        text: '20 quantity',
                        style: TextStyle(color: const Color(0xFFF9761E)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '1',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Josefin Sans',
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
            height: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'This product is good for construcion',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
            height: 24 / 20,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalExpenseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total expense for this article',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
            height: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 159,
          child: Column(
            children: [
              _buildExpenseRow('Price :', '\$ 20'),
              const SizedBox(height: 10),
              _buildExpenseRow('Tax :', '\$ 2.2'),
              const SizedBox(height: 10),
              _buildExpenseRow('Total :', '\$ 22.2', isTotal: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? const Color(0xFFF9761E) : Colors.black,
            fontSize: 20,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            fontFamily: 'Josefin Sans',
            height: 1.2,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? const Color(0xFFF9761E) : Colors.black,
            fontSize: 20,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            fontFamily: 'Josefin Sans',
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
