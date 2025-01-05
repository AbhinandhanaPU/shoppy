class Product {
  final String productId;
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final String soldBy;

  Product({
    required this.productId,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.soldBy,
  });

  Product copyWith({
    String? productId,
    String? name,
    String? imageUrl,
    String? description,
    double? price,
    String? soldBy,
  }) {
    return Product(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      soldBy: soldBy ?? this.soldBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'imageUrl': imageUrl,
      'name': name,
      'description': description,
      'price': price,
      'soldBy': soldBy,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'],
      imageUrl: map['imageUrl'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      soldBy: map['soldBy'],
    );
  }
}

final List<Product> productsList = [
  Product(
    productId: '1',
    imageUrl: 'assets/images/shoes.jpeg',
    name: 'Running Shoes',
    description: 'Comfortable and durable running shoes for daily use.',
    price: 7500,
    soldBy: 'Sports World',
  ),
  Product(
    productId: '2',
    imageUrl: 'assets/images/backpack.jpg',
    name: 'Travel Backpack',
    description: 'Spacious and lightweight backpack, perfect for travel.',
    price: 1200,
    soldBy: 'Adventure Gear',
  ),
  Product(
    productId: '3',
    imageUrl: 'assets/images/smartwatch.jpg',
    name: 'Smartwatch',
    description: 'Feature-packed smartwatch with heart-rate monitoring.',
    price: 1990,
    soldBy: 'Gadget Zone',
  ),
  Product(
    productId: '4',
    imageUrl: 'assets/images/headphones.jpg',
    name: 'Wireless Headphones',
    description:
        'Noise-cancelling wireless headphones with high-quality sound.',
    price: 1500,
    soldBy: 'Music Hub',
  ),
  Product(
    productId: '5',
    imageUrl: 'assets/images/jacket.jpeg',
    name: 'Winter Jacket',
    description: 'Warm and waterproof winter jacket for outdoor adventures.',
    price: 1900,
    soldBy: 'Outdoor Outfitters',
  ),
  Product(
    productId: '6',
    imageUrl: 'assets/images/sunglasses.jpeg',
    name: 'Sunglasses',
    description: 'Stylish sunglasses with UV protection.',
    price: 100,
    soldBy: 'Fashion Accessories',
  ),
  Product(
    productId: '7',
    imageUrl: 'assets/images/keyboard.jpeg',
    name: 'Mechanical Keyboard',
    description: 'High-performance mechanical keyboard with RGB lighting.',
    price: 1300,
    soldBy: 'Tech Store',
  ),
  Product(
    productId: '8',
    imageUrl: 'assets/images/blender.jpeg',
    name: 'Kitchen Blender',
    description: 'Powerful blender for smoothies, soups, and sauces.',
    price: 800,
    soldBy: 'Home Essentials',
  ),
  Product(
    productId: '9',
    imageUrl: 'assets/images/laptop.jpeg',
    name: 'Laptop',
    description: 'High-performance laptop for work and gaming.',
    price: 99990,
    soldBy: 'Electronics Hub',
  ),
  Product(
    productId: '10',
    imageUrl: 'assets/images/phone.jpeg',
    name: 'Smartphone',
    description: 'Latest smartphone with top-notch camera and performance.',
    price: 79900,
    soldBy: 'Mobile World',
  ),
  Product(
    productId: '11',
    imageUrl: 'assets/images/watch.jpeg',
    name: 'Analog Watch',
    description: 'Classic analog watch with leather strap.',
    price: 500,
    soldBy: 'Timeless Watches',
  ),
  Product(
    productId: '12',
    imageUrl: 'assets/images/wallet.jpeg',
    name: 'Leather Wallet',
    description: 'Premium leather wallet with multiple compartments.',
    price: 450,
    soldBy: 'Leather Goods Co.',
  ),
  Product(
    productId: '13',
    imageUrl: 'assets/images/tshirt.jpeg',
    name: 'T-Shirt',
    description: 'Cotton T-shirt available in various colors.',
    price: 200,
    soldBy: 'Apparel Store',
  ),
  Product(
    productId: '14',
    imageUrl: 'assets/images/jeans.jpg',
    name: 'Jeans',
    description: 'Comfortable and stretchable denim jeans.',
    price: 700,
    soldBy: 'Denim Depot',
  ),
  Product(
    productId: '15',
    imageUrl: 'assets/images/mug.jpeg',
    name: 'Coffee Mug',
    description: 'Ceramic coffee mug with unique design.',
    price: 150,
    soldBy: 'Mug Mania',
  ),
  Product(
    productId: '16',
    imageUrl: 'assets/images/lamp.jpeg',
    name: 'Desk Lamp',
    description: 'Adjustable desk lamp with LED lighting.',
    price: 350,
    soldBy: 'Lighting Store',
  ),
  Product(
    productId: '17',
    imageUrl: 'assets/images/earbuds.jpeg',
    name: 'Wireless Earbuds',
    description: 'Compact and high-quality wireless earbuds.',
    price: 1000,
    soldBy: 'Gadget Zone',
  ),
  Product(
    productId: '18',
    imageUrl: 'assets/images/fitnessband.jpeg',
    name: 'Fitness Band',
    description: 'Fitness band with step tracking and sleep monitoring.',
    price: 450,
    soldBy: 'Fitness Gear',
  ),
  Product(
    productId: '19',
    imageUrl: 'assets/images/bottle.jpg',
    name: 'Water Bottle',
    description: 'Stainless steel water bottle with 1L capacity.',
    price: 250,
    soldBy: 'Home Essentials',
  ),
  Product(
    productId: '20',
    imageUrl: 'assets/images/camera.jpg',
    name: 'Digital Camera',
    description: 'High-resolution digital camera with advanced features.',
    price: 550,
    soldBy: 'Photography Pro',
  ),
];
