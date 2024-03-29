class Trip {
  int pk;
  String state;
  String boat;
  DateTime departure;
  int capacity;
  int occupancy;

  Trip({
    required this.pk,
    required this.state,
    required this.boat,
    required this.departure,
    required this.capacity,
    required this.occupancy,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
        departure: DateTime.parse(json['departure'] as String),
        pk: int.parse(json['pk'].toString()),
        capacity: int.parse(json['capacity'].toString()),
        state: json['state'].toString(),
        occupancy: int.parse(json['occupancy'].toString()),
        boat: json['boat'].toString());
  }

  double getOccupancyPercentage() {
    return occupancy / capacity;
  }
}
