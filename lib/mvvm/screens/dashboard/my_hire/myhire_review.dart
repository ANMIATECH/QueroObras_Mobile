import 'package:queroobras_mobile/mvvm/const/export.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyHireReview extends StatelessWidget {
  final VoidCallback? onSubmit;
  final TextEditingController textController = TextEditingController();

  MyHireReview({super.key, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
        ),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                SizedBox(width: 40,),
                IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: Icon(Icons.close_rounded)),
              ],
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 65, 20, 20),
              child: Column(
                children: [
                  // Profile and Rating Section
                  Column(
                    children: [
                      // Profile Image
                      Container(
                        width: 189,
                        height: 189,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: CustomImageView(
                          imagePath: "assets/images/profile_dummy.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 21),
                      // RatingBar
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 24,
                        itemPadding: const EdgeInsets.symmetric(
                          horizontal: 3.0,
                        ),
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.orange),
                        onRatingUpdate: (rating) {
                          print('Rating: $rating');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Text Input Area
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF1F1F1),
                    ),
                    padding: const EdgeInsets.fromLTRB(17, 13, 17, 13),
                    child: TextField(
                      controller: textController,
                      style: const TextStyle(
                        color: Color(0xFF787878),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Josefin Sans',
                        height: 2.36,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Escreva aqui',
                        hintStyle: TextStyle(
                          color: Color(0xFF787878),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Josefin Sans',
                          height: 2.36,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Submit Button
                  CustomButton(text: "Enviar", onPressed: () async {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
