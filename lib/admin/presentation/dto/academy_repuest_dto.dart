class AcademyRequestDto {

  final String _academyName;
  final String _name;
  final String _number;

  const AcademyRequestDto({
    required String academyName,
    required String name,
    required String number,
  })  : _academyName = academyName,
        _name = name,
        _number = number;

  String get number => _number;
  String get name => _name;
  String get academyName => _academyName;
}