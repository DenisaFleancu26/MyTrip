import 'dart:convert';
import 'dart:io';
import 'package:my_trip_app/constants/app_urls.dart';
import '../models/next_destination.dart';
import 'package:http/http.dart' as http;

Future<ImageDestination> fetchImages() async {
  final response = await http.get(
    Uri.parse(AppUrls.getImagesForCountry("corfu")),

    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: AppUrls.apiKey,
    },
  );
  final responseJson = jsonDecode(response.body);

  return ImageDestination.fromJson(responseJson);
}
