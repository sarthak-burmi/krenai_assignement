import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:krenai_assignement/const/app_text_style.dart';
import 'package:krenai_assignement/controller/product_controller.dart';
import 'package:krenai_assignement/controller/product_detail_controller.dart';
import 'package:krenai_assignement/widgets/app_bar.dart';
import 'package:krenai_assignement/widgets/fotter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;

  ProductDetailPage({super.key, required this.productId});

  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());
  final ProductController productController = Get.put(ProductController());

  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    productDetailsController.fetchProductDetails(productId);

    return Scaffold(
      appBar: appBar(
        totalCount: productController.totalProducts,
        isProductPage: false,
        context,
        GlobalKey<ScaffoldState>(), // You can pass the scaffold key if needed
        showBackButton: true, // Show back button
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (productDetailsController.isLoading.value) {
          return buildShimmerLoading();
        } else if (productDetailsController.productDetails.value == null) {
          return const Center(child: Text('Product not found'));
        } else {
          final productDetails = productDetailsController.productDetails.value!;
          final productListing = productDetails.productListings.first;

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider.builder(
                      itemCount:
                          productDetails.productListings.first.mediaUrls.length,
                      itemBuilder: (context, index, realIndex) {
                        final url = productDetails
                            .productListings.first.mediaUrls[index];
                        return Image.network(
                          url,
                          fit: BoxFit.fill,
                        );
                      },
                      options: CarouselOptions(
                        viewportFraction: 2,
                        height: 400.0,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          _currentIndex.value = index;
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      child: Row(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _currentIndex,
                            builder: (context, value, child) {
                              return AnimatedSmoothIndicator(
                                activeIndex: value,
                                count: productDetails
                                    .productListings.first.mediaUrls.length,
                                effect: const ExpandingDotsEffect(
                                  activeDotColor: Colors.black,
                                  dotColor: Colors.grey,
                                  dotHeight: 8,
                                  dotWidth: 8,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 33,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                          icon: const Icon(
                            Icons.zoom_out_map_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => FullScreenImageViewer(
                                imageUrls: productDetails
                                    .productListings.first.mediaUrls,
                                initialIndex: _currentIndex.value,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        productDetails.name,
                        style: AppTextStyles.heading,
                      ),
                      const SizedBox(height: 8),

                      // Product Price
                      Row(
                        children: [
                          Text(
                            '₹${productListing.sellingPrice.toStringAsFixed(2)}',
                            style: AppTextStyles.subheading.copyWith(
                              color: Colors.green,
                            ), // Updated to use AppTextStyles
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '₹${productListing.mrp.toStringAsFixed(2)}',
                            style: AppTextStyles.body.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ), // Updated to use AppTextStyles
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Add to Cart',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                      // Product Description
                      HtmlWidget(
                        productDetails.description,
                        textStyle:
                            AppTextStyles.body, // Updated to use AppTextStyles
                      ),

                      const SizedBox(height: 16),

                      // Additional Product Details
                      Text('Brand: ${productDetails.brandName}',
                          style: AppTextStyles.body.copyWith(
                              color: Colors
                                  .black54)), // Updated to use AppTextStyles
                      Text('Origin: ${productDetails.productOrigin}',
                          style: AppTextStyles.body.copyWith(
                              color: Colors
                                  .black54)), // Updated to use AppTextStyles
                      Text(
                          'Rating: ${productDetails.rating} (${productDetails.totalReviews} reviews)',
                          style: AppTextStyles.body.copyWith(
                              color: Colors
                                  .black54)), // Updated to use AppTextStyles

                      const SizedBox(height: 70),
                      Footer()
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget buildShimmerLoading() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 200,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }
}

class FullScreenImageViewer extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height:
            MediaQuery.of(context).size.height * 0.8, // Adjust height as needed
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              itemCount: imageUrls.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(imageUrls[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration:
                  const BoxDecoration(color: Colors.transparent),
              pageController: PageController(initialPage: initialIndex),
              onPageChanged: (index) {},
            ),
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
