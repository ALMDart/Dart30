import 'dart:html';

// Get your shorts on - this is an array workout!
// ## Array Cardio Day 1

// Some data we can work with

class Inventor {
  final String firstName;
  final String lastName;
  final int year;
  final int passed;

  const Inventor(this.firstName, this.lastName, this.year, this.passed);

  @override
  String toString() {
    return '${firstName}, ${lastName}, ${year}, ${passed}';
  }
}

List<Inventor> inventors = [
  Inventor('Albert', 'Einstein', 1879, 1955),
  Inventor('Isaac', 'Newton', 1643, 1727),
  Inventor('Galileo', 'Galilei', 1564, 1642),
  Inventor('Marie', 'Curie', 1867, 1934),
  Inventor('Johannes', 'Kepler', 1571, 1630),
  Inventor('Nicolaus', 'Copernicus', 1473, 1543),
  Inventor('Max', 'Planck', 1858, 1947),
  Inventor('Katherine', 'Blodgett', 1898, 1979),
  Inventor('Ada', 'Lovelace', 1815, 1852),
  Inventor('Sarah E.', 'Goode', 1855, 1905),
  Inventor('Lise', 'Meitner', 1878, 1968),
  Inventor('Hanna', 'Hammarström', 1829, 1909)
];

List<String> people = [
  'Beck, Glenn',
  'Becker, Carl',
  'Beckett, Samuel',
  'Beddoes, Mick',
  'Beecher, Henry',
  'Beethoven, Ludwig',
  'Begin, Menachem',
  'Belloc, Hilaire',
  'Bellow, Saul',
  'Benchley, Robert',
  'Benenson, Peter',
  'Ben-Gurion, David',
  'Benjamin, Walter',
  'Benn, Tony',
  'Bennington, Chester',
  'Benson, Leana',
  'Bent, Silas',
  'Bentsen, Lloyd',
  'Berger, Ric',
  'Bergman, Ingmar',
  'Berio, Luciano',
  'Berle, Milton',
  'Berlin, Irving',
  'Berne, Eric',
  'Bernhard, Sandra',
  'Berra, Yogi',
  'Berry, Halle',
  'Berry, Wendell',
  'Bethea, Erin',
  'Bevan, Aneurin',
  'Bevel, Ken',
  'Biden, Joseph',
  'Bierce, Ambrose',
  'Biko, Steve',
  'Billings, Josh',
  'Biondo, Frank',
  'Birrell, Augustine',
  'Black Elk',
  'Blair, Robert',
  'Blair, Tony',
  'Blake, William'
];

void main() {
// Array.prototype.filter()
// 1. Filter the list of inventors for those who were born in the 1500's
  final fifteen = inventors
      .where((inventor) => (inventor.year >= 1500 && inventor.year < 1600));

  print(fifteen);

// Array.prototype.map()
// 2. Give us an array of the inventor first and last names
  final fullNames =
      inventors.map((inventor) => '${inventor.firstName} ${inventor.lastName}');
  print(fullNames);

// Array.prototype.sort()
// 3. Sort the inventors by birthdate, oldest to youngest
  inventors.sort((a, b) => a.year.compareTo(b.year));
  print(inventors);

// Array.prototype.reduce()
// 4. How many years did all the inventors live?
  final totalYears = inventors.fold(
      0, (total, inventor) => total + (inventor.passed - inventor.year));

  print(totalYears);

// 5. Sort the inventors by years lived
  inventors.sort((a, b) {
    final lastInventor = a.passed - a.year;
    final nextInventor = b.passed - b.year;
    return lastInventor > nextInventor ? -1 : 1;
  });
  print(inventors);

// 6. create a list of Boulevards in Paris that contain 'de' anywhere in the name
// https://en.wikipedia.org/wiki/Category:Boulevards_in_Paris

//  final category = querySelector('.mw-category');
//  final links = category.querySelectorAll('a');
//  final de = links
//      .map((link) => link.text)
//      .where((streetName) => streetName.contains('de'));

// 7. sort Exercise
// Sort the people alphabetically by last name
  people.sort((lastOne, nextOne) {
    final aLast = lastOne.split(', ')[0];
    final bLast = nextOne.split(', ')[0];
    return aLast.compareTo(bLast);
  });
  print(people);

// 8. Reduce Exercise
// Sum up the instances of each of these
  const data = [
    'car',
    'car',
    'truck',
    'truck',
    'bike',
    'walk',
    'car',
    'van',
    'bike',
    'walk',
    'car',
    'van',
    'car',
    'truck',
    'pogostick'
  ];
  final transportation = data.fold({}, (obj, item) {
    if (obj[item] == null) {
      obj[item] = 0;
    }
    obj[item]++;
    return obj;
  });

  print(transportation);
}
