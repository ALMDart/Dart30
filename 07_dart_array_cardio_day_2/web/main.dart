import 'dart:html';

// ## Array Cardio Day 2

class Person {
  final String name;
  final int year;

  const Person(this.name, this.year);
}

final Set<Person> people = {
  Person('Wes', 1988),
  Person('Kait', 1986),
  Person('Irv', 1970),
  Person('Lux', 2015)
};

class Comment {
  final String text;
  final int id;

  const Comment(this.text, this.id);

  @override
  String toString() => '${id}: ${text}';
}

const List<Comment> comments = [
  Comment('Love this!', 523423),
  Comment('Super good', 823423),
  Comment('You are the best', 2039842),
  Comment('Ramen is my fav food ever', 123523),
  Comment('Nice Nice Nice!', 542328)
];

void main() {
  // Some and Every Checks
  // Array.prototype.some() // is at least one person 19?
  // const isAdult = people.some(function(person) {
  //   const currentYear = (new Date()).getFullYear();
  //   if(currentYear - person.year >= 19) {
  //     return true;
  //   }
  // });

  final isAdult =
      people.any((person) => DateTime.now().year - person.year >= 19);

  print(isAdult);
// Array.prototype.every() // is everyone 19?

  final allAdults =
      people.every((person) => DateTime.now().year - person.year >= 19);
  print({allAdults});

// Array.prototype.find()
// Find is like filter, but instead returns just the one you are looking for
// find the comment with the ID of 823423

  final comment = comments.singleWhere((comment) => comment.id == 823423);

  print(comment);

// Array.prototype.findIndex()
// Find the comment with this ID
// delete the comment with the ID of 823423
  final index = comments.indexWhere((comment) => comment.id == 823423);
  print(index);

// comments.splice(index, 1);

  final newComments = [
    ...comments.sublist(0, index),
    ...comments.sublist(index + 1)
  ];
  print(newComments);
}
