class BookingClientModel {
  int id;
  String? name;
  String? number;
  String? email;
  String? nationality;
  String? hotel;
  String? source;
  bool mainContact;

  BookingClientModel(
      {required this.id,
      this.name,
      this.number,
      this.email,
      this.nationality,
      this.hotel,
      this.source,
      required this.mainContact});

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
