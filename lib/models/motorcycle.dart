class Motorcycle {
  final String name;
  final String brand;
  final int year;
  final double cv;
  final int cc;
  final double tankCapacity;
  final double performance;
  final double price;
  final int quantity;
  final int? cylinders;
  final String? image;
  final String? testLink;

  const Motorcycle({ 
    required this.name, 
    required this.brand, 
    required this.year,
    required this.price,
    required this.cv,
    required this.cc,
    required this.tankCapacity,
    required this.performance, 
    required this.quantity, 
    this.cylinders = 1,
    this.image,
    this.testLink,
  });
}
