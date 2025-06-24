
class CarModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double pricePerDay;
  final String location;
  final String fuelCapacity;

  CarModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.pricePerDay,
    required this.location,
    required this.fuelCapacity,
  });

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      fuelCapacity: map['fuelCapacity'],
      imageUrl: (map['images'] as List).isNotEmpty ? map['images'][0] : '',
      pricePerDay: (map['price_per_day'] as num).toDouble(),
      location: map['location'],
    );
  }
}
