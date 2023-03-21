import 'package:e_commerce_app/utils/font.dart';
import 'package:e_commerce_app/views/screens/add_to_cart.dart';
import 'package:e_commerce_app/views/widgets/drawer_menu_widget.dart';
import 'package:e_commerce_app/views/screens/products_detailes.dart';
import 'package:e_commerce_app/controller/provider_file.dart';
import 'package:e_commerce_app/views/widgets/favorite.dart';
import 'package:e_commerce_app/views/widgets/snack_bar_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int buttonindex = 0;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const Favorite())));
            }),
            icon: const Icon(Icons.favorite_border),
            color: Colors.black,
          ),
          IconButton(
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const AddToCart())));
            }),
            icon: const Icon(Icons.shopping_cart_outlined),
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser!.photoURL ?? ""),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Pick your favorites...',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          textField(),
          const SizedBox(height: 30),
          Container(
            width: double.maxFinite,
            height: 533,
            padding: const EdgeInsets.all(0),
            child: Consumer<ProviderFile>(builder: (context, getData, child) {
              getData.fetchApi();
              if (getData.status == Providertatus.completed) {
                return ListView.builder(
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 199, 193, 193),
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 3.0,
                              spreadRadius: 3.0,
                            ),
                            BoxShadow(
                              color: Colors.white,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 200,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      getData.data.products[index].thumbnail),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  buttonindex = index;

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductsDetails(index: index)));
                                },
                              ),
                            ),
                            const SizedBox(width: 4),
                            SizedBox(
                              height: 159,
                              width: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(getData.data.products[index].title,
                                      style: titleHome),
                                  const SizedBox(height: 10),
                                  Text(
                                      "by ${getData.data.products[index].brand}",
                                      style: brandHome),
                                  const SizedBox(height: 27),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          "\$${getData.data.products[index].price}.0",
                                          style: priceHome),
                                      ElevatedButton(
                                        onPressed: (() {
                                          buttonindex = index;

                                          getData.saveSF();
                                          var existingIndex = getData.cartSample
                                              .indexWhere((id) =>
                                                  id ==
                                                  getData.data.products[index]
                                                          .id -
                                                      1);
                                          if (existingIndex != -1) {
                                            return;
                                          } else {
                                            getData.cartSample.add(getData
                                                    .data.products[index].id -
                                                1);
                                            getData.saveSF();
                                          }
                                          snackBarCart(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      const AddToCart())));
                                        }),
                                        child: const Icon(Icons.shopping_cart),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ],
      ),
    );
  }

  Center textField() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 50,
        width: 330,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "What are you looking for?",
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
