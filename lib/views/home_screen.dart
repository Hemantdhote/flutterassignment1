import 'package:assignment1/controllers/product_controller.dart';
import 'package:assignment1/views/cart_screen.dart';
import 'package:assignment1/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductController controller = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    controller.fetchProducts().then((value) {
      for (var product in controller.products) {
        debugPrint('Title: ${product.title}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: Colors.white,
        actions: [
          Obx(() {
            return Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(() => const CartScreen());
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                ),

                if (controller.cartCount > 0)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${controller.cartCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),

        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.error.value.isNotEmpty) {
            return Center(child: Text(controller.error.value));
          }
          return GridView.builder(
            itemCount: controller.products.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10,
              childAspectRatio: 0.70,
            ),

            itemBuilder: (context, index) {
              return ProductCard(product: controller.products[index]);
            },
          );
        }),
      ),
    );
  }
}
