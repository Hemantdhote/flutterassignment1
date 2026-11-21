import 'package:assignment1/controllers/product_controller.dart';
import 'package:assignment1/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.white,
        actions: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  ' total: \$${controller.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: Obx(() {
        if (controller.cart.isEmpty) {
          return const Center(child: Text("No Item Available"));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.cart.length,
                itemBuilder: (context, index) {
                  var entry = controller.cart.entries.toList()[index];

                  Product product = controller.products.firstWhere(
                    (item) => item.id == entry.key,
                  );

                  int quantity = entry.value;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(8),
                    color: Color.fromARGB(255, 255, 224, 224),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Image.network(
                                product.image,
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),

                              const SizedBox(height: 5),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        controller.quantityDerease(product.id),
                                    child: const Icon(
                                      Icons.remove_circle_outline,
                                      size: 20,
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Text('$quantity'),

                                  const SizedBox(width: 10),

                                  InkWell(
                                    onTap: () =>
                                        controller.quantityIncrease(product.id),
                                    child: const Icon(Icons.add, size: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 40),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(fontSize: 20),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                '\$ ${product.price}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const Text(
                                'Eligible for free shipping',
                                style: TextStyle(fontSize: 16),
                              ),

                              const Text(
                                'In Stock',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),

                              const SizedBox(height: 8),

                              SizedBox(
                                height: 30,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    controller.removeCart(product.id);
                                  },
                                  icon: const Icon(Icons.delete, size: 18),
                                  label: const Text(
                                    'Delete',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
