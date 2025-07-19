module difference

import os

pub fn difference(before string, after string) ?string {
	mut changes := []string{}

    line_return := match os.user_os() {
        "windows" { "\r\n" }
        else { "\n" }
    }

	lines_before := before.split(line_return)
	lines_after := after.split(line_return)

	lines_from_content_with_most_lines := match lines_before.len == lines_after.len {
		true { lines_before }
		false {
			match lines_before.len > lines_after.len {
				true { lines_before }
				false { lines_after }
			}
		}
	}

	lines_from_content_with_least_lines := match lines_before.len == lines_after.len {
		true { lines_after }
		false { match lines_before.len < lines_after.len {
				true { lines_before }
				false { lines_after }
			}
		}
	}

	sign_for_lines_with_most_lines := match lines_before.len == lines_after.len {
		true { "-" }
		false {
			match lines_before.len > lines_after.len {
				true { "-" }
				false { "+" }
			}
		}
	}

	sign_for_lines_with_least_lines := match lines_before.len == lines_after.len {
		true { "+" }
		false {
			match lines_before.len > lines_after.len {
				true { "+" }
				false { "-" }
			}
		}
	}

    mut no_difference_found := true

    println(lines_from_content_with_most_lines)

	for index, line_from_content_with_most_lines in lines_from_content_with_most_lines {
		line_from_content_with_least_lines := lines_from_content_with_least_lines[index] or {
			""
		}

		if line_from_content_with_most_lines == line_from_content_with_least_lines {
            println("equal: '${line_from_content_with_most_lines}'")
			changes << "  ${line_from_content_with_most_lines}"

			continue
		}

        no_difference_found = false

		if sign_for_lines_with_most_lines == "-" {
			if line_from_content_with_most_lines != "" {
				changes << "${sign_for_lines_with_most_lines} ${line_from_content_with_most_lines}"
			}

			if line_from_content_with_least_lines != "" {
				changes << "${sign_for_lines_with_least_lines} ${line_from_content_with_least_lines}"
			}
		} else {
			if line_from_content_with_least_lines != "" {
				changes << "${sign_for_lines_with_least_lines} ${line_from_content_with_least_lines}"
			}

			if line_from_content_with_most_lines != "" {
				changes << "${sign_for_lines_with_most_lines} ${line_from_content_with_most_lines}"
			}
		}
	}

    if no_difference_found {
        return none
    }

	return changes.join(line_return)
}
