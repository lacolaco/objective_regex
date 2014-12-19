# objective_regex

A dart library for generating regex pattern strings in an object-oriented style.

## Usage

A simple usage example:

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

