enum Country {

  korea(name: 'Republic of Korea', number: '+82'),
  america(name: 'USA', number: '+1'),
  canada(name: 'Canada', number: '+1'),
  russia(name: 'Russia', number: '+7'),
  france(name: 'France', number: '+33'),
  australia(name: 'Australia', number: '+61'),
  philippines(name: 'Philippines', number: '+63'),
  thailand(name: 'Thailand', number: '+66'),
  japan(name: 'Japan', number: '+81'),
  vietnam(name: 'Vietnam', number: '+84'),
  china(name: 'China', number: '+86');

  const Country({
    required this.name,
    required this.number,
  });

  final String name;
  final String number;
}