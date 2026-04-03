import XCTest
@testable import JGString

final class JGStringTests: XCTestCase {
    func testBetween() {
        XCTAssertEqual("<a>foo</a>".between(left: "<a>", "</a>"), "foo")
        XCTAssertEqual("<a><a>foo</a></a>".between(left: "<a>", "</a>"), "<a>foo</a>")
        XCTAssertNil("<a>foo".between(left: "<a>", "</a>"))
        XCTAssertEqual("Some strings } are very {weird}, dont you think?".between(left: "{", "}"), "weird")
        XCTAssertNil("<a></a>".between(left: "<a>", "</a>"))
        XCTAssertNil("<a>foo</a>".between(left: "<a>", "<a>"))
        XCTAssertNil("</a><a>foo".between(left: "<a>", "</a>"))
    }

    func testCamelize() {
        XCTAssertEqual("os version".camelize(), "osVersion")
        XCTAssertEqual("HelloWorld".camelize(), "helloWorld")
        XCTAssertEqual("someword With Characters".camelize(), "somewordWithCharacters")
        XCTAssertEqual("data_rate".camelize(), "dataRate")
        XCTAssertEqual("background-color".camelize(), "backgroundColor")
    }

    func testCapitalize() {
        XCTAssertEqual("hello world".capitalize(), "Hello World")
    }

    func testChompLeft() {
        XCTAssertEqual("foobar".chompLeft(prefix: "foo"), "bar")
        XCTAssertEqual("foobar".chompLeft(prefix: "bar"), "foo")
    }

    func testChompRight() {
        XCTAssertEqual("foobar".chompRight(suffix: "bar"), "foo")
        XCTAssertEqual("foobar".chompRight(suffix: "foo"), "bar")
    }

    func testClean() {
        XCTAssertEqual("thisoneistwoathreetest".clean(with: " ", allOf: "one", "two", "three"), "this is a test")
    }

    func testCollapseWhitespace() {
        XCTAssertEqual("  String   \t libraries are   \n\n\t fun\n!  ".collapseWhitespace(), "String libraries are fun !")
    }

    func testContains() {
        XCTAssertTrue("foobar".contains(substring: "foo"))
        XCTAssertTrue("foobar".contains(substring: "ba"))
        XCTAssertFalse("foobar".contains(substring: "something"))
    }

    func testCount() {
        XCTAssertEqual("hi hi ho hey hihey".count(substring: "hi"), 3)
        XCTAssertEqual("hello".count(substring: ""), 0)
    }

    func testDecodeHTML() {
        XCTAssertEqual("The Weekend &#8216;King Of The Fall&#8217;".decodeHTML(), "The Weekend ‘King Of The Fall’")
        XCTAssertEqual("<strong> 4 &lt; 5 &amp; 3 &gt; 2 .</strong> Price: 12 &#x20ac;.  &#64; ".decodeHTML(), "<strong> 4 < 5 & 3 > 2 .</strong> Price: 12 €.  @ ")
        XCTAssertEqual("this is so &quot;good&quot;".decodeHTML(), "this is so \"good\"")
    }

    func testEndsWith() {
        XCTAssertTrue("hello world".endsWith(suffix: "world"))
        XCTAssertFalse("hello world".endsWith(suffix: "foo"))
    }

    func testEnsureLeft() {
        XCTAssertEqual("/subdir".ensureLeft(prefix: "/"), "/subdir")
        XCTAssertEqual("subdir".ensureLeft(prefix: "/"), "/subdir")
    }

    func testEnsureRight() {
        XCTAssertEqual("subdir/".ensureRight(suffix: "/"), "subdir/")
        XCTAssertEqual("subdir".ensureRight(suffix: "/"), "subdir/")
    }

    func testIndexOf() {
        XCTAssertEqual("hello".indexOf(substring: "hell"), 0)
        XCTAssertEqual("hello".indexOf(substring: "lo"), 3)
        XCTAssertNil("hello".indexOf(substring: "world"))
    }

    func testInitials() {
        XCTAssertEqual("First".initials(), "F")
        XCTAssertEqual("First Last".initials(), "FL")
        XCTAssertEqual("First Middle1 Middle2 Middle3 Last".initials(), "FMMML")
        XCTAssertEqual(" First   Last ".initials(), "FL")
    }

    func testInitialsFirstAndLast() {
        XCTAssertEqual("First Last".initialsFirstAndLast(), "FL")
        XCTAssertEqual("First Middle1 Middle2 Middle3 Last".initialsFirstAndLast(), "FL")
    }

    func testIsAlpha() {
        XCTAssertFalse("fdafaf3".isAlpha())
        XCTAssertTrue("afaf".isAlpha())
        XCTAssertFalse("dfdf--dfd".isAlpha())
    }

    func testIsAlphaNumeric() {
        XCTAssertTrue("afaf35353afaf".isAlphaNumeric())
        XCTAssertTrue("FFFF99fff".isAlphaNumeric())
        XCTAssertTrue("99".isAlphaNumeric())
        XCTAssertTrue("afff".isAlphaNumeric())
        XCTAssertFalse("-33".isAlphaNumeric())
        XCTAssertFalse("aaff..".isAlphaNumeric())
        XCTAssertFalse("".isAlphaNumeric())
    }

    func testIsEmpty() {
        XCTAssertTrue("".isEmpty())
        XCTAssertTrue(" ".isEmpty())
        XCTAssertTrue("\t\t\t ".isEmpty())
        XCTAssertTrue("\n\n".isEmpty())
        XCTAssertFalse("helo".isEmpty())
    }

    func testIsNumeric() {
        XCTAssertFalse("abc".isNumeric())
        XCTAssertFalse("123a".isNumeric())
        XCTAssertTrue("1".isNumeric())
        XCTAssertTrue("22".isNumeric())
        XCTAssertTrue("33.0".isNumeric())
        XCTAssertTrue("-63.0".isNumeric())
    }

