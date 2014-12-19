part of objective_regex;

/**
 * Regex group object
 */
class RGroup extends RPattern {

  RGroup([List patterns]): super() {
    addPatterns(patterns);
  }

  /**
   * Build regex as group class
   */
  build() {
    var pattern = "(${_children.map((p) {
      if (p is RPattern) {
        return (p as RPattern).build();
      } else {
        return p;
      }
    }).join("|")})";
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