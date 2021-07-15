//
//  JGStringDemoTests.swift
//  JGStringDemoTests
//
//  Created by JanyGee on 2021/7/14.
//

import XCTest
import Hamcrest
import JGString

@testable import JGStringDemo

class JGStringDemoTests: XCTestCase {
    
    func testBetween() {
        assertThat("<a>foo</a>".between(left: "<a>", "</a>"), presentAnd(equalTo("foo")))
        assertThat("<a><a>foo</a></a>".between(left: "<a>", "</a>"), presentAnd(equalTo("<a>foo</a>")))
        assertThat("<a>foo".between(left: "<a>", "</a>"), nilValue())
        assertThat("Some strings } are very {weird}, dont you think?".between(left: "{", "}"), presentAnd(equalTo("weird")))
        assertThat("<a></a>".between(left: "<a>", "</a>"), nilValue())
        assertThat("<a>foo</a>".between(left: "<a>", "<a>"), nilValue())
    }
    
    func testCamelize() {
        assertThat("os version".camelize() == "osVersion")
        assertThat("HelloWorld".camelize() == "helloWorld")
        assertThat("someword With Characters".camelize() == "somewordWithCharacters")
        assertThat("data_rate".camelize() == "dataRate")
        assertThat("background-color".camelize() == "backgroundColor")
    }
    
    func testCapitalize() {
        assertThat("hello world".capitalize() == "Hello World")
    }
    
    func testChompLeft() {
        assertThat("foobar".chompLeft(prefix: "foo") == "bar")
        assertThat("foobar".chompLeft(prefix: "bar") == "foo")
    }
    
    func testChompRight() {
        assertThat("foobar".chompRight(suffix: "bar") == "foo")
        assertThat("foobar".chompRight(suffix: "foo") == "bar")
    }
    
    func testClean() {
        assertThat("thisoneistwoathreetest".clean(with: " ", allOf: "one", "two", "three") == "this is a test")
    }
    
    func testCollapseWhitespace() {
        assertThat("  String   \t libraries are   \n\n\t fun\n!  ".collapseWhitespace() == "String libraries are fun !")
    }
    
    func testContains() {
        assertThat("foobar".contains("foo") == true)
        assertThat("foobar".contains("ba") == true)
        assertThat("foobar".contains("something") == false)
    }
    
    func testCount() {
        assertThat("hi hi ho hey hihey".count(substring: "hi") == 3)
    }
    
    func testEndsWith() {
        assertThat("hello world".endsWith(suffix: "world") == true)
        assertThat("hello world".endsWith(suffix: "foo") == false)
    }
    
    func testEnsureLeft() {
        assertThat("/subdir".ensureLeft(prefix: "/") == "/subdir")
        assertThat("subdir".ensureLeft(prefix: "/") == "/subdir")
    }
    
    func testEnsureRight() {
        assertThat("subdir/".ensureRight(suffix: "/") == "subdir/")
        assertThat("subdir".ensureRight(suffix: "/") == "subdir/")
    }
    
    func testIndexOf() {
        assertThat("hello".indexOf(substring: "hell"), presentAnd(equalTo(0)))
        assertThat("hello".indexOf(substring: "lo"), presentAnd(equalTo(3)))
        assertThat("hello".indexOf(substring: "world"), nilValue())
    }
    
    func testInitials() {
        assertThat("First".initials() == "F")
        assertThat("First Last".initials() == "FL")
        assertThat("First Middle1 Middle2 Middle3 Last".initials() == "FMMML")
    }
    
    func testInitialsFirstAndLast() {
        assertThat("First Last".initialsFirstAndLast() == "FL")
        assertThat("First Middle1 Middle2 Middle3 Last".initialsFirstAndLast() == "FL")
    }
    
    func testIsAlpha() {
        assertThat("fdafaf3".isAlpha() == false)
        assertThat("afaf".isAlpha() == true)
        assertThat("dfdf--dfd".isAlpha() == false)
    }
    
    func testIsAlphaNumeric() {
        assertThat("afaf35353afaf".isAlphaNumeric() == true)
        assertThat("FFFF99fff".isAlphaNumeric() == true)
        assertThat("99".isAlphaNumeric() == true)
        assertThat("afff".isAlphaNumeric() == true)
        assertThat("-33".isAlphaNumeric() == false)
        assertThat("aaff..".isAlphaNumeric() == false)
    }
    
    func testIsEmpty() {
        assertThat("".isEmpty() == true)
        assertThat(" ".isEmpty() == true)
        assertThat("\t\t\t ".isEmpty() == true)
        assertThat("\n\n".isEmpty() == true)
        assertThat("helo".isEmpty() == false)
    }
    
    func testIsNumeric() {
        assertThat("abc".isNumeric() == false)
        assertThat("123a".isNumeric() == false)
        assertThat("1".isNumeric() == true)
        assertThat("22".isNumeric() == true)
        assertThat("33.0".isNumeric() == true)
        assertThat("-63.0".isNumeric() == true)
    }
    