    func testJoin() {
        XCTAssertEqual(",".join(elements: [1, 2, 3]), "1,2,3")
        XCTAssertEqual(",".join(elements: [Int]()), "")
        XCTAssertEqual(",".join(elements: ["a", "b", "c"]), "a,b,c")
        XCTAssertEqual("! ".join(elements: ["hey", "who are you?"]), "hey! who are you?")
    }

    func testLatinize() {
        XCTAssertEqual("šÜįéïöç".latinize(), "sUieioc")
        XCTAssertEqual("crème brûlée".latinize(), "creme brulee")
    }

    func testLines() {
        XCTAssertEqual("test".lines(), ["test"])
        XCTAssertEqual("test\nsentence".lines(), ["test", "sentence"])
        XCTAssertEqual("test \nsentence".lines(), ["test ", "sentence"])
        XCTAssertEqual("test\rsentence".lines(), ["test", "sentence"])
    }

    func testPad() {
        XCTAssertEqual("hello".pad(2), "  hello  ")
        XCTAssertEqual("hello".pad(1, "\t"), "\thello\t")
    }

    func testPadLeft() {
        XCTAssertEqual("hello".padLeft(10), "          hello")
        XCTAssertEqual("what?".padLeft(2, "!"), "!!what?")
    }

    func testPadRight() {
        XCTAssertEqual("hello".padRight(10), "hello          ")
        XCTAssertEqual("hello".padRight(2, "!"), "hello!!")
    }

    func testSlugify() {
        XCTAssertEqual("Global Thermonuclear Warfare".slugify(), "global-thermonuclear-warfare")
        XCTAssertEqual("Global Thermonuclear Warfare".slugify(withSeparator: "_"), "global_thermonuclear_warfare")
        XCTAssertEqual("Crème brûlée".slugify(), "creme-brulee")
    }

    func testSplit() {
        XCTAssertEqual("hello world".split(separator: " ")[0], "hello")
        XCTAssertEqual("hello world".split(separator: " ")[1], "world")
        XCTAssertEqual("helloworld".split(separator: " ")[0], "helloworld")
    }

    func testStartsWith() {
        XCTAssertTrue("hello world".startsWith(prefix: "hello"))
        XCTAssertFalse("hello world".startsWith(prefix: "foo"))
    }

    func testStripPunctuation() {
        XCTAssertEqual("My, st[ring] *full* of %punct)".stripPunctuation(), "My string full of punct")
    }

    func testSubstring() {
        let subject = "hello world"
        XCTAssertEqual(subject.substring(startIndex: 0, length: 1), "h")
        XCTAssertEqual(subject.substring(startIndex: 0, length: 11), "hello world")
        XCTAssertEqual(subject.substring(startIndex: 6, length: 5), "world")
    }

    func testSubscripts() {
        let subject = "hello world"

        XCTAssertEqual(subject[0..<2], "he")
        XCTAssertEqual(subject[0..<1], "h")
        XCTAssertEqual(subject[2..<5], "llo")
        XCTAssertEqual(subject[0], "h")
        XCTAssertEqual(subject[6], "w")
        XCTAssertEqual(subject[0..<11], "hello world")
    }

    func testTimes() {
        XCTAssertEqual("hi".times(3), "hihihi")
        XCTAssertEqual(" ".times(10), "          ")
        XCTAssertEqual("hello".times(0), "")
    }

    func testTrimmedLeft() {
        XCTAssertEqual("        How are you? ".trimmedLeft(), "How are you? ")
        XCTAssertEqual("   ".trimmedLeft(), "")
    }

    func testTrimmedRight() {
        XCTAssertEqual(" How are you?   ".trimmedRight(), " How are you?")
        XCTAssertEqual("   ".trimmedRight(), "")
    }

    func testTrimmed() {
        XCTAssertEqual("    How are you?   ".trimmed(), "How are you?")
        XCTAssertEqual(" ".trimmed().count, 0)
        XCTAssertEqual("  ".trimmed().count, 0)
        XCTAssertEqual("   ".trimmed().count, 0)
    }

    func testToBool() {
        XCTAssertNil("asdwads".toBool())
        XCTAssertEqual("true".toBool(), true)
        XCTAssertEqual("false".toBool(), false)
    }

    func testToFloat() {
        XCTAssertNil("asdwads".toFloat())
        XCTAssertEqual("2.00".toFloat(), 2.0)
        XCTAssertEqual("2".toFloat(), 2.0)
    }

    func testToInt() {
        XCTAssertNil("asdwads".toInt())
        XCTAssertEqual("2.00".toInt(), 2)
        XCTAssertEqual("2".toInt(), 2)
    }

    func testToDate() throws {
        XCTAssertNil("asdwads".toDate())

        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: try XCTUnwrap("2014-06-03".toDate()))

        XCTAssertEqual(components.year, 2014)
        XCTAssertEqual(components.month, 6)
        XCTAssertEqual(components.day, 3)
    }

    func testToDateTime() throws {
        XCTAssertNil("asdwads".toDateTime())

        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: try XCTUnwrap("2014-06-03 13:15:01".toDateTime()))

        XCTAssertEqual(components.year, 2014)
        XCTAssertEqual(components.month, 6)
        XCTAssertEqual(components.day, 3)
        XCTAssertEqual(components.hour, 13)
        XCTAssertEqual(components.minute, 15)
        XCTAssertEqual(components.second, 1)
    }

    func testToDouble() {
        XCTAssertNil("asdwads".toDouble())
        XCTAssertEqual("2.00".toDouble(), 2.0)
        XCTAssertEqual("2".toDouble(), 2.0)
    }
}
