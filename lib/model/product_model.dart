class Product {
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final String soldBy;

  Product({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.soldBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'description': description,
      'price': price,
      'soldBy': soldBy,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
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
    imageUrl: 'assets/images/shoes.jpeg',
    name: 'Running Shoes',
    description: 'Comfortable and durable running shoes for daily use.',
    price: 7500,
    soldBy: 'Sports World',
  ),
  Product(
    imageUrl: 'assets/images/backpack.jpg',
    name: 'Travel Backpack',
    description: 'Spacious and lightweight backpack, perfect for travel.',
    price: 1200,
    soldBy: 'Adventure Gear',
  ),
  Product(
    imageUrl: 'assets/images/smartwatch.jpg',
    name: 'Smartwatch',
    description: 'Feature-packed smartwatch with heart-rate monitoring.',
    price: 1990,
    soldBy: 'Gadget Zone',
  ),
  Product(
    imageUrl: 'assets/images/headphones.jpg',
    name: 'Wireless Headphones',
    description:
        'Noise-cancelling wireless headphones with high-quality sound.',
    price: 1500,
    soldBy: 'Music Hub',
  ),
  Product(
    imageUrl: 'assets/images/jacket.jpeg',
    name: 'Winter Jacket',
    description: 'Warm and waterproof winter jacket for outdoor adventures.',
    price: 1900,
    soldBy: 'Outdoor Outfitters',
  ),
  Product(
    imageUrl: 'assets/images/sunglasses.jpeg',
    name: 'Sunglasses',
    description: 'Stylish sunglasses with UV protection.',
    price: 100,
    soldBy: 'Fashion Accessories',
  ),
  Product(
    imageUrl: 'assets/images/keyboard.jpeg',
    name: 'Mechanical Keyboard',
    description: 'High-performance mechanical keyboard with RGB lighting.',
    price: 1300,
    soldBy: 'Tech Store',
  ),
  Product(
    imageUrl: 'assets/images/blender.jpeg',
    name: 'Kitchen Blender',
    description: 'Powerful blender for smoothies, soups, and sauces.',
    price: 800,
    soldBy: 'Home Essentials',
  ),
  Product(
    imageUrl: 'assets/images/laptop.jpeg',
    name: 'Laptop',
    description: 'High-performance laptop for work and gaming.',
    price: 99990,
    soldBy: 'Electronics Hub',
  ),
  Product(
    imageUrl: 'assets/images/phone.jpeg',
    name: 'Smartphone',
    description: 'Latest smartphone with top-notch camera and performance.',
    price: 79900,
    soldBy: 'Mobile World',
  ),
  Product(
    imageUrl: 'assets/images/watch.jpeg',
    name: 'Analog Watch',
    description: 'Classic analog watch with leather strap.',
    price: 500,
    soldBy: 'Timeless Watches',
  ),
  Product(
    imageUrl: 'assets/images/wallet.jpeg',
    name: 'Leather Wallet',
    description: 'Premium leather wallet with multiple compartments.',
    price: 450,
    soldBy: 'Leather Goods Co.',
  ),
  Product(
    imageUrl: 'assets/images/tshirt.jpeg',
    name: 'T-Shirt',
    description: 'Cotton T-shirt available in various colors.',
    price: 200,
    soldBy: 'Apparel Store',
  ),
  Product(
    imageUrl: 'assets/images/jeans.jpg',
    name: 'Jeans',
    description: 'Comfortable and stretchable denim jeans.',
    price: 700,
    soldBy: 'Denim Depot',
  ),
  Product(
    imageUrl: 'assets/images/mug.jpeg',
    name: 'Coffee Mug',
    description: 'Ceramic coffee mug with unique design.',
    price: 150,
    soldBy: 'Mug Mania',
  ),
  Product(
    imageUrl: 'assets/images/lamp.jpeg',
    name: 'Desk Lamp',
    description: 'Adjustable desk lamp with LED lighting.',
    price: 350,
    soldBy: 'Lighting Store',
  ),
  Product(
    imageUrl: 'assets/images/earbuds.jpeg',
    name: 'Wireless Earbuds',
    description: 'Compact and high-quality wireless earbuds.',
    price: 1000,
    soldBy: 'Gadget Zone',
  ),
  Product(
    imageUrl: 'assets/images/fitnessband.jpeg',
    name: 'Fitness Band',
    description: 'Fitness band with step tracking and sleep monitoring.',
    price: 450,
    soldBy: 'Fitness Gear',
  ),
  Product(
    imageUrl: 'assets/images/bottle.jpg',
    name: 'Water Bottle',
    description: 'Stainless steel water bottle with 1L capacity.',
    price: 250,
    soldBy: 'Home Essentials',
  ),
  Product(
    imageUrl: 'assets/images/camera.jpg',
    name: 'Digital Camera',
    description: 'High-resolution digital camera with advanced features.',
    price: 550,
    soldBy: 'Photography Pro',
  ),
];
