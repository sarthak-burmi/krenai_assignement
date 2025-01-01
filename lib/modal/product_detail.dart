// product_details_modal.dart
class ProductDetails {
  final int id;
  final String name;
  final String description;
  final String productOrigin;
  final String brandName;
  final List<String> categories;
  final List<ProductListing> productListings;
  final List<ProductKeyword> keywords;
  final List<ProductSpecification> specifications;
  final double rating;
  final int totalReviews;
  final bool isAvailable;
  final String seoTitle;
  final String seoDescription;

  ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.productOrigin,
    required this.brandName,
    required this.categories,
    required this.productListings,
    required this.keywords,
    required this.specifications,
    required this.rating,
    required this.totalReviews,
    required this.isAvailable,
    required this.seoTitle,
    required this.seoDescription,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    final object = json['object'];
    return ProductDetails(
      id: object['id'] ?? 0, // Default to 0 if id is null
      name: object['name'] ?? '', // Default to empty string if name is null
      description: object['description'] ??
          '', // Default to empty string if description is null
      productOrigin: object['productOrigin'] ??
          '', // Default to empty string if productOrigin is null
      brandName: object['brandName'] ??
          'Unknown', // Default to 'Unknown' if brandName is null
      categories: List<String>.from(object['categories'] ??
          []), // Default to empty list if categories is null
      productListings: (object['productListings'] as List)
          .map((x) => ProductListing.fromJson(x))
          .toList(),
      keywords: (object['productKeywordsMappings'] as List)
          .map((x) => ProductKeyword.fromJson(x))
          .toList(),
      specifications: (object['productSpecificationMappings'] as List)
          .map((x) => ProductSpecification.fromJson(x))
          .toList(),
      rating: (object['rating'] as num?)?.toDouble() ??
          0.0, // Default to 0.0 if rating is null
      totalReviews:
          object['totalReviews'] ?? 0, // Default to 0 if totalReviews is null
      isAvailable: object['isAvailable'] == 1,
      seoTitle: object['seoTitle'] ??
          '', // Default to empty string if seoTitle is null
      seoDescription: object['seoDescription'] ??
          '', // Default to empty string if seoDescription is null
    );
  }
}

class ProductListing {
  final String skuCode;
  final double sellingPrice;
  final double mrp;
  final int inStockQuantity;
  final List<VariantValue> variantValues;
  final List<String> mediaUrls;

  ProductListing({
    required this.skuCode,
    required this.sellingPrice,
    required this.mrp,
    required this.inStockQuantity,
    required this.variantValues,
    required this.mediaUrls,
  });

  factory ProductListing.fromJson(Map<String, dynamic> json) {
    return ProductListing(
      skuCode: json['skuCode'],
      sellingPrice: json['sellingPrice'].toDouble(),
      mrp: json['mrp'].toDouble(),
      inStockQuantity: json['inStockQuantity'],
      variantValues: (json['variantValues'] as List)
          .map((x) => VariantValue.fromJson(x))
          .toList(),
      mediaUrls: List<String>.from(json['mediaUrls']),
    );
  }
}

class VariantValue {
  final String variantType;
  final String variantValue;

  VariantValue({required this.variantType, required this.variantValue});

  factory VariantValue.fromJson(Map<String, dynamic> json) {
    return VariantValue(
      variantType: json['variantType'],
      variantValue: json['variantValue'],
    );
  }
}

class ProductKeyword {
  final String value;

  ProductKeyword({required this.value});

  factory ProductKeyword.fromJson(String json) {
    return ProductKeyword(value: json);
  }
}

class ProductSpecification {
  final String name;
  final String? value;

  ProductSpecification({required this.name, this.value});

  factory ProductSpecification.fromJson(Map<String, dynamic> json) {
    return ProductSpecification(
      name: json['name'],
      value: json['value'],
    );
  }
}
