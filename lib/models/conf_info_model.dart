class ConferenceInfoModel {
  final String? id;
  final String? name;
  final String? startDate;
  final Organizer? organizer;
  final List<Speaker>? speakers;
  final List<Sponsor>? sponsors;
  final List<Schedule>? schedules;

  ConferenceInfoModel({
    this.id,
    this.name,
    this.startDate,
    this.organizer,
    this.speakers,
    this.sponsors,
    this.schedules,
  });

  factory ConferenceInfoModel.fromJson(Map<String, dynamic> json) {
    return ConferenceInfoModel(
      id: json['id'],
      name: json['name'],
      startDate: json['startDate'],
      organizer: json['organizer'] != null ? Organizer.fromJson(json['organizer']) : null,
      sponsors: json['sponsors'] != null ? (json['sponsors'] as List).map((sponsor) => Sponsor.fromJson(sponsor)).toList() : null,
      speakers: json['speakers'] != null ? List<Speaker>.from(json['speakers'].map((x) => Speaker.fromJson(x))) : null,
      schedules: json['schedules'] != null ? List<Schedule>.from(json['schedules'].map((x) => Schedule.fromJson(x))) : null,
    );
  }
}

class Organizer {
  final String name;
  final Image? image;
  final String about;

  Organizer({required this.name, this.image, required this.about});

  factory Organizer.fromJson(Map<String, dynamic> json) {
    return Organizer(
      name: json['name'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      about: json['about'],
    );
  }
}

class Speaker {
  final String name;
  final Image? image;
  final String about;

  Speaker({required this.name, this.image, required this.about});

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      name: json['name'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      about: json['about'],
    );
  }
}

class Sponsor {
  final String? name;
  final Image? image;
  final String? about;

  Sponsor({ this.name, this.image,  this.about});

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      name: json['name'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      about: json['about'],
    );
  }
}

class Image {
  final String url;

  Image({required this.url});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
    );
  }
}

class Schedule {
  final String day;
  final String description;
  final List<Interval>? intervals;

  Schedule({required this.day, required this.description, this.intervals});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      day: json['day'],
      description: json['description'],
      intervals: json['intervals'] != null ? (json['intervals'] as List).map((interval) => Interval.fromJson(interval)).toList() : null,
    );
  }
}

class Interval {
  final List<Session>? sessions;

  Interval({this.sessions});

  factory Interval.fromJson(Map<String, dynamic> json) {
    return Interval(
      sessions: json['sessions'] != null ? (json['sessions'] as List).map((session) => Session.fromJson(session)).toList() : null,
    );
  }
}

class Session {
  final String title;
  final String begin;
  final String end;

  Session({required this.title, required this.begin, required this.end});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      title: json['title'],
      begin: json['begin'],
      end: json['end'],
    );
  }
}
