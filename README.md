# JGString

JGString is a lightweight set of `String` helpers for Swift. This repository now includes:

- Swift Package Manager support
- XCTest coverage for the public extension methods
- modern CI through GitHub Actions

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

## Usage

```swift
import JGString

"<a>foo</a>".between(left: "<a>", "</a>")    // "foo"
"background-color".camelize()               // "backgroundColor"
"Crème brûlée".slugify()                    // "creme-brulee"
", ".join(elements: [1, 2, 3])              // "1, 2, 3"
"  hello   world  ".collapseWhitespace()    // "hello world"
"The Weekend &#8216;King&#8217;".decodeHTML() // "The Weekend ‘King’"
```

## Available Helpers

The extension includes helpers for:

- extracting content, searching, and prefix/suffix handling
- casing, slug generation, whitespace cleanup, and punctuation stripping
- initials, line splitting, padding, and repeated strings
- numeric, boolean, and date conversion
- HTML entity decoding

The most accurate behavioral reference is the test suite in `Tests/JGStringTests/JGStringTests.swift`.

## Development

Run the package tests with:

```bash
swift test
```
"2.00".toDouble() // 2.0
"2".toDouble() // 2.0
```

**trimmedLeft()**
```swift
"        How are you? ".trimmedLeft() // "How are you? "
```

**trimmedRight()**
```swift
" How are you?   ".trimmedRight() // " How are you?"
```

**trimmed()**
```swift
"    How are you?   ".trimmed() // "How are you?"
```

**slugify()**
```swift
"Global Thermonuclear Warfare".slugify() // "global-thermonuclear-warfare"
"Crème brûlée".slugify() // "creme-brulee"
```

**stripPunctuation()**
```swift
"My, st[ring] *full* of %punct)".stripPunctuation() // "My string full of punct"
```

**substring(startIndex, length)**
```swift
"hello world".substring(startIndex: 0, length: 1) // "h"
"hello world".substring(startIndex: 0, length: 11) // "hello world"
```

**[subscript]**
```swift
""hello world"[0..<2] == "he"" // "he"
""hello world"[0..<1] == "h"" // "h"
""hello world"[0] == "h""
""hello world"[0..<11] == "hello world"" // "hello world"
```

## Author

Jany Gee, 1321899953@qq.com

## License

JGString is available under the MIT license. See the LICENSE file for more info.
