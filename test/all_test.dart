// Copyright (c) 2014, laco. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library objective_regex.test;

import 'package:guinness/guinness.dart';
import 'package:objective_regex/objective_regex.dart';

main() {
  describe('RegexBuilder', () {

    RPattern builder;

    beforeEach(() {
      builder = new RPattern();
    });

    it('single pattern build', () {
      builder.addPattern(".*");
      expect(builder.build()).toEqual(r".*");
    });

    it('join added patterns', () {
      builder.addPattern("A");
      builder.addPattern("B");
      expect(builder.build()).toEqual(r"AB");
    });

    describe("regex class", () {
      it('create by RPattern.asClass', () {
        var alphabet = new RPattern.asClass("a-z");
        builder.addPattern(alphabet);
        expect(builder.build()).toEqual(r"[a-z]");
      });

      it('create by RClass', () {
        var alphabet = new RClass("a-z");
        builder.addPattern(alphabet);
        expect(builder.build()).toEqual(r"[a-z]");
      });
    });

    describe('repeating', () {
      it('unlimited repeat', () {
        var A = new RPattern("A")
          ..repeat();
        builder.addPattern(A);
        expect(builder.build()).toEqual(r"A*");
      });

      it('repeat three times', () {
        var AAA = new RPattern("A")
          ..repeat(count: 3);
        builder.addPattern(AAA);
        expect(builder.build()).toEqual(r"A{3}");
      });

      it('repeat more than three times', () {
        var A = new RPattern("A")
          ..repeat(minCount: 3);
        builder.addPattern(A);
        expect(builder.build()).toEqual(r"A{3,}");
      });

      it('repeat less than three times', () {
        var A = new RPattern("A")
          ..repeat(maxCount: 3);
        builder.addPattern(A);
        expect(builder.build()).toEqual(r"A{,3}");
      });

      it('repeat least once', () {
        var A = new RPattern("A")
          ..repeatLeastOnce();
        builder.addPattern(A);
        expect(builder.build()).toEqual(r"A+");
      });

      it('exists maybe', () {
        var A = new RPattern("A")
          ..maybe();
        builder.addPattern(A);
        expect(builder.build()).toEqual(r"A?");
      });

      it('class repeating', () {
        var A = new RClass("ABC")
          ..repeat(count:3);
        builder.addPattern(A);
        expect(builder.build()).toEqual(r"[ABC]{3}");
      });

      it('group repeating', () {
        var A = new RGroup(["A", "B"])
          ..repeat(count:3);
        builder.addPattern(A);
        expect(builder.build()).toEqual(r"(A|B){3}");
      });
    });

    describe("grouping", () {
      it('group patterns', () {
        builder
          ..addPattern(new RGroup(["A", "B"]));
        expect(builder.build()).toEqual("(A|B)");
      });
    });

    describe("prefix, suffix", () {
      it("match to start of line", () {
        builder
          ..addPattern("A")
          ..startOfLine();
        expect(builder.build()).toEqual("^A");
      });
      it("match to end of line", () {
        builder
          ..addPattern("A")
          ..endOfLine() ;
        expect(builder.build()).toEqual(r"A$");
      });
    });
  });
}
