class AcademyRequestDto {

  final String academyName;
  final String masterName;
  final String phoneNumber;
  final String countryNumber;
  final DateTime createdTime = DateTime.now();

  AcademyRequestDto({
    required this.academyName,
    required this.masterName,
    required this.phoneNumber,
    required this.countryNumber,
  });
}