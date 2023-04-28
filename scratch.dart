double main () {
  String x = 'abc';

  try {
    // Double'a çeviriyor string'i
    double xDouble = double.parse(x);

    double y = 5.2 + xDouble;

    return y;

    // e is shortcut for exception

  } catch (e) {
    print(e);

    double y = 12.5;

    print('new y is: $y');

    return y;
  }
}
