// Copyright (c) 2014, laco. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library objective_regex.example.screen_name;

import 'package:objective_regex/objective_regex.dart';

main() {
  /// Twitter screen_name i.e. @laco0416
  var pattern = new RPattern()
    ..addPatterns(
    [
      "@",
      new RClass("a-zA-Z0-9_")
        ..repeatLeastOnce()
    ]);
  var regex = pattern.build();
  print("Built regex: $regex");
  print(new RegExp(regex).hasMatch("@laco0416"));
}
