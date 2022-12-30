class Trip {
  int pk;
  String state;
  String boat;
  DateTime departure;
  int capacity;

  Trip({
    required this.pk,
    required this.state,
    required this.boat,
    required this.departure,
    required this.capacity,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
        departure: DateTime.parse(json['departure'] as String),
        pk: int.parse(json['pk'].toString()),
        capacity: int.parse(json['capacity'].toString()),
        state: json['state'].toString(),
        boat: json['boat'].toString());
  }
}
