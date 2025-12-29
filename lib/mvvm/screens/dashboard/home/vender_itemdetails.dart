import '../../../const/export.dart';

class VenderItemDetails extends StatelessWidget {
  const VenderItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth <= 640;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Item details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            fontFamily: 'Josefin Sans',
            height: 1,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: screenHeight,
        child: Stack(
          children: [
            // Main content
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: isSmallScreen ? 375 : 440,
                  minHeight: screenHeight,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 10 : 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image container
                    Container(
                      width: double.infinity,
                      height: 406,
                      margin: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 20,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 45 : 89,
                        vertical: isSmallScreen ? 20 : 33,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: CustomImageView(
                          imagePath: 'assets/images/cement.png',
                          width: isSmallScreen ? 180 : 221,
                          height: isSmallScreen ? 280 : 340,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Title section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 20,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Título',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              height: 24 / 16,
                            ),
                          ),
                          SizedBox(width: 8),
                          EditIconButton(size: 16),
                        ],
                      ),
                    ),
    
                    SizedBox(height: 6),
    
                    // Legend section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 20,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Legenda',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withValues(alpha: 0.3),
                              height: 24 / 14,
                            ),
                          ),
                          SizedBox(width: 5),
                          EditIconButton(size: 16),
                        ],
                      ),
                    ),
    
                    SizedBox(height: 13),
    
                    // Price section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 20,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 113,
                            height: 31,
                            child: Text(
                              '\$20.00',
                              style: TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF9761E),
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          EditIconButton(size: 16),
                        ],
                      ),
                    ),
    
                    SizedBox(height: 20),
    
                    // Stock availability section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Available in stock :',
                                style: TextStyle(
                                  fontFamily: 'Josefin Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  height: 24 / 14,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                '5 items',
                                style: TextStyle(
                                  fontFamily: 'Josefin Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF9761E),
                                  height: 24 / 14,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          EditIconButton(size: 24),
                        ],
                      ),
                    ),
    
                    SizedBox(height: 10),
    
                    // Description section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              height: 24 / 20,
                            ),
                          ),
                          SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EditIconButton(size: 24),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'Cement from Brazil, this is a good quality of cement rated as the highest cement in brazil.',
                                  style: TextStyle(
                                    fontFamily: 'Josefin Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFA2A2A2),
                                    height: 24 / 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
    
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 20,
                        vertical: 20,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF9761E),
                          borderRadius: BorderRadius.circular(217.391),
                        ),
                        child: Center(
                          child: Text(
                            'Publish',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 24 / 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditIconButton extends StatelessWidget {
  final double size;
  final VoidCallback? onTap;

  const EditIconButton({super.key, required this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: CustomImageView(imagePath: "assets/images/edit.svg"),
      ),
    );
  }
}
