import '../../constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../../utils/utils.dart';

class HomeItemWidget extends StatefulWidget {
  const HomeItemWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<HomeItemWidget> createState() => _HomeItemWidgetState();
}

class _HomeItemWidgetState extends State<HomeItemWidget> {
  bool isFavorite = false;

  IconData getCategoryIcon(String type) {
    switch (type) {
      case 'shoe':
        return Icons.directions_walk_rounded;
      case 'watch':
        return Icons.watch;
      case 'toy':
        return Icons.toys;
      default:
        return Icons.sell;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 225),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.product.image,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 120.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                  progressIndicatorBuilder: (context, url, progress) =>
                      const SizedBox(
                          height: 120.0,
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator())),
                  errorWidget: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error)),
                ),
                Positioned(
                  top: 5.0,
                  right: 5.0,
                  child: IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.white),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: primary,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ),
                Positioned(
                  top: 5.0,
                  left: 5.0,
                  child: IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.white),
                    icon: Icon(
                      getCategoryIcon(widget.product.type),
                      color: primary,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    widget.product.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹${widget.product.price}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            letterSpacing: .5,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      IconButton(
                          onPressed: () =>
                              Utils.showSnackbar(context, "Item added to cart"),
                          icon: const Icon(Icons.add_shopping_cart,
                              color: primary))
                    ],
                  ),
                ],
              ),
            ),
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
