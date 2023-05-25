class Plan {
  final String tripStart;
  final String tripEnd;
  final String name;
  final String destination;
  final String hotel;
  final String address;
  final String contact;
  final String checkIn;
  final String checkOut;
  final String transport;
  final String departure;
  final String retur;
  final String imageUrl;
  final String imageUrl2;
  final String imageUrl3;
  final String notes;
  late String rating;
  late String review;

  Plan({
    required this.tripStart,
    required this.tripEnd,
    required this.name,
    required this.destination,
    required this.hotel,
    required this.address,
    required this.contact,
    required this.checkIn,
    required this.checkOut,
    required this.transport,
    required this.departure,
    required this.retur,
    required this.imageUrl,
    required this.imageUrl2,
    required this.imageUrl3,
    required this.notes,
    required this.rating,
    required this.review,
  });
}
