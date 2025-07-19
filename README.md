# difference

String diffing line by line.

```v
module main

import khalyomede.difference { difference }

fn main() {
  println(difference("hello", "world") or { "" })
}
```

```
- hello
+ world
```

## Summary

- [About](#about)
- [Features](#features)
- [Installation](#installation)
- [Examples](#examples)

## About

I created this package to see where why a certain string equality test assertion failed.

This can be useful for any tool performing simple line by line text diffing.

## Features

- Perform line by line diffing on two strings
- Returns a string with - signs (content before) and + signs (content after)

## Installation

- [Using V installer](#using-v-installer)
- [Manual installation](#manual-installation)

### Using V installer

Run this command:

```v
v install khalyomede.difference
```

### Manual installation

1. Go to https://github.com/khalyomede/difference
2. Select the branch or tag of your choice
3. Download the zip
4. Unzip and copy the folder to your `~/.vmodules` folder

You should have the following folder structure

```
.vmodules
└── khalyomede
    └── difference
        ├── difference.v
        ├── README.md
        └── ...
```

## Examples

### Two different strings

```v
module main

import khalyomede.difference { difference }

fn main() {
  println(difference("hello", "world") or { "" })
}
```

```bash
- hello
+ world
```

[back to examples](#examples)

### Two bloc of strings with a single line difference

```v
module main

import khalyomede.difference { difference }

fn main() {
  before := [
    "You have it within you"
    "You are your own limit"
    "Be the change you want to see"
  ].join("\n")

  before := [
    "You have it within you"
    "You are only limited by yourself"
    "Be the change you want to see"
  ].join("\n")

  println(difference(before, after) or { "" })
}
```

```
  You have it within you
- You are your own limit
+ You are only limited by yourself
  Be the change you want to see
```

[back to examples](#examples)

### Two identical strings

In the case no differences were found, the `difference()` function returns an empty string.

```v
module main

import khalyomede.difference { differene }

fn main() {
  assert difference("hello", "hello") or { "" } == ""
}
```

[back to examples](#examples)