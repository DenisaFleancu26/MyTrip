class AppUrls {
  static const String apiKey =
      "nAko7DVLoOAq6mb8EzhlortBoVVVssojo8Gap087KaL4tIRBveY23aVt";

  static String getImagesForCountry(String country) {
    return 'https://api.pexels.com/v1/search?query=$country&per_page=4';
  }
}
