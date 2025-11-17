import 'package:flutter/material.dart';
import 'package:queroobras_mobile/mvvm/const/custom_image_view.dart';

class ServiceProviderReview extends StatelessWidget {
  const ServiceProviderReview({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reviews = [
      {
        'name': 'David Lion',
        'avatar': 'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/b1eaac0227aee86230a8efdedb0e1c4cf5849bb5?placeholderIfAbsent=true',
        'rating': 2,
        'text': 'Your service was good but i noticed that you didn\'t finished on the expected time.',
      },
      {
        'name': 'Brooklyn Simmons',
        'avatar': 'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/b1eaac0227aee86230a8efdedb0e1c4cf5849bb5?placeholderIfAbsent=true',
        'rating': 2,
        'text': 'Your service was good but i noticed that you didn\'t finished on the expected time.',
      },
      {
        'name': 'Floyd Miles',
        'avatar': 'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/b1eaac0227aee86230a8efdedb0e1c4cf5849bb5?placeholderIfAbsent=true',
        'rating': 2,
        'text': 'Your service was good but i noticed that you didn\'t finished on the expected time.',
      },
      {
        'name': 'Savannah Nguyen',
        'avatar': 'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/b1eaac0227aee86230a8efdedb0e1c4cf5849bb5?placeholderIfAbsent=true',
        'rating': 2,
        'text': 'Your service was good but i noticed that you didn\'t finished on the expected time.',
      },
      {
        'name': 'Marvin McKinney',
        'avatar': 'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/b1eaac0227aee86230a8efdedb0e1c4cf5849bb5?placeholderIfAbsent=true',
        'rating': 2,
        'text': 'Your service was good but i noticed that you didn\'t finished on the expected time.',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Column(
        children: [
          // Navigation Bar with Status Bar
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                // Background blur effect
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.0),
                    ),
                    child: Container(
                      height: 56,
                    ),
                  ),
                ),
                // Status Bar
              ],
            ),
          ),

          // Navigation Header
          const NavigationHeader(),

          // Reviews Section
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            margin: const EdgeInsets.only(top: 43),
            child: Column(
              children: reviews.map((review) => ReviewCard(
                customerName: review['name'],
                avatarUrl: review['avatar'],
                rating: review['rating'],
                reviewText: review['text'],
              )).toList(),
            ),
          ),
        ],
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
  final int rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 1),
          child: CustomImageView(imagePath:
            index < rating
                ? 'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/54409e2e0b395cdfc88c19a769886092cba49227?placeholderIfAbsent=true'
                : 'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/e433c28472ee75cbce2c2c55475dc2d5ee312676?placeholderIfAbsent=true',
            width: 24,
            height: 24,
          ),
        );
      }),
    );
  }
}

class NavigationHeader extends StatelessWidget {
  const NavigationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      margin: const EdgeInsets.only(top: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomImageView(imagePath:
              'https://api.builder.io/api/v1/image/assets/4495d4efdd6e4cd5855f0b01e1944c13/e9f990078ea3a5ddcf8edd0be204095ae69da213?placeholderIfAbsent=true',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 23),
              const Text(
                'Review',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
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
