import 'package:e_commerce_app/controller/provider_file.dart';
import 'package:e_commerce_app/utils/font.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final gettingProvider = Provider.of<ProviderFile>(context);
    gettingProvider.loadS();
    return Scaffold(
      //backgroundColor: Colors.grey[300],
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
          "Favorite",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<ProviderFile>(
          builder: (BuildContext context, ProviderFile getData, Widget? child) {
        return SizedBox(
          height: 600,
          width: double.infinity,
          child: ListView.separated(
            itemCount: getData.favorite.length,
            itemBuilder: ((context, index) {
              return Container(
                // margin: const EdgeInsets.all(10),
                height: 120,
                width: double.infinity,
                decoration: const BoxDecoration(
                  //  color: Colors.white,
                  borderRadius: BorderRadius.only(),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(gettingProvider
                                .data
                                .products[gettingProvider.favorite[index]]
                                .thumbnail),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(gettingProvider
                              .data
                              .products[gettingProvider.favorite[index]]
                              .title),
                          Row(
                            children: [
                              Text(
                                '\$ ${gettingProvider.data.products[gettingProvider.favorite
                                
                                [index]].price}',
                                style: titleHome,
                              ),
                              Text(
                                  '  ${gettingProvider.data.products[gettingProvider.favorite[index]].discountPercentage}%off',
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.red)),
                            ],
                          ),
                          TextButton(
                              onPressed: (() {
                                getData.removeFavorite(index);
                              }),
                              child: const Text('Remove'))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        );
      }),
    );
  }
}
//child: Center(
//   child: ListTile(
//     title: Text(gettingProvider.data
//         .products[gettingProvider.cartSample[index]].title),
//     subtitle: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//             '\$ ${gettingProvider.data.products[gettingProvider.cartSample[index]].price}'),
//         IconButton(
//             onPressed: (() {
//               gettingProvider.removeItem(index);
//             }),
//             icon: const Icon(Icons.delete))
//       ],
//     ),
//     leading: Container(
//       width: 100,
//       //height: 120,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         image: DecorationImage(
//           image: NetworkImage(gettingProvider
//               .data
//               .products[gettingProvider.cartSample[index]]
//               .thumbnail),
//           //fit: BoxFit.fill,
//         ),
//       ),
//     ),
//   ),
// ),
