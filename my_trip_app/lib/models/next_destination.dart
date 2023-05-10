class ImageDestination {
  final String url;

  ImageDestination({required this.url});

  factory ImageDestination.fromJson(Map<String, dynamic> json) {
    return ImageDestination(
        url: json["photos"][0]["src"]["original"] as String);
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
