# JGString

[![Swift](https://img.shields.io/badge/Swift-5.9%2B-orange.svg)](https://swift.org)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/JGString.svg)](https://cocoapods.org/pods/JGString)
[![CocoaPods Platforms](https://img.shields.io/cocoapods/p/JGString.svg)](https://cocoapods.org/pods/JGString)
[![License](https://img.shields.io/cocoapods/l/JGString.svg)](LICENSE)
[![Build](https://github.com/JanyGee/JGString/actions/workflows/swift.yml/badge.svg)](https://github.com/JanyGee/JGString/actions/workflows/swift.yml)

JGString is a Swift string utilities library for common text transformations and parsing tasks on iOS. It adds lightweight `String` helpers for `slugify`, `camelize`, trimming whitespace, extracting initials, decoding HTML entities, and converting text into numbers, booleans, and dates.

If you are looking for a Swift string extension library for CocoaPods or Swift Package Manager, JGString focuses on practical helpers that remove repetitive Foundation boilerplate.

## Features

- String formatting helpers: `camelize`, `capitalize`, `slugify`, `clean`, `collapseWhitespace`
- Prefix and suffix utilities: `startsWith`, `endsWith`, `ensureLeft`, `ensureRight`, `chompLeft`, `chompRight`
- Text extraction helpers: `between`, `indexOf`, `substring`, integer subscripts
- Content cleanup: `trimmed`, `trimmedLeft`, `trimmedRight`, `stripPunctuation`, `latinize`
- Convenience parsing: `toBool`, `toInt`, `toFloat`, `toDouble`, `toDate`, `toDateTime`
- Collection-style helpers: `split`, `lines`, `join`, `times`, `pad`, `padLeft`, `padRight`
- HTML decoding: `decodeHTML`

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/JanyGee/JGString.git", from: "1.0.2")
]
```

Then add `"JGString"` to your target dependencies.

### CocoaPods

```ruby
pod "JGString"
```

## Quick Examples

```swift
import JGString

"background-color".camelize()
// "backgroundColor"

"Crème brûlée".slugify()
// "creme-brulee"

"  hello   world  ".collapseWhitespace()
// "hello world"

"The Weekend &#8216;King&#8217;".decodeHTML()
// "The Weekend ‘King’"

"/api".ensureLeft(prefix: "/")
// "/api"

"2014-06-03 13:15:01".toDateTime()
// Date
```

## Common Use Cases

### Swift string formatting

```swift
"os version".camelize()
// "osVersion"

"Global Thermonuclear Warfare".slugify()
// "global-thermonuclear-warfare"

"  String   libraries are \n fun ".collapseWhitespace()
// "String libraries are fun"
```

### Prefix, suffix, and extraction helpers

```swift
"<a>foo</a>".between(left: "<a>", "</a>")
// "foo"

"subdir".ensureRight(suffix: "/")
// "subdir/"

"foobar".chompLeft(prefix: "foo")
// "bar"
```

### Parsing text into values

```swift
"true".toBool()
// true

"2.00".toDouble()
// 2.0

"2014-06-03".toDate()
// Date
```

### Initials and cleanup helpers

```swift
"First Middle Last".initials()
// "FML"

"First Middle Last".initialsFirstAndLast()
// "FL"

"My, st[ring] *full* of %punct)".stripPunctuation()
// "My string full of punct"
```

## API Overview

### Formatting and cleanup

- `camelize()`
- `capitalize()`
- `clean(with:allOf:)`
- `collapseWhitespace()`
- `latinize()`
- `slugify(withSeparator:)`
- `stripPunctuation()`
- `trimmed()`
- `trimmedLeft()`
- `trimmedRight()`

### Search and extraction

- `between(left:_:)`
- `contains(substring:)`
- `count(substring:)`
- `indexOf(substring:)`
- `substring(startIndex:length:)`
- `split(separator:)`
- integer subscripts

### Prefix and suffix helpers

- `chompLeft(prefix:)`
- `chompRight(suffix:)`
- `ensureLeft(prefix:)`
- `ensureRight(suffix:)`
- `startsWith(prefix:)`
- `endsWith(suffix:)`

### Conversion and parsing

- `decodeHTML()`
- `isAlpha()`
- `isAlphaNumeric()`
- `isEmpty()`
- `isNumeric()`
- `toBool()`
- `toInt()`
- `toFloat()`
- `toDouble(locale:)`
- `toDate(format:)`
- `toDateTime(format:)`

### Convenience helpers

- `initials()`
- `initialsFirstAndLast()`
- `join(elements:)`
- `lines()`
- `pad(_:_)`
- `padLeft(_:_)`
- `padRight(_:_)`
- `times(_:)`

## Why This Release Matters

Recent maintenance work improved both reliability and adoption readiness:

- fixed edge-case bugs in range handling, decoding, trimming, and joining
- added Swift Package Manager support
- added XCTest coverage for public helpers
- modernized CI with GitHub Actions
- refreshed CocoaPods metadata and documentation

## Development

Run tests locally with:

```bash
swift test
```

The test suite lives in [`Tests/JGStringTests/JGStringTests.swift`](Tests/JGStringTests/JGStringTests.swift).

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for release history and upgrade notes.

## License

JGString is available under the MIT license. See [LICENSE](LICENSE).
