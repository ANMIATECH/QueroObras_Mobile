import '../../../controller/profile_controller.dart';
import '/mvvm/const/export.dart';

class ServiceProviderReview extends StatelessWidget {
  final int? userId;

  const ServiceProviderReview({super.key,  this.userId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController(initialUserId: userId)); // GetX controller

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
        title: const Text(
          'Avaliações',
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
      body: Obx(() {
        if (controller.ratingsList.isEmpty) {
          return const Center(child: Text("Nenhuma avaliação disponível"));
        }
        return ListView.builder(
          itemCount: controller.ratingsList.length,
          itemBuilder: (context, index) {
            final rating = controller.ratingsList[index];
            return ReviewCard(
              customerName: rating.rater?.name ?? "",
              avatarUrl: rating.rater?.profile?.avatar ?? "",
              rating: int.tryParse(rating.stars ?? "0") ?? 0,
              reviewText: rating.comment ?? "",
            );
          },
        );
      })
      ,
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
      padding: const EdgeInsets.all(16),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        customerName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: 'Josefin Sans',
                        ),
                      ),
                    ],
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
