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

  factory BookingClientModel.fromJson(Map<String, dynamic> json) {
    return BookingClientModel(
        id: int.parse(json['pk'].toString()),
        name: json['name'].toString(),
        email: json['email'].toString(),
        number: json['contact'].toString(),
        hotel: json['hotel'].toString(),
        mainContact: json['main_contact'],
        source: json['source'].toString(),
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
