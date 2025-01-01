import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krenai_assignement/modal/prodduct_modal.dart';
import 'package:krenai_assignement/screens/product_detail_screen.dart';
import 'package:krenai_assignement/widgets/fotter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:krenai_assignement/controller/product_controller.dart';
import 'package:krenai_assignement/const/app_text_style.dart';

class ProductPage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (productController.isLoading.value) {
          return buildShimmerLoading();
        } else if (productController.products.isEmpty) {
          return const Center(
            child: Text(
              'No products found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                buildProductGrid(),
                const SizedBox(height: 16),
                const Footer(),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 0.7,
        ),
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          return buildProductCard(productController.products[index]);
        },
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }

  Widget buildProductCard(Product product) {
    final variant = product.variants.isNotEmpty ? product.variants.first : null;

    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailPage(productId: product.id));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromARGB(255, 230, 230, 230),
                    width: 1.7,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: product.mediaUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(color: Colors.white),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTextStyles.body.copyWith(),
                  maxLines: 2, // Allows the text to wrap to multiple lines
                  overflow: TextOverflow
                      .visible, // Ensures the overflow is handled by wrapping instead of ellipsis
                ),
                if (variant != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₹${variant.sellingPrice.toStringAsFixed(0)}',
                        style: AppTextStyles.body.copyWith(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      if (variant.mrp > variant.sellingPrice)
                        Text(
                          '₹${variant.mrp.toStringAsFixed(0)}',
                          style: AppTextStyles.body.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: IconButton(
                //     icon: Icon(
                //       product.isFavorite ? Icons.favorite : Icons.favorite_border,
                //       color: product.isFavorite ? Colors.red : Colors.grey,
                //     ),
                //     onPressed: () {
                //       // Toggle favorite status
                //       productController.togglefavoriteStatus(product);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShimmerLoading() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 150,
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
//  decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 1,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),