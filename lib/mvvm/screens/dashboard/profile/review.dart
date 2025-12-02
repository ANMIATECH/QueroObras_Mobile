import '/mvvm/const/export.dart';

class ServiceProviderReview extends StatelessWidget {
  const ServiceProviderReview({super.key});

  @override
  Widget build(BuildContext context) {
    // Example review data (Brazil Portuguese)
    final List<Map<String, dynamic>> reviews = [
      {
        'name': 'David Lion',
        'avatar':
        'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/b1eaac0227aee86230a8efdedb0e1c4cf5849bb5?placeholderIfAbsent=true',
        'rating': 2,
        'text':
        'Seu serviço foi bom, mas percebi que você não terminou no tempo esperado.',
      },
      {
        'name': 'Brooklyn Simmons',
        'avatar':
        'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/b1eaac0227aee86230a8efdedb0e1c4cf5849bb5?placeholderIfAbsent=true',
        'rating': 4,
        'text':
        'Excelente trabalho! Fiquei muito satisfeito com o serviço.',
      },
      {
        'name': 'Floyd Miles',
        'avatar':
        'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/b1eaac0227aee86230a8efdedb0e1c4cf5849bb5?placeholderIfAbsent=true',
        'rating': 3,
        'text': 'O serviço foi bom, mas ainda há espaço para melhorias.',
      },
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
          ),
          title: const Text(
            'Avaliações', // 🇧🇷 translated
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: 'Josefin Sans',
              height: 0.75,
            ),
          ),
          centerTitle: false,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          itemCount: 8,
          itemBuilder: (context, index) {
            final review = reviews[index % reviews.length];
            return ReviewCard(
              customerName: review['name'],
              avatarUrl: review['avatar'],
              rating: review['rating'],
              reviewText: review['text'], // Already translated
            );
          },
        ),
      ),
    );
  }
}


class ReviewCard extends StatelessWidget {
  final String customerName;
  final String avatarUrl;
  final int rating;
  final String reviewText;

  const ReviewCard({
    super.key,
    required this.customerName,
    required this.avatarUrl,
    required this.rating,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFFF3EA),
        border: Border.all(
          color: const Color(0xFFFFE0C9),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(23, 8, 80, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info section
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CustomImageView(imagePath:
                  avatarUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 9),
              SizedBox(
                width: 84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: 'Josefin Sans',
                        height: 1.5,
                      ),
                    ),
                    const Text(
                      'customer',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'Josefin Sans',
                        height: 1.71,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Star rating
          Container(
            margin: const EdgeInsets.only(top: 7),
            child: StarRating(rating: rating),
          ),
          // Review text
          Container(
            margin: const EdgeInsets.only(top: 11),
            child: Text(
              reviewText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontFamily: 'Josefin Sans',
                height: 1.71,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class StarRating extends StatelessWidget {
  final int rating; // Rating from 0 to 5

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 24,
          ),
        );
      }),
    );
  }
}
