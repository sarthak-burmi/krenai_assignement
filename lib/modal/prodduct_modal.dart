class Product {
  final int id;
  final String description;
  final String keywords;
  final String mediaUrl;
  final List<Map<String, dynamic>>? category;
  final String name;
  final double rating;
  final List<Variant> variants;
  final String? promotionalTag;
  final bool inWishlist;
  final bool hasCustomization;

  Product({
    required this.id,
    required this.description,
    required this.keywords,
    required this.mediaUrl,
    this.category,
    required this.name,
    required this.rating,
    required this.variants,
    this.promotionalTag,
    required this.inWishlist,
    required this.hasCustomization,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'] as int,
        description: json['description'] as String? ?? '',
        keywords: json['keywords'] as String? ?? '',
        mediaUrl: json['mediaUrl'] as String? ?? '',
        category: (json['category'] as List?)?.cast<Map<String, dynamic>>(),
        name: json['name'] as String? ?? '',
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        variants: (json['variants'] as List?)
                ?.map((v) => Variant.fromJson(v as Map<String, dynamic>))
                .toList() ??
            [],
        promotionalTag: json['promotionalTag'] as String?,
        inWishlist: json['inWishlist'] == 1,
        hasCustomization: json['hasCustomization'] == 1,
      );
    } catch (e) {
      throw FormatException('Failed to parse Product: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'keywords': keywords,
      'mediaUrl': mediaUrl,
      'category': category,
      'name': name,
      'rating': rating,
      'variants': variants.map((variant) => variant.toJson()).toList(),
      'promotionalTag': promotionalTag,
      'inWishlist': inWishlist ? 1 : 0,
      'hasCustomization': hasCustomization ? 1 : 0,
    };
  }
}

class Variant {
  final String variant;
  final String sku;
  final bool isOutOfStock;
  final double sellingPrice;
  final double mrp;
  final String mediaUrl;

  Variant({
    required this.variant,
    required this.sku,
    required this.isOutOfStock,
    required this.sellingPrice,
    required this.mrp,
    required this.mediaUrl,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    try {
      return Variant(
        variant: json['variant'] as String? ?? '',
        sku: json['sku'] as String? ?? '',
        isOutOfStock: json['isOutOfStock'] == 1,
        sellingPrice: (json['sellingPrice'] as num?)?.toDouble() ?? 0.0,
        mrp: (json['mrp'] as num?)?.toDouble() ?? 0.0,
        mediaUrl: json['mediaUrl'] as String? ?? '',
      );
    } catch (e) {
      throw FormatException('Failed to parse Variant: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'variant': variant,
      'sku': sku,
      'isOutOfStock': isOutOfStock ? 1 : 0,
      'sellingPrice': sellingPrice,
      'mrp': mrp,
      'mediaUrl': mediaUrl,
    };
  }
}
