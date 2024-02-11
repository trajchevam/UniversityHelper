class Location {
  final String locationName;
  final double latitude;
  final double longitude;

  Location(
      {required this.locationName, required this.latitude, required this.longitude});

  static List<Location> getLocations() {
    return [
      Location(locationName: "Location 1", latitude: 42.004486, longitude: 21.4072295),
      Location(locationName: "Location 2", latitude: 42.0049858, longitude: 21.4034476),
    ];
  }

  static Location location1 = Location.getLocations()[0];
  static Location location2 = Location.getLocations()[1];
}