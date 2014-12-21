// Copyright (c) 2014, laco. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library objective_regex.example.url;

import 'package:objective_regex/objective_regex.dart';

main() {
  /// Simple url regex
  var pattern = new RPattern()
    ..startOfLine()
    ..addPatterns(
    [
      // (https?:\/\/)?
      new RGroup()
        ..addPatterns(
        [
          "http",
          new RPattern("s")
            ..maybe(),
          r":\/\/"
        ])
        ..maybe(),
      // ([\da-z\.-]+)
      new RGroup()
        ..addPattern(
        new RClass()
          ..addPatterns(
          [
            r"0-9",
            r"a-zA-Z",
            r"\.",
            r"-"
          ])
          ..repeatLeastOnce()),
      r"\.",
      // ([a-z\.]{2,6})
      new RGroup()
        ..addPattern(
        new RClass(r"a-z\.")
          ..repeat(minCount:2, maxCount:6)),
      // ([\/\w \.-]*)*
      new RGroup()
        ..addPattern(
        new RClass()
          ..addPatterns(
          [
            r"/",
            r"\w",
            r"\.",
            "-"
          ])
          ..repeat())
        ..repeat(),
      // \/?
      new RPattern(r"/")
        ..maybe()
    ])
    ..endOfLine();
  var regex = pattern.build();
  print("Built regex: $regex");
  print(new RegExp(regex).hasMatch("http://www.google.com/"));
}
