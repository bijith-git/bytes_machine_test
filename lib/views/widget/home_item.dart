import 'package:flutter/material.dart';

import 'package:bytes_machine_test/models/product_model.dart';
import 'package:bytes_machine_test/utils/utils.dart';

class HomeItemWidget extends StatelessWidget {
  final Product product;
  const HomeItemWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    product.image,
                    height: 120.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
                Positioned(
                  top: 5.0,
                  right: 5.0,
                  child: IconButton(
                    icon: const Icon(
                      // isFavorite ?
                      Icons.favorite,
                      //: Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              product.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5.0),
            Text(
              "₹${product.price}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(letterSpacing: .5),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {},
                    child: const Icon(Icons.watch)),
                const Expanded(child: AdaptiveAddToCart()
                    // ElevatedButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       "Add to cart",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyLarge!
                    //           .copyWith(fontWeight: FontWeight.bold),
                    // )
                    // ),
                    )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AdaptiveAddToCart extends StatelessWidget {
  const AdaptiveAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 100.0) {
          // Adjust minimum width as needed
          return const Text(
            'Add to cart',
            style: TextStyle(fontSize: 16.0), // Adjust font size as needed
          );
        } else {
          return IconButton(
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () =>
                Utils.showSnackbar(context, 'Add to cart pressed!'),
          );
        }
      },
    );
  }
}
