# objective_regex

[![Build Status][status]][status badge] [![Pub][pub badge]][pub]

A dart library for generating regex pattern strings in an object-oriented style.

## Usage

A simple usage example:

```dart
    import 'package:objective_regex/objective_regex.dart';

    main() {
      /// ##-####-#### or ## #### ####
      var pattern = new RPattern()
        ..addPatterns(
        [
          RClass.NUMBER
            ..repeat(count:2),
          new RPattern("-")
            ..maybe(),
          RClass.NUMBER
            ..repeat(count:4),
          new RPattern("-")
            ..maybe(),
          RClass.NUMBER
            ..repeat(count:4)
        ]);
      var regex = pattern.build();
      print("Built regex: $regex");
      print(new RegExp(regex).hasMatch("12-3456-7890"));
    }
```

[status]: https://drone.io/github.com/laco0416/objective_regex/status.png
[status badge]: https://drone.io/github.com/laco0416/objective_regex/latest
[pub]: https://pub.dartlang.org/packages/objective_regex
[pub badge]: http://img.shields.io/pub/v/objective_regex.svg