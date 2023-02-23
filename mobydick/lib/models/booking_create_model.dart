import 'package:mobydick/models/booking_client_model.dart';

class BookingCreateModel {
  int idTrip;
  List<BookingClientModel> boookingClient;

  BookingCreateModel({required this.idTrip, required this.boookingClient});

  Map<String, dynamic> toJson() => {
        'trip_ref': idTrip,
        'clientsDetails': boookingClient,
      };
}
