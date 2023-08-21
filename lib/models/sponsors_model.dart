import 'conf_info_model.dart';

class SponsorModel {
  List<String>? type;
  Image? image;

  SponsorModel({
    this.type,
    this.image,
  });

  factory SponsorModel.fromJson(Map<String, dynamic> json) => SponsorModel(
    type: json["type"] == null ? [] : List<String>.from(json["type"].map((x) => x)),
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );
}
