module test

import difference { difference }
import khalyomede.faker { Faker }
import os

fn test_it_returns_difference_between_different_single_line_strings() {
    mut fake := Faker{}

    before := fake.word()
    after := fake.word()

    actual := difference(before, after) or { "" }
    expected := [
        "- ${before}"
        "+ ${after}"
    ].join("\n")

    assert expected == actual
}

fn test_it_returns_no_difference_if_two_one_line_strings_are_equals() {
    mut fake := Faker{}

    before := fake.word()
    after := before

    expected := ""
    actual := difference(before, after) or { ""}

    assert expected == actual
}

fn test_it_returns_no_differene_if_two_multi_lines_strings_are_equals() {
    mut fake := Faker{}

    before := []string{len: 10}.map(fake.sentence()).join(match os.user_os() {
        "windows" { "\r\n" }
        else { "\n" }
    })
    after := before

    expected := ""
    actual := difference(before, after) or { "" }

    assert expected == actual
}

fn test_it_generates_differene_when_both_strings_have_same_lines_number_but_with_one_line_difference() {
    line_return := match os.user_os() {
        "windows" { "\r\n" }
        else { "\n" }
    }

    mut fake := Faker{}

    name_before := fake.first_name()
    name_after := fake.first_name()

    before := [
        "module main"
        ""
        "fn main() {"
        '  name := "${name_before}"'
        "  "
        "  println(name)"
        "}"
        ""
    ].join(line_return)

    after := [
        "module main"
        ""
        "fn main() {"
        '  name := "${name_after}"'
        "  "
        "  println(name)"
        "}"
        ""
    ].join(line_return)

    expected := [
        "  module main"
        "  "
        "  fn main() {"
        '-   name := "${name_before}"'
        '+   name := "${name_after}"'
        "    "
        "    println(name)"
        "  }"
        "  "
    ].join(line_return)
    actual := difference(before, after) or { "" }

    assert expected == actual
}
