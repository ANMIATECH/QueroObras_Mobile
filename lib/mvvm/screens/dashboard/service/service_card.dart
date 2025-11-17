import 'package:flutter/material.dart';
import 'package:queroobras_mobile/mvvm/const/custom_image_view.dart';

class SServiceCard extends StatelessWidget {
  final String? imageUrl;
  final String? iconUrl;
  final String text;
  final bool isSpecial;
  final Color? backgroundColor;
  final Color? textColor;
  final double width;

  const SServiceCard({
    super.key,
    this.imageUrl,
    this.iconUrl,
    required this.text,
    this.isSpecial = false,
    this.backgroundColor,
    this.textColor,
    this.width = 89,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: backgroundColor ?? const Color(0xFFF4F3F3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CustomImageView(
                imagePath: imageUrl!,
                width: width,
                height: width * 0.6,
                fit: BoxFit.contain,
              ),
            ),
          if (iconUrl != null)
            CustomImageView(
              height: 24,
              width: 24,
              imagePath: iconUrl!,
            ),
          const SizedBox(height: 6),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSpecial ? (text.contains('agora') ? 14 : 12) : 12,
              color: textColor ?? Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: 'Josefin Sans',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}


class FilterChipWidget extends StatelessWidget {
  final String text;
  final double? width;

  const FilterChipWidget({
    super.key,
    required this.text,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFEEEEEE),
      ),
      padding: const EdgeInsets.symmetric( vertical: 9),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF16577F),
          fontWeight: FontWeight.w400,
          fontFamily: 'Josefin Sans',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
