import 'dart:convert';
import 'dart:html';

class City {
  final String city;
  final String growth_from_2000_to_2013;
  final double latitude;
  final double longitude;
  final String population;
  final String rank;
  final String state;

  const City(this.city, this.growth_from_2000_to_2013, this.latitude,
      this.longitude, this.population, this.rank, this.state);
}

final endpoint =
    'https://gist.githubusercontent.com/Miserlou/c5cd8364bf9b2420bb29/raw/2bf258763cdddd704f8ffd3ea9a3e81d25e2c6f6/cities.json';

var cities = <City>{};

Iterable<City> findMatches(wordToMatch, cities) {
  return cities.where((City place) {
    // here we need to figure out if the city or state matches what was searched
    final regex = RegExp(wordToMatch, multiLine: true, caseSensitive: false);
    return regex.hasMatch(place.city) || regex.hasMatch(place.state);
  });
}

String numberWithCommas(x) {
  return x
      .toString()
      .replaceAll(RegExp('\B(?=(\d{3})+(?!\d))', multiLine: true), ',');
}

void displayMatches(Event e) {
  final value = (e.currentTarget as InputElement).value;
  final matchArray = findMatches(value, cities);
  final html = matchArray.map((place) {
    final regex = RegExp(value, multiLine: true, caseSensitive: false);
    final cityName =
        place.city.replaceAll(regex, '<span class="hl">${value}</span>');
    final stateName =
        place.state.replaceAll(regex, '<span class="hl">${value}</span>');
    return '''
  <li>
  <span class="name">${cityName}, ${stateName}</span>
    <span class="population">${numberWithCommas(place.population)}</span>
  </li>
  ''';
  }).join('');
  final suggestions = querySelector('.suggestions') as UListElement;
  suggestions.innerHtml = html;
}

void main() async {
  final data = await HttpRequest.request(
    endpoint,
    method: 'GET',
  );
  final json = jsonDecode(data.responseText);
  json.forEach((val) => cities.add(City(
      val['city'],
      val['growth_from_2000_to_2013'],
      val['latitude'],
      val['longitude'],
      val['population'],
      val['rank'],
      val['state'])));

  final searchInput = querySelector('.search');

  searchInput.addEventListener('change', displayMatches);
  searchInput.addEventListener('keyup', displayMatches);
}
