import 'package:flutter/material.dart';

class ApprovalDialog extends StatelessWidget {
  final VoidCallback? onApprove;
  final VoidCallback? onDeny;

  const ApprovalDialog({
    super.key,
    this.onApprove,
    this.onDeny,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 440),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Color(0xFFF9761E),
      ),
      padding: const EdgeInsets.fromLTRB(20, 34, 20, 34),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icon/Image
          Center(
            child: Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/935f19edc3ff37deacedf6d12f5a88aa4cc4124e?placeholderIfAbsent=true',
                width: 54,
                height: 54,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.email,
                      color: Color(0xFFF9761E),
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 17),

          // Description Text
          Text(
            'This email is used to login the app if you want to change it. the new email will be used as your primary login.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 24 / 14,
              fontFamily: 'Josefin Sans',
            ),
          ),

          const SizedBox(height: 54),

          // I Approve Button
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: const Color(0xFF16577F),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: onApprove,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(70, 12, 70, 12),
                  child: Text(
                    'I Approve',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 24 / 14,
                      fontFamily: 'Josefin Sans',
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // I Deny Button
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: onDeny,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(70, 12, 70, 12),
                  child: Text(
                    'I Deny',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 24 / 14,
                      fontFamily: 'Josefin Sans',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
