import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_trip_app/auth.dart';

class Trip {
  Future<void> addPlanTrip(
    String tripStart,
    String tripEnd,
    String name,
    String destination,
    String hotel,
    String address,
    String contact,
    String checkIn,
    String checkOut,
    String transport,
    String departure,
    String retur,
    String imageUrl,
  ) async {
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: Auth().currentUser?.email)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      final userId = userQuerySnapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('trip-plan')
          .add({
        'start': tripStart,
        'end': tripEnd,
        'name': name,
        'destination': destination,
        'hotel': hotel,
        'address': address,
        'contact': contact,
        'check-in': checkIn,
        'check-out': checkOut,
        'transport': transport,
        'departure': departure,
        'return': retur,
        'imageUrl': imageUrl,
      });
    }
  }
}