    func testJoin() {
        assertThat(",".join(elements: [1,2,3]) == "1,2,3")
        assertThat(",".join(elements: []) == "")
        assertThat(",".join(elements: ["a","b","c"]) == "a,b,c")
        assertThat("! ".join(elements: ["hey","who are you?"]) == "hey! who are you?")
    }
    
    func testLatinize() {
        assertThat("šÜįéïöç".latinize() == "sUieioc")
        assertThat("crème brûlée".latinize() == "creme brulee")
    }
    
    func testLines() {
        assertThat("test".lines() == ["test"])
        assertThat("test\nsentence".lines() == ["test", "sentence"])
        assertThat("test \nsentence".lines() == ["test ", "sentence"])
        //Test Carriage return instead of just newlines
        assertThat("test\rsentence".lines() == ["test", "sentence"])
    }

    func testPad() {
        assertThat("hello".pad(2) == "  hello  ")
        assertThat("hello".pad(1, "\t") == "\thello\t")
    }
    
    func testPadLeft() {
        assertThat("hello".padLeft(10) == "          hello")
        assertThat("what?".padLeft(2, "!") == "!!what?")
    }
    
    func testPadRight() {
        assertThat("hello".padRight(10) == "hello          ")
        assertThat("hello".padRight(2, "!") == "hello!!")
    }
    
    func testStartsWith() {
        assertThat("hello world".startsWith(prefix: "hello") == true)
        assertThat("hello world".startsWith(prefix: "foo") == false)
    }
    
    func testSplit() {
        assertThat("hello world".split(separator: " ")[0] == "hello")
        assertThat("hello world".split(separator: " ")[1] == "world")
        assertThat("helloworld".split(separator: " ")[0] == "helloworld")
    }
    
    func testTimes() {
        assertThat("hi".times(3) == "hihihi")
        assertThat(" ".times(10) == "          ")
    }
    
    func testTrimmedLeft() {
        assertThat("        How are you? ".trimmedLeft() == "How are you? ")
    }
    
    func testTrimmedRight() {
        assertThat(" How are you?   ".trimmedRight() == " How are you?")
    }
    
    func testTrimmed() {
        assertThat("    How are you?   ".trimmed() == "How are you?")
        assertThat(" ".trimmed().count == 0)
        assertThat("  ".trimmed().count == 0)
        assertThat("   ".trimmed().count == 0)
    }
    
    func testToBool() {
        assertThat("asdwads".toBool(), nilValue())
        assertThat("true".toBool(), presentAnd(equalTo(true)))
        assertThat("false".toBool(), presentAnd(equalTo(false)))
    }
    
    func testToFloat() {
        assertThat("asdwads".toFloat(), nilValue())
        assertThat("2.00".toFloat(), presentAnd(equalTo(2.0)))
        assertThat("2".toFloat(), presentAnd(equalTo(2.0)))
    }
    
    func testToInt() {
        assertThat("asdwads".toInt(), nilValue())
        assertThat("2.00".toInt(), presentAnd(equalTo(2)))
        assertThat("2".toInt(), presentAnd(equalTo(2)))
    }
    
    func testToDate() {
        assertThat("asdwads".toDate(), nilValue())
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month,.year], from: "2014-06-03".toDate()!)
        
        assertThat(components.year == 2014)
        assertThat(components.month == 6)
        assertThat(components.day == 3)
    }
    
    func testToDateTime() {
        assertThat("asdwads".toDateTime(), nilValue())
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day , .month , .year, .hour, .minute, .second], from: "2014-06-03 13:15:01".toDateTime()!)
        
        assertThat(components.year == 2014)
        assertThat(components.month == 6)
        assertThat(components.day == 3)
        assertThat(components.hour == 13)
        assertThat(components.minute == 15)
        assertThat(components.second == 1)
    }
    
    func testToDouble() {
        assertThat("asdwads".toDouble(), nilValue())
        assertThat("2.00".toDouble(), presentAnd(equalTo(2.0)))
        assertThat("2".toDouble(), presentAnd(equalTo(2.0)))
    }
    
    func testSlugify() {
        assertThat("Global Thermonuclear Warfare".slugify() == "global-thermonuclear-warfare")
        assertThat("Global Thermonuclear Warfare".slugify(withSeparator: "_") == "global_thermonuclear_warfare")
        assertThat("Crème brûlée".slugify() == "creme-brulee")
    }
    
    func testStripPunctuation() {
        assertThat("My, st[ring] *full* of %punct)".stripPunctuation() == "My string full of punct")
    }
    
    func testSubstring() {
        let subject = "hello world"
        assertThat(subject.substring(startIndex: 0, length: 1) == "h")
        assertThat(subject.substring(startIndex: 0, length: 11) == "hello world")
    }
    
    func testSubscripts() {
        let subject = "hello world"
        
        assertThat(subject[0..<2] == "he")
        assertThat(subject[0..<1] == "h")
        assertThat(subject[0] == "h")
        assertThat(subject[0..<11] == "hello world")
    }
}
