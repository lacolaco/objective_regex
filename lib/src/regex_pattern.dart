// Copyright (c) 2014, laco. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of objective_regex;

/**
 * Regex pattern object
 */
class RPattern {

  /**
   * Word boundary meta character (\b)
   */
  static RPattern get BOUNDARY => new RPattern(r"\b");

  /**
   * New line meta character (\n)
   */
  static RPattern get NEW_LINE => new RPattern(r"\n");

  /**
   * Tab stop meta character (\t)
   */
  static RPattern get TAB_CHARACTER => new RPattern(r"\t");

  /**
   * All word meta character (\w)
   */
  static RPattern get ALL_WORD => new RPattern(r"\w");

  /**
   * All non-word meta character (\W)
   */
  static RPattern get ALL_NON_WORD => new RPattern(r"\W");

  /**
   * Space meta character (\s)
   */
  static RPattern get SPACE => new RPattern(r"\s");

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

  /**
   * Build [RPattern] to [String]
   */
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
    if (_startOfWord) {
      prefix += r"\b";
    }
    if (_startOfLine) {
      prefix += r"^";
    }
    var postFix = _repeatingSuffix;
    if (_endOfWord) {
      postFix += r"\b";
    }
    if (_endOfLine) {
      postFix += r"$";
    }
    pattern = "$prefix$pattern$postFix";
    return pattern;
  }

  /**
   * Add pattern
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
   * Repeat this.
   *
   * If [count] is set, "[a-z]" become "[a-z]{count}".
   * If [minCount] or [maxCount] are set, "[a-z]" become "[a-z]{[minCount], [maxCount]}".
   * If no arguments, "[a-z]" become "[a-z]*".
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
   * Repeat least once. "[a-z]" -> "[a-z]+"
   */
  repeatLeastOnce() {
    _repeatingSuffix += "+";
  }

  /**
   * Maybe exists. "[a-z]" -> "[a-z]?"
   */
  maybe() {
    _repeatingSuffix += "?";
  }

  bool _startOfLine = false, _endOfLine = false, _startOfWord = false, _endOfWord = false;

  /**
   * Start of a line of string. "[a-z]" -> "^[a-z]"
   */
  startOfLine() {
    _startOfLine = true;
  }

  /**
   * End of a line of string. "[a-z]" -> "[a-z]$"
   */
  endOfLine() {
    _endOfLine = true;
  }

  /**
   * Start of a word of string. "[a-z]" -> "\b[a-z]"
   */
  startOfWord() {
    _startOfWord = true;
  }

  /**
   * End of a word of string. "[a-z]" -> "[a-z]\b"
   */
  endOfWord() {
    _endOfWord = true;
  }
}

