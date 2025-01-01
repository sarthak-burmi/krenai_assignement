import 'package:flutter/material.dart';

PreferredSize appBar(
  BuildContext context,
  GlobalKey<ScaffoldState> scaffoldKey, {
  bool showBackButton = false,
  bool isProductPage = true,
  String totalCount = '0 APPAREL',
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(isProductPage ? 170 : 80),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showBackButton
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Icon(Icons.menu),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
                  child: Image.asset(
                    "assets/images/Logo.jpg",
                    height: 50,
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(Icons.search),
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(Icons.shopping_bag_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isProductPage)
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$totalCount PRODUCTS',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          // Dropdown for "New"
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'New',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down, size: 18),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Grid and List Icons
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.grid_view,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.view_list,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Conditionally render Filter Tags only on Product Page
                  Row(
                    children: [
                      _buildFilterTag('Kitchen and Untincils'),
                      const SizedBox(width: 8),
                      _buildFilterTag('All apparel'),
                    ],
                  )
                ],
              ),
            ),
          )
        else
          const SizedBox.shrink(), // No space when isProductPage is false
      ],
    ),
  );
}

// Helper method to build filter tags
Widget _buildFilterTag(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 6),
        const Icon(
          Icons.close,
          size: 16,
          color: Colors.black,
        ),
      ],
    ),
  );
}
