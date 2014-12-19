part of objective_regex;

/**
 * Regex word class object
 */
class RClass extends RPattern {

  static get NUMBER => new RClass("0-9");

  static get ALPHABET_LOWER => new RClass("a-z");

  static get ALPHABET_UPPER => new RClass("A-Z");

  static get ALPHABET => new RClass("a-zA-Z");

  RClass(String pattern): super(pattern);

  /**
   * Build regex as word class
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
    pattern = "[$pattern]";
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

}