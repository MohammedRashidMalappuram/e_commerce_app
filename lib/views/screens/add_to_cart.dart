import 'package:e_commerce_app/controller/provider_file.dart';
import 'package:flutter/material.dart';
import 'package:number_selection/number_selection.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    final gettingProvider = Provider.of<ProviderFile>(context);
    gettingProvider.loadSF();
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<ProviderFile>(
          builder: (BuildContext context, ProviderFile getData, Widget? child) {
        return Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                width: double.infinity,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 200,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Image.network(
                                    gettingProvider
                                        .data
                                        .products[
                                            gettingProvider.cartSample[index]]
                                        .thumbnail,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: NumberSelection(
                                    theme: NumberSelectionTheme(
                                        draggableCircleColor: Colors.blue,
                                        iconsColor: Colors.white,
                                        numberColor: Colors.white,
                                        backgroundColor:
                                            Colors.deepPurpleAccent,
                                        outOfConstraintsColor:
                                            Colors.deepOrange),
                                    initialValue: 1,
                                    minValue: 0,
                                    maxValue: 10,
                                    direction: Axis.horizontal,
                                    withSpring: true,
                                    onChanged: (int value) => ("value: $value"),
                                    enableOnOutOfConstraintsAnimation: true,
                                    onOutOfConstraints: () =>
                                        ("This value is too high or too low"),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    gettingProvider
                                        .data
                                        .products[
                                            gettingProvider.cartSample[index]]
                                        .title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      'by ${gettingProvider.data.products[gettingProvider.cartSample[index]].brand}',
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          '\$ ${gettingProvider.data.products[gettingProvider.cartSample[index]].price}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                          )),
                                      Text(
                                          '  ${gettingProvider.data.products[gettingProvider.cartSample[index]].discountPercentage}%off',
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.red)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        getData.removeItem(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      ),
                                      label: const Text(
                                        'Remove',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          side: const BorderSide(
                                              color: Colors.grey)))
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: getData.cartSample.length)),
            Expanded(
                child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    '\$ 4023',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      onPressed: (() {}), child: const Text('Place Order'))
                ],
              ),
            ))
          ],
        );
      }),
    );
  }
}
