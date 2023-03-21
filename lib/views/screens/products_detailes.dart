import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/views/screens/buy_now.dart';
import 'package:e_commerce_app/views/screens/home_page.dart';
import 'package:e_commerce_app/controller/provider_file.dart';
import 'package:e_commerce_app/views/widgets/snack_bar_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductsDetails extends StatelessWidget {
  ProductsDetails({super.key, required this.index});
  final int index;

  bool favoriteButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Consumer<ProviderFile>(builder: (context, getData, child) {
        getData.fetchApi();
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              Stack(children: [
                Center(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 3 / 4,
                      height: 250,
                      viewportFraction: 0.9,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: <Widget>[
                      for (var i = 0;
                          i < getData.data.products[buttonindex].images.length;
                          i++)
                        Container(
                            decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          //  border: Border.all(width: sqrt1_2),
                          image: DecorationImage(
                              image: NetworkImage(
                                  getData.data.products[buttonindex].images[i]),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(30),
                        )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 20),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            const Color.fromARGB(255, 239, 239, 239),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                            size: 18,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 25),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            const Color.fromARGB(255, 239, 239, 239),
                        child: IconButton(
                          onPressed: (() {
                            favoriteButton = !favoriteButton;

                            buttonindex = index;

                            getData.saveS();
                            var existingIndex = getData.favorite.indexWhere(
                                (id) =>
                                    id == getData.data.products[index].id - 1);
                            if (existingIndex != -1) {
                              return;
                            } else {
                              getData.favorite
                                  .add(getData.data.products[index].id - 1);
                              getData.saveS();
                            }
                          }),
                          icon: favoriteButton
                              ? const Icon(
                                  Icons.favorite,
                                  size: 20,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                  size: 20,
                                ),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
              SizedBox(height: MediaQuery.of(context).size.height / 19),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                child: Container(
                  height: 320,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(239, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 4),
                        Text(getData.data.products[buttonindex].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getData.data.products[buttonindex].brand,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "${getData.data.products[buttonindex].stock} stocks",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating:
                                  getData.data.products[buttonindex].rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 25,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '(${getData.data.products[buttonindex].rating})',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                                '\$ ${getData.data.products[buttonindex].price}.0',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(width: 15),
                            const Icon(Icons.discount),
                            Text(
                                '${getData.data.products[buttonindex].discountPercentage}% off',
                                style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text('Description',
                            style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 10),
                        Text(
                            '${getData.data.products[buttonindex].description} '),
                        const SizedBox(height: 45),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 66,
                    width: MediaQuery.of(context).size.width * 0.50,
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        buttonindex = index;

                        getData.saveSF();
                        var existingIndex = getData.cartSample.indexWhere(
                            (id) => id == getData.data.products[index].id - 1);
                        if (existingIndex != -1) {
                          return;
                        } else {
                          getData.cartSample
                              .add(getData.data.products[index].id - 1);
                          getData.saveSF();
                        }
                        snackBarCart(context);
                      },
                      child: const Center(
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 66,
                    width: MediaQuery.of(context).size.width * 0.50,
                    color: Colors.amber,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BuyNow()));
                      },
                      child: const Center(
                        child: Text(
                          'Buy now',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  // _addtoCart(BuildContext context) async {
  _snackBar(context) {
    const snackBar = SnackBar(
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(30.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Text('Successfully Cart Added !'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
