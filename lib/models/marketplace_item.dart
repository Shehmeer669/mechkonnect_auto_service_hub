enum MarketplaceItemType {
  part,
  tool,
  service,
  accessory,
}

enum MarketplaceItemCondition {
  newItem,
  used,
  refurbished,
  damaged,
}

class MarketplaceItem {
  final String id;
  final String sellerId; // Reference to User (can be mechanic or regular user)
  final String title;
  final String description;
  final MarketplaceItemType type;
  final MarketplaceItemCondition condition;
  final double price;
  final String? brand;
  final String? model;
  final String? partNumber;
  final List<String> compatibleVehicles; // Make/model combinations
  final List<String> imageUrls;
  final String location;
  final bool isAvailable;
  final bool isNegotiable;
  final int quantity;
  final String? category;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int viewCount;
  final int favoriteCount;

  MarketplaceItem({
    required this.id,
    required this.sellerId,
    required this.title,
    required this.description,
    required this.type,
    required this.condition,
    required this.price,
    this.brand,
    this.model,
    this.partNumber,
    this.compatibleVehicles = const [],
    this.imageUrls = const [],
    required this.location,
    this.isAvailable = true,
    this.isNegotiable = false,
    this.quantity = 1,
    this.category,
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
    this.viewCount = 0,
    this.favoriteCount = 0,
  });

  factory MarketplaceItem.fromMap(Map<String, dynamic> map) {
    return MarketplaceItem(
      id: map['id'] as String,
      sellerId: map['sellerId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      type: MarketplaceItemType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => MarketplaceItemType.part,
      ),
      condition: MarketplaceItemCondition.values.firstWhere(
        (e) => e.toString().split('.').last == map['condition'],
        orElse: () => MarketplaceItemCondition.used,
      ),
      price: (map['price'] as num).toDouble(),
      brand: map['brand'] as String?,
      model: map['model'] as String?,
      partNumber: map['partNumber'] as String?,
      compatibleVehicles: List<String>.from(map['compatibleVehicles'] as List? ?? []),
      imageUrls: List<String>.from(map['imageUrls'] as List? ?? []),
      location: map['location'] as String,
      isAvailable: map['isAvailable'] as bool? ?? true,
      isNegotiable: map['isNegotiable'] as bool? ?? false,
      quantity: map['quantity'] as int? ?? 1,
      category: map['category'] as String?,
      tags: List<String>.from(map['tags'] as List? ?? []),
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      viewCount: map['viewCount'] as int? ?? 0,
      favoriteCount: map['favoriteCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sellerId': sellerId,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'condition': condition.toString().split('.').last,
      'price': price,
      'brand': brand,
      'model': model,
      'partNumber': partNumber,
      'compatibleVehicles': compatibleVehicles,
      'imageUrls': imageUrls,
      'location': location,
      'isAvailable': isAvailable,
      'isNegotiable': isNegotiable,
      'quantity': quantity,
      'category': category,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'viewCount': viewCount,
      'favoriteCount': favoriteCount,
    };
  }

  MarketplaceItem copyWith({
    String? id,
    String? sellerId,
    String? title,
    String? description,
    MarketplaceItemType? type,
    MarketplaceItemCondition? condition,
    double? price,
    String? brand,
    String? model,
    String? partNumber,
    List<String>? compatibleVehicles,
    List<String>? imageUrls,
    String? location,
    bool? isAvailable,
    bool? isNegotiable,
    int? quantity,
    String? category,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? viewCount,
    int? favoriteCount,
  }) {
    return MarketplaceItem(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      condition: condition ?? this.condition,
      price: price ?? this.price,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      partNumber: partNumber ?? this.partNumber,
      compatibleVehicles: compatibleVehicles ?? this.compatibleVehicles,
      imageUrls: imageUrls ?? this.imageUrls,
      location: location ?? this.location,
      isAvailable: isAvailable ?? this.isAvailable,
      isNegotiable: isNegotiable ?? this.isNegotiable,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      viewCount: viewCount ?? this.viewCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
    );
  }

  @override
  String toString() {
    return 'MarketplaceItem(id: $id, sellerId: $sellerId, title: $title, description: $description, type: $type, condition: $condition, price: $price, brand: $brand, model: $model, partNumber: $partNumber, compatibleVehicles: $compatibleVehicles, imageUrls: $imageUrls, location: $location, isAvailable: $isAvailable, isNegotiable: $isNegotiable, quantity: $quantity, category: $category, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, viewCount: $viewCount, favoriteCount: $favoriteCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MarketplaceItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}