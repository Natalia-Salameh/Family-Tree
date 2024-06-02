import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedFamilies extends StatelessWidget {
  final List<FeaturedFamily> families;

  const FeaturedFamilies({Key? key, required this.families}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 15, top: 15, bottom: 5),
      child: Container(
        height: 247,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: families.length,
          itemBuilder: (context, index) {
            final family = families[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed('/family-details', arguments: family);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            Image.asset(
                              family.crestImage,
                              height: 235,
                              width: 340,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              height: 235,
                              width: 380,
                              color: Colors.black.withOpacity(0.45),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    family.familyName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    family.story,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 10),
                                  // Align(
                                  //   alignment: Alignment.bottomRight,
                                  //   child: TextButton(
                                  //     onPressed: () {
                                  //       Get.toNamed('/family-details',
                                  //           arguments: family);
                                  //     },
                                  //     child: const Text(
                                  //       textAlign: TextAlign.right,
                                  //       "View More",
                                  //       style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 14,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FeaturedFamily {
  final String familyName;
  final String story;
  final String crestImage;
  final String details;

  FeaturedFamily({
    required this.familyName,
    required this.story,
    required this.crestImage,
    required this.details,
  });
}

List<FeaturedFamily> featuredFamilies = [
  FeaturedFamily(
    familyName: "Al-Shomali Family".tr,
    story: "The Shomali family came from Wadi Musa, Jordan.".tr,
    crestImage: 'assets/images/ShomaliPic.jpg', // Example crest image
    details:
        """Groups from neighboring countries began emigrating to Beit Sahour to escape religious or social persecution. Among the first were the 'Ajajia families (families of Abu Hindi and Abu Ghantur) who left the town of 'Ajajia in Wadi Musa-Jordan, where they lived in caves under the Shaheen building in the center of the town.

Shortly after the arrival of Ajajia family, Khalawi, ancestor of the Jarayseh (Salsa' and Shomali), arrived in Beit Sahour from the same area in Wadi Musa (valley of Moses). It is widely believed that he came from a village called "Sala" to the north-west of the Jordanian city of Ma'an, and that his family lived in caves under the house of Anton Yousef Abu Zuluf. It is worth mentioning that one of the Jarayseh family' branches left Beit Sahour later and lived in the Galilee - Acre, then moved to Kufur Kanna, then to Nazareth, and part of it to the east of Madaba in Jordan, whose family still live today under the name Bisharat.

In the first half of the 17th century (1630 AD), Dawoud, ancestor of Al Qazaha, fled with his family to Beit Sahour to escape religious persecution and the injustices of Turkish rule. Dawoud's family was from a village called "Qazhit El-Binit," in Wadi Musa, the remains of the Ghassanid Christian State. He lived with his family in the caves at the center of the town, where he had two sons: Habbas and Issa.

Habbas had three sons, the ancestors of the "Al-Qazaha Al-Tahata." They were:

Salem (Fr. Barnabas, the first Arab priest in Beit Sahour, ordained as a priest in 1735 AD), the ancestor of Qassis family. This priest had a son, Fr. Jiries; Fr. Jiries had a son, Fr. Khalil; and Fr. Khalil had three boys: Zacharia (ancestor of Abu Aita family), Issa (ancestor of Issa family), and Fr. Nasir, ancestor of the Khoury and Yacoub families.

It is worth mentioning that Fr. Nasir's son was the priest Nicholas; Fr. Nicholas's son was the priest Ibrahim Tanas, whose sons were Fr. Khoury (who died in Amman, Jordan) and Fr. Ibrahim, current priest at the Beit Sahour Church. Thus, Father Ibrahim is an eighth-generation descendant of Father Salem, ancestor of the Qassis family.

Zakharia, the ancestor of Abu Aita family, had three sons: Jiries, Habbas and Hanna, who are the ancestors of the main Abu Aita family' branches.

The second son of Habbas was Ibrahim, ancestor of Ibrahim family, father of Saleh.Saleh had a son, Elias, and Elias had four sons: Barhoum, Sababa, Abdullah and Saleh, ancestor of the main Ibrahim family' branches.

The third son of Habbas was Elias, who fathered three sons: Salameh (ancestor of Sous and Abdil-Masih Al-Hayik families), Hanna (ancestor of Hannouneh family), and Isaac (ancestor of Isaac family).


The other son of Dawoud (ancestor of "Al-Qazaha Al-Tahata") was Issa. Though Issa had no biological sons, he adopted a son called Msallam (ancestor of the Rishmawi family). Msallam worked for Issa as a farmer after he had fled from an area in Syria called "Rashma." Msallam married Issa's daughter, and Issa bequeathed a portion of his land to the couple. Msallam had a son, Salamah, who in turn had two sons: Sulaiman and Jiries. Sulaiman had a son called Abdallah, and Jiries had a son called Khalil, cousins who are the ancestors of Rishmawi family' branches.""", // Continue the text here
  ),
  FeaturedFamily(
    familyName: "Bannourah Family",
    story:
        "Family named Bannoura after Jiries’ wife; sons Odeh and Ibrahim established branches.",
    crestImage: 'assets/images/BannouraFam.png', // Example crest image
    details:
        """The second ancestor of the Marashda family is Jiries (Jirjes Abu Thuraya), ancestor of the Bannoura family, which the family was called after his wife Bannoura, since Jiries had died early, after having two sons: Odeh and Ibrahim (who was called Abu Hashish for being funny). Jiries sons were then called the Bannoura' sons. Odeh had three children: Habrin, Jaber and Shehadeh, ancestors of the three branches of the Bannoura family. While Ibrahim had Hanna, who in turn got four children: Salim, Issa, Suleiman and Awad. Unfortunately, only Salim survived as the living ancestor of the current Abu Hashish family, one of the Bannoura family' branches.
...
""", // Continue the text here
  ),
  FeaturedFamily(
    familyName: "Al-Marashdeh Family",
    story: "Came after a hunderd year of Al-Qazaha Al-Tahata",
    crestImage: 'assets/images/AlMarashdeh.jpg', // Example crest image
    details:
        """Then about a hundred years later, the ancestors of the Marashda family came to Beit Sahour as Christian pilgrims from "Rashda" in Egypt. They were called Oweis (ancestor of Khair family) and his brother Jiries (ancestor of Bannoura family). From the same town also came Awwad (ancestor of Awwad family) and Abu Shaghwiya (ancestor Ayyad and Badra families). At that time, the Marashda lived in caves under the houses of Jiries Gharib, Elias Ibrahim Khair and Jiries Khair in the Khair neighborhood in the middle of town, as well as caves in the nearby Ayyad neighborhood.

In the same period ancestors of the Kukali family from Al-Kukaliya in Syria came and lived with the ancestors of the Awwad family.

The Marashda family has four ancestors; two of them are brothers Oweis (ancestor of Khair family) and Jiries (ancestor of Bannoura family):

Oweis had Khair, whose name the family took and who later had four children, who were the ancestors of the Khair family branches:

Ibrahim Khair, the ancestor of the current Khair family and his sons: Khair, Abdullah, Khalil and Awad, the ancestors of the Khair family.

The second son of Khair Oweis is Musa (ancestor of Hawwash family), who had two sons: Salem (the ancestor of Baboul family) and Jacob, who in turn had Jaber and Hanna (known as Hawwash), the ancestors of the two main branches of the Hawwash family (Musa family).

The third son of Khair Oweis is Sa'eed, who had three sons: Hanna (ancestor of Tawil family), Sa'ad (ancestor of Sa'ad family) and Masa'ad (ancestor of Masa'ad family), which represent the three main branches of the Isa'ed family.

The fourth son of Khair Oweis is Gharib, who had two sons Salameh and Elias, the ancestors of the Gharib family.


The second ancestor of the Marashda family is Jiries (Jirjes Abu Thuraya), ancestor of the Bannoura family, which the family was called after his wife Bannoura, since Jiries had died early, after having two sons: Odeh and Ibrahim (who was called Abu Hashish for being funny). Jiries sons were then called the Bannoura' sons. Odeh had three children: Habrin, Jaber and Shehadeh, ancestors of the three branches of the Bannoura family. While Ibrahim had Hanna, who in turn got four children: Salim, Issa, Suleiman and Awad. Unfortunately, only Salim survived as the living ancestor of the current Abu Hashish family, one of the Bannoura family' branches.

The third ancestor of the Marashda family is Awwad (ancestor of Awwad family), as mentioned previously, who had his son Saleh, and Saleh had Issa, and Issa had three children: Moses, Abdullah and Salem, ancestors of the main branches of the Awwad family. The branch of the Kokali family connects to the Awwad family from Al-Kukaliya in Syria, as mentioned earlier, and their ancestor was Sulaiman who had his son Musa, and Musa had his son Salem, who in turn had his sons Saliba and Issa.

The third ancestor of the Marashda family is the ancestor of Ayyad family, and his name was Abu Shaghwiya. Abu Shaghwiya had a son, Abu Mahluka, and Abu Mahluka had Abu Shareb. Abu Shareb had Abu Ghattas, who had two children: Ayyad and Ibrahim, ancestors of Ayyad and Badra families. Ayyad had three sons: Jaber, Salem and Farhoud, who represent the major branches of the Ayyad family, while Ibrahim had two sons, Khader and Hanna, the ancestors of Badra family.
...
""", // Continue the text here
  ),
  // Add other families here
];
