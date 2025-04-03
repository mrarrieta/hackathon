class ProfileModel {
  final String name;
  final String lastname;
  final String description;
  final String birthYear;
  final String? imageBase64;

  ProfileModel({
    required this.name,
    required this.lastname,
    required this.description,
    required this.birthYear,
    this.imageBase64,
  });
}
