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
    required this.notes,
    required this.rating,
    required this.review,
  });

  factory Plan.fromJson(dynamic trip) {
    String tripStart = trip['start'];
    String tripEnd = trip['end'];
    String name = trip['name'];
    String destination = trip['destination'];
    String hotel = trip['hotel'];
    String address = trip['address'];
    String contact = trip['contact'];
    String checkIn = trip['check-in'];
    String checkOut = trip['check-out'];
    String transport = trip['transport'];
    String departure = trip['departure'];
    String retur = trip['return'];
    String imageUrl = trip['imageUrl'];
    String notes = trip['notes'];
    String rating = trip['rating'];
    String review = trip['review'];

    return Plan(
      tripStart: tripStart,
      tripEnd: tripEnd,
      name: name,
      destination: destination,
      hotel: hotel,
      address: address,
      contact: contact,
      checkIn: checkIn,
      checkOut: checkOut,
      transport: transport,
      departure: departure,
      retur: retur,
      imageUrl: imageUrl,
      notes: notes,
      rating: rating,
      review: review,
    );
  }
}
