class ProfileModel {
  final String name;
  final String lastname;
  final String description;
  final String birthDate;
  final String? imageBase64;

  ProfileModel({
    required this.name,
    required this.lastname,
    required this.description,
    required this.birthDate,
    this.imageBase64,
  });
}
