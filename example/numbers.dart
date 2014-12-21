// Copyright (c) 2014, laco. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library objective_regex.example.numbers;

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
