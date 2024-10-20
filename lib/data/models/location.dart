import 'dart:convert';

class Location {
  String lat;
  String lon;
  Location({
    required this.lat,
    required this.lon,
  });

  Location copyWith({
    String? lat,
    String? lon,
  }) {
    return Location(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: map['lat'] as String,
      lon: map['lon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Location(lat: $lat, lon: $lon)';

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.lon == lon;
  }

  @override
  int get hashCode => lat.hashCode ^ lon.hashCode;
}
