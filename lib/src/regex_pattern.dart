// Copyright (c) 2014, laco. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of objective_regex;

/**
 * Regex pattern object.
 */
class RPattern {

  List _children = [];

  RPattern([String pattern]) {
    if (pattern != null) {
      addPattern(pattern);
    }
  }

  factory RPattern.asClass([String pattern]){
    return new RClass(pattern);
  }

  factory RPattern.asGroup([List patterns]){
    return new RGroup(patterns);
  }

  build() {
    var pattern = _children.fold("", (v, element) {
      if (element is RPattern) {
        return v + element.build();
      }
      else {
        return v + element.toString();
      }
    });
    var prefix = "";
    if (_startOfLine) {
      prefix += "^";
    }
    pattern = "$prefix$pattern";
    var postFix = _repeatingSuffix;
    if (_endOfLine) {
      postFix += "\$";
    }
    pattern = "$pattern$postFix";
    return pattern;
  }

  /**
   * Add pattern.
   */
  addPattern(pattern) {
    if (pattern == null) {
      throw new ArgumentError.notNull("pattern");
    }
    if (pattern is String || pattern is RPattern) {
      _children.add(pattern);
    }
    else {
      throw new ArgumentError.value(pattern, "pattern's type must be String or Pattern");
    }
  }

  /**
   * Add patterns
   */
  addPatterns(List patterns) {
    for (var p in patterns) {
      addPattern(p);
    }
  }

  String _repeatingSuffix = "";

  /**
   * Convert the expression to class. "[a-z]" -> [a-z] [a-z]{1, 2}
   */
  repeat({int count : 0, int minCount : 0, int maxCount : 0}) {
    if (count > 0) {
      _repeatingSuffix += "{$count}";
    }
    else if (minCount < 1 && maxCount < 1) {
      _repeatingSuffix += "*";
    }
    else {
      var min = minCount < 1 ? "" : minCount;
      var max = maxCount < 1 ? "" : maxCount;
      _repeatingSuffix += "{$min,$max}";
    }
  }

  /**
   * Repeat least once. [a-z] -> [a-z]+
   */
  repeatLeastOnce() {
    _repeatingSuffix += "+";
  }

  /**
   * Maybe exists. [a-z] -> [a-z]?
   */
  maybe() {
    _repeatingSuffix += "?";
  }

  bool _startOfLine = false, _endOfLine = false;

  /**
   * Start of a line of string. "[a-z]" -> "^[a-z]"
   */
  startOfLine() {
    _startOfLine = true;
  }

  /**
   * End of a line of string. "[a-z]" -> "^[a-z]"
   */
  endOfLine() {
    _endOfLine = true;
  }
}

