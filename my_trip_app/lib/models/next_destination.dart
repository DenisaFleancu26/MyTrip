class ImageDestination {
  final List<String> url;

  ImageDestination({required this.url});

  factory ImageDestination.fromJson(Map<dynamic, dynamic> data) {
    final List<dynamic> maps = data['photos'] as List<dynamic>;
    List<String> urls = [];
    for (var map in maps) {
      urls.add(map['src']['original']);
    }

    return ImageDestination(
      url: urls,
    );
  }
}

class NextDestination {
  final String destinationName;
  final String countryName;
  final List<String> images;

  NextDestination({
    required this.destinationName,
    required this.countryName,
    required this.images,
  });

  factory NextDestination.fromJson(Map<String, dynamic> json) {
    return NextDestination(
      destinationName: "",
      countryName: "",
      images: [],
    );
  }
}
