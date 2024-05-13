import 'package:bytes_machine_test/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../widget/widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, _) {
      return Scaffold(
          body: Center(
        child: productProvider.state == AppState.loading
            ? const CircularProgressIndicator()
            : productProvider.state == AppState.error
                ? Text(productProvider.errorMessage)
                : MasonryGridView.count(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 27,
                    crossAxisSpacing: 23,
                    itemCount: productProvider.productList.length,
                    itemBuilder: (context, index) {
                      var product = productProvider.productList[index];
                      return HomeItemWidget(
                        product: product,
                      );
                    }),
      ));
    });
  }
}
