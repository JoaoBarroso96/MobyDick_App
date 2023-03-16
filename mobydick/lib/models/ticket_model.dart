import 'package:mobydick/models/booking_client_model.dart';

class 
Ticket {
  String ref;
  String state;
  String paymentState;
  BookingClientModel bookingClientModel;

  Ticket({
    required this.ref,
    required this.state,
    required this.paymentState,
    required this.bookingClientModel,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    BookingClientModel bookingClient =
        BookingClientModel.fromJson(json['client_details']);
    return Ticket(
        state: json['state'].toString(),
        ref: json['ref'].toString(),
        bookingClientModel: bookingClient,
        paymentState: json['payment_state'].toString());
  }
}
