part of objective_regex;

/**
 * Regex group object
 */
class RGroup extends RPattern {

  RGroup([List patterns]): super() {
    if (patterns != null) {
      addPatterns(patterns);
    }
  }

  bool _splitAsOr = false;

  splitAsOr() {
    _splitAsOr = true;
  }

  /**
   * Build regex as group class
   */
  @override
  build() {
    String pattern;
    if (_splitAsOr) {
      pattern = "(${_children.map((p) {
        if (p is RPattern) {
          return (p as RPattern).build();
        } else {
          return p;
        }
      }).join("|")})";
    } else {
      pattern = _children.fold("", (v, element) {
        if (element is RPattern) {
          return v + element.build();
        }
        else {
          return v + element.toString();
        }
      });
      pattern = "($pattern)";
    }
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