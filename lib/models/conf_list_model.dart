class Conference {
  final String typename;
  final String id;
  final String name;
  final String startDate;
  final String slogan;

  Conference({
    required this.typename,
    required this.id,
    required this.name,
    required this.startDate,
    required this.slogan,
  });

  factory Conference.fromJson(Map<String, dynamic> json) {
    return Conference(
      typename: json['__typename'],
      id: json['id'],
      name: json['name'],
      startDate: json['startDate'],
      slogan: json['slogan'],
    );
  }
}
