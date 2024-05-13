import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../provider/product_provider.dart';
import '../widget/widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController scrollController;

  @override
  void dispose() {
    scrollController.removeListener(() =>
        Provider.of<ProductProvider>(context, listen: false)
            .loadMoreProduct(scrollController));
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  List<Map<String, dynamic>> bottomNaviationList = [
    {"label": "Home", "icon": Icons.home_outlined},
    {"label": "Cart", "icon": Icons.shopping_bag_outlined},
    {"label": "Favorites", "icon": Icons.favorite_outline},
    {"label": "Profile", "icon": Icons.person_2_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, _) {
      scrollController
          .addListener(() => productProvider.loadMoreProduct(scrollController));
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            title: Text(
              "Home",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: primary,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              items: List.generate(bottomNaviationList.length, (i) {
                var nav = bottomNaviationList[i];
                return BottomNavigationBarItem(
                    icon: Icon(nav['icon']), label: nav['label']);
              })),
          body: Center(
            child: productProvider.state == AppState.loading
                ? const CircularProgressIndicator()
                : productProvider.state == AppState.error
                    ? Text(productProvider.errorMessage)
                    : RefreshIndicator(
                        onRefresh: () => productProvider.getProduct(),
                        child: ListView(
                          controller: scrollController,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextFormField(
                                    decoration: InputDecoration(
                                        constraints:
                                            const BoxConstraints(maxHeight: 50),
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        hintText: "Search your product",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10)),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(50, 50),
                                          backgroundColor: primary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          padding: EdgeInsets.zero),
                                      onPressed: () {},
                                      child: const Icon(
                                        Icons.tune,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ),
                            MasonryGridView.count(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                mainAxisSpacing: 27,
                                crossAxisSpacing: 23,
                                itemCount: productProvider.productList.length,
                                itemBuilder: (context, index) {
                                  var product =
                                      productProvider.productList[index];
                                  return HomeItemWidget(
                                    product: product,
                                  );
                                }),
                            if (productProvider.state == AppState.loadMore)
                              const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 40),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            if (!productProvider.hasNextPage)
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 40),
                                color: primary,
                                child: Center(
                                  child: Text(
                                    'You have fetched all of the product',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
          ));
    });
  }
}
