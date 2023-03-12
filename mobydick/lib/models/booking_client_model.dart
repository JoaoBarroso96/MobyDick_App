class BookingClientModel {
  int id;
  String? name;
  String? number;
  String? email;
  String? nationality;
  String? hotel;
  String? source;
  int? bookingId;
  bool mainContact;

  BookingClientModel(
      {required this.id,
      this.name,
      this.number,
      this.email,
      this.nationality,
      this.hotel,
      this.source,
      this.bookingId,
      required this.mainContact});

  factory BookingClientModel.fromJson(Map<String, dynamic> json) {
    return BookingClientModel(
        id: int.parse(json['pk']?.toString() ?? "0"),
        name: json['name'].toString(),
        email: json['email'].toString(),
        number: json['contact'].toString(),
        hotel: json['hotel'].toString(),
        mainContact: json['main_contact'],
        source: json['source'].toString(),
        bookingId: int.parse(json['booking_id'].toString()),
        nationality: json['nationality'].toString());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'contact': number,
        'hotel': hotel,
        'nationality': nationality,
        'main_contact': mainContact,
        'source': source,
      };
}
