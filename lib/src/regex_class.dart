part of objective_regex;

/**
 * Regex word class object
 */
class RClass extends RPattern {

  /**
   * Number word class ([0-9])
   */
  static RClass get NUMBER => new RClass("0-9");

  /**
   * Lower alphabet word class ([a-z])
   */
  static RClass get ALPHABET_LOWER => new RClass("a-z");

  /**
   * Upper alphabet word class ([A-Z])
   */
  static RClass get ALPHABET_UPPER => new RClass("A-Z");

  /**
   * Alphabet word class ([a-zA-Z])
   */
  static RClass get ALPHABET => new RClass("a-zA-Z");

  RClass([String pattern]): super(pattern);

  bool _negative = false;

  /**
   * Negate class expression. "[a-z]" -> "[^a-z]"
   */
  negate() {
    _negative = true;
  }

  @override
  addPattern(String pattern) {
    super.addPattern(pattern);
  }

  @override
  addPatterns(List<String> patterns) {
    super.addPatterns(patterns);
  }

  /**
   * Build regex as word class
   */
  @override
  build() {
    var pattern = _children.fold("", (v, element) {
      if (element is RPattern) {
        return v + element.build();
      }
      else {
        return v + element.toString();
      }
    });
    if (_negative) {
      pattern = "^$pattern";
    }
    pattern = "[$pattern]";
    var prefix = "";
    if (_startOfLine) {
      prefix += "^";
    }
    var postFix = _repeatingSuffix;
    if (_endOfLine) {
      postFix += "\$";
    }
    pattern = "$prefix$pattern$postFix";
    return pattern;
  }

}