class PropertyListing {
  final String id;
  final String title;
  final String desc;
  final String location;
  final String price;
  final String interior;
  final String bedrooms;
  final String bathrooms;
  final List<String> imageUrl;

  PropertyListing({
    required this.id,
    required this.title,
    required this.desc,
    required this.location,
    required this.price,
    required this.interior,
    required this.bedrooms,
    required this.bathrooms,
    required this.imageUrl,
  });

  factory PropertyListing.fromMap(Map<String, dynamic> map) {
    return PropertyListing(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      desc: map['desc'] ?? '',
      location: map['location'] ?? '',
      price: map['price'] ?? '',
      interior: map['interior'] ?? '',
      bedrooms: map['bedrooms'] ?? '',
      bathrooms: map['bathrooms'] ?? '',
      imageUrl: List<String>.from(map['imageUrl'] ?? []),
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'location': location,
      'price': price,
      'interior': interior,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'imageUrl': imageUrl,
    };
  }
}
