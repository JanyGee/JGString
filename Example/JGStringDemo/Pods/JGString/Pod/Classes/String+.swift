//
//  String+.swift
//  JGString
//
//  Created by JanyGee on 2021/7/6.
//

import Foundation
public extension String {

    ///  Finds the string between two bookend strings if it can be found.
    ///
    ///  - parameter left:  The left bookend
    ///  - parameter right: The right bookend
    ///
    ///  - returns: The string between the two bookends, or nil if the bookends cannot be found, the bookends are the same or appear contiguously.
    func between(left: String, _ right: String) -> String? {
        
        guard
            let leftRange = range(of:left), let rightRange = range(of: right, options: .backwards, range: nil, locale: nil), left != right && self[leftRange].endIndex != self[rightRange].startIndex
            else { return nil }

        return String(self[self[leftRange].endIndex..<self[rightRange].startIndex])

    }
    
    func camelize() -> String {
        let source = clean(with: " ", allOf: "-", "_")
        if source.contains(" ") {
            let first = source.prefix(1)
            let cammel = NSString(format: "%@", (source as NSString).capitalized.replacingOccurrences(of: " ", with: "")) as String
            let rest = String(cammel.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = (source as NSString).lowercased.prefix(1)
            let rest = String(source.dropFirst())
            return "\(first)\(rest)"
        }
    }
    
    func capitalize() -> String {
        return capitalized
    }
    
    func contains(substring: String) -> Bool {
        return range(of: substring) != nil
    }
    
    func chompLeft(prefix: String) -> String {
        if let prefixRange = range(of: prefix) {
            if self[prefixRange].endIndex >= endIndex {
                return String(self[startIndex..<self[prefixRange].startIndex])
            } else {
                return String(self[self[prefixRange].endIndex..<endIndex])
            }
        }
        return self
    }
    
    func chompRight(suffix: String) -> String {
        
        if let suffixRange = range(of: suffix, options: .backwards, range: nil, locale: nil) {
            if self[suffixRange].endIndex >= endIndex {
                return String(self[startIndex..<self[suffixRange].startIndex])
            } else {
                return String(self[self[suffixRange].endIndex..<endIndex])
            }
        }
        return self
    }
    
    func collapseWhitespace() -> String {
        let components = components(separatedBy: NSCharacterSet.whitespacesAndNewlines).filter { !$0.isEmpty }
        return components.joined(separator: " ")
    }
    
    func clean(with: String, allOf: String...) -> String {
        var string = self
        for target in allOf {
            string = string.replacingOccurrences(of: target, with: with)
        }
        return string
    }
    
    func count(substring: String) -> Int {
        return components(separatedBy: substring).count - 1
    }
    
    func endsWith(suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    func ensureLeft(prefix: String) -> String {
        if startsWith(prefix: prefix) {
            return self
        } else {
            return "\(prefix)\(self)"
        }
    }
    
    func ensureRight(suffix: String) -> String {
        if endsWith(suffix: suffix) {
            return self
        } else {
            return "\(self)\(suffix)"
        }
    }
    
    func indexOf(substring: String) -> Int? {
        if let range = range(of: substring) {
            return distance(from: startIndex, to: self[range].startIndex)
        }
        return nil
    }
    
    func initials() -> String {
        let words = components(separatedBy: " ")
        return words.reduce(""){$0 + $1.prefix(1)}
    }
    
    func initialsFirstAndLast() -> String {
        let words = components(separatedBy: " ")
        return words.reduce("") { String(($0 == "" ? "" : $0.prefix(1)) + $1.prefix(1))}
        //return words.reduce("") { ($0 == "" ? "" : $0[0...0]) + $1[0...0]}
    }
    
    func isAlpha() -> Bool {
        for chr in self {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    func isAlphaNumeric() -> Bool {
        let alphaNumeric = NSCharacterSet.alphanumerics
        return components(separatedBy: alphaNumeric).joined(separator: "").length == 0
    }
    
    func isEmpty() -> Bool {
        return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).length == 0
    }
    
    func isNumeric() -> Bool {
        if let _ = defaultNumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    
    func getSum(sumFunction:(Int, Int) -> (Int)) -> (Int){
        return sumFunction(3,5)
    }
    
    func join<S: Sequence>(elements: S) -> String {
        return elements.map { (ele) -> String in
            return (ele as? String) ?? ""
        }.joined(separator: self)
    }
    
    func latinize() -> String {
        return folding(options: .caseInsensitive, locale: Locale.current)
    }
    
    func lines() -> [String] {
        return components(separatedBy: NSCharacterSet.newlines)
    }
    
    var length: Int {
        get {
            return self.count
        }
    }
    
    func stimes(_ n: Int) -> String {
        return String(repeating: self, count: n)
    }
    
    func pad(_ n: Int, _ string: String = " ") -> String {
        return "".join(elements: [string.times(n), self, string.times(n)])
    }
    
    func padLeft(_ n: Int, _ string: String = " ") -> String {
        return "".join(elements: [string.times(n), self])
    }
    
    func padRight(_ n: Int, _ string: String = " ") -> String {
        return "".join(elements: [self, string.times(n)])
    }
    
    func slugify(withSeparator separator: Character = "-") -> String {
        let slugCharacterSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\(separator)")
        return latinize()
            .lowercased()
            .components(separatedBy: slugCharacterSet.inverted)
            .filter { $0 != "" }
            .joined(separator: String(separator))
    }
    
    func split(separator: Character) -> [String] {
        return split{$0 == separator}.map(String.init)
    }
    
    func startsWith(prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    
    func stripPunctuation() -> String {
        return components(separatedBy: .punctuationCharacters).joined(separator: "").components(separatedBy: " ").filter { element in
            return element != ""
        }.joined(separator: " ")
    }
    
    func times(_ n: Int) -> String {
        return (0..<n).reduce(""){r,_ in
            return r + self
        }
    }
    
    func toFloat() -> Float? {
        if let number = defaultNumberFormatter().number(from: self) {
            return number.floatValue
        }
        return nil
    }
    
    func toInt() -> Int? {
        if let number = defaultNumberFormatter().number(from: self) {
            return number.intValue
        }
        return nil
    }
    
    func toDouble(locale: Locale = NSLocale.system) -> Double? {
        let nf = localeNumberFormatter(locale: locale)
        if let number = nf.number(from: self) {
            return number.doubleValue
        }
        return nil
    }
    
    func toBool() -> Bool? {
        let trimmed = self.trimmed().lowercased()
        if trimmed == "true" || trimmed == "false" {
            return (trimmed as NSString).boolValue
        }
        return nil
    }
    
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        return dateFormatter(format: format).date(from: self)
    }
    
    func toDateTime(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        return toDate(format: format)
    }
    
    func trimmedLeft() -> String {
        
        if let range = rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines.inverted) {
            return String(self[self[range].startIndex..<endIndex])
        }
        return self
    }
    
    func trimmedRight() -> String {
        if let range = rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines.inverted, options: .backwards, range: nil) {
            return String(self[startIndex..<self[range].endIndex])
        }
        return self
    }
    
    func trimmed() -> String {
        return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.startIndex)
            let endIndex = self.index(self.startIndex, offsetBy: r.endIndex - r.startIndex)
            return String(self[startIndex..<endIndex])
        }
    }
    
    func substring(startIndex: Int, length: Int) -> String {
        let start = index(self.startIndex, offsetBy: startIndex)
        let end = index(self.startIndex, offsetBy: startIndex + length)
        return String(self[start..<end])
    }
    
    subscript(i: Int) -> Character {
        get {
            let index = index(startIndex, offsetBy: i)
            return self[index]
        }
    }
    
    //MARK:HTML
    private struct HTMLEntities {
        static let characterEntities : [String: Character] = [
            
            // XML predefined entities:
            "&quot;"     : "\"",
            "&amp;"      : "&",
            "&apos;"     : "'",
            "&lt;"       : "<",
            "&gt;"       : ">",
            
            // HTML character entity references:
            "&nbsp;"     : "\u{00A0}",
            "&iexcl;"    : "\u{00A1}",
            "&cent;"     : "\u{00A2}",
            "&pound;"    : "\u{00A3}",
            "&curren;"   : "\u{00A4}",
            "&yen;"      : "\u{00A5}",
            "&brvbar;"   : "\u{00A6}",
            "&sect;"     : "\u{00A7}",
            "&uml;"      : "\u{00A8}",
            "&copy;"     : "\u{00A9}",
            "&ordf;"     : "\u{00AA}",
            "&laquo;"    : "\u{00AB}",
            "&not;"      : "\u{00AC}",
            "&shy;"      : "\u{00AD}",
            "&reg;"      : "\u{00AE}",
            "&macr;"     : "\u{00AF}",
            "&deg;"      : "\u{00B0}",
            "&plusmn;"   : "\u{00B1}",
            "&sup2;"     : "\u{00B2}",
            "&sup3;"     : "\u{00B3}",
            "&acute;"    : "\u{00B4}",
            "&micro;"    : "\u{00B5}",
            "&para;"     : "\u{00B6}",
            "&middot;"   : "\u{00B7}",
            "&cedil;"    : "\u{00B8}",
            "&sup1;"     : "\u{00B9}",
            "&ordm;"     : "\u{00BA}",
            "&raquo;"    : "\u{00BB}",
            "&frac14;"   : "\u{00BC}",
            "&frac12;"   : "\u{00BD}",
            "&frac34;"   : "\u{00BE}",
            "&iquest;"   : "\u{00BF}",
            "&Agrave;"   : "\u{00C0}",
            "&Aacute;"   : "\u{00C1}",
            "&Acirc;"    : "\u{00C2}",
            "&Atilde;"   : "\u{00C3}",
            "&Auml;"     : "\u{00C4}",
            "&Aring;"    : "\u{00C5}",
            "&AElig;"    : "\u{00C6}",
            "&Ccedil;"   : "\u{00C7}",
            "&Egrave;"   : "\u{00C8}",
            "&Eacute;"   : "\u{00C9}",
            "&Ecirc;"    : "\u{00CA}",
            "&Euml;"     : "\u{00CB}",
            "&Igrave;"   : "\u{00CC}",
            "&Iacute;"   : "\u{00CD}",
            "&Icirc;"    : "\u{00CE}",
            "&Iuml;"     : "\u{00CF}",
            "&ETH;"      : "\u{00D0}",
            "&Ntilde;"   : "\u{00D1}",
            "&Ograve;"   : "\u{00D2}",
            "&Oacute;"   : "\u{00D3}",
            "&Ocirc;"    : "\u{00D4}",
            "&Otilde;"   : "\u{00D5}",
            "&Ouml;"     : "\u{00D6}",
            "&times;"    : "\u{00D7}",
            "&Oslash;"   : "\u{00D8}",
            "&Ugrave;"   : "\u{00D9}",
            "&Uacute;"   : "\u{00DA}",
            "&Ucirc;"    : "\u{00DB}",
            "&Uuml;"     : "\u{00DC}",
            "&Yacute;"   : "\u{00DD}",
            "&THORN;"    : "\u{00DE}",
            "&szlig;"    : "\u{00DF}",
            "&agrave;"   : "\u{00E0}",
            "&aacute;"   : "\u{00E1}",
            "&acirc;"    : "\u{00E2}",
            "&atilde;"   : "\u{00E3}",
            "&auml;"     : "\u{00E4}",
            "&aring;"    : "\u{00E5}",
            "&aelig;"    : "\u{00E6}",
            "&ccedil;"   : "\u{00E7}",
            "&egrave;"   : "\u{00E8}",
            "&eacute;"   : "\u{00E9}",
            "&ecirc;"    : "\u{00EA}",
            "&euml;"     : "\u{00EB}",
            "&igrave;"   : "\u{00EC}",
            "&iacute;"   : "\u{00ED}",
            "&icirc;"    : "\u{00EE}",
            "&iuml;"     : "\u{00EF}",
            "&eth;"      : "\u{00F0}",
            "&ntilde;"   : "\u{00F1}",
            "&ograve;"   : "\u{00F2}",
            "&oacute;"   : "\u{00F3}",
            "&ocirc;"    : "\u{00F4}",
            "&otilde;"   : "\u{00F5}",
            "&ouml;"     : "\u{00F6}",
            "&divide;"   : "\u{00F7}",
            "&oslash;"   : "\u{00F8}",
            "&ugrave;"   : "\u{00F9}",
            "&uacute;"   : "\u{00FA}",
            "&ucirc;"    : "\u{00FB}",
            "&uuml;"     : "\u{00FC}",
            "&yacute;"   : "\u{00FD}",
            "&thorn;"    : "\u{00FE}",
            "&yuml;"     : "\u{00FF}",
            "&OElig;"    : "\u{0152}",
            "&oelig;"    : "\u{0153}",
            "&Scaron;"   : "\u{0160}",
            "&scaron;"   : "\u{0161}",
            "&Yuml;"     : "\u{0178}",
            "&fnof;"     : "\u{0192}",
            "&circ;"     : "\u{02C6}",
            "&tilde;"    : "\u{02DC}",
            "&Alpha;"    : "\u{0391}",
            "&Beta;"     : "\u{0392}",
            "&Gamma;"    : "\u{0393}",
            "&Delta;"    : "\u{0394}",
            "&Epsilon;"  : "\u{0395}",
            "&Zeta;"     : "\u{0396}",
            "&Eta;"      : "\u{0397}",
            "&Theta;"    : "\u{0398}",
            "&Iota;"     : "\u{0399}",
            "&Kappa;"    : "\u{039A}",
            "&Lambda;"   : "\u{039B}",
            "&Mu;"       : "\u{039C}",
            "&Nu;"       : "\u{039D}",
            "&Xi;"       : "\u{039E}",
            "&Omicron;"  : "\u{039F}",
            "&Pi;"       : "\u{03A0}",
            "&Rho;"      : "\u{03A1}",
            "&Sigma;"    : "\u{03A3}",
            "&Tau;"      : "\u{03A4}",
            "&Upsilon;"  : "\u{03A5}",
            "&Phi;"      : "\u{03A6}",
            "&Chi;"      : "\u{03A7}",
            "&Psi;"      : "\u{03A8}",
            "&Omega;"    : "\u{03A9}",
            "&alpha;"    : "\u{03B1}",
            "&beta;"     : "\u{03B2}",
            "&gamma;"    : "\u{03B3}",
            "&delta;"    : "\u{03B4}",
            "&epsilon;"  : "\u{03B5}",
            "&zeta;"     : "\u{03B6}",
            "&eta;"      : "\u{03B7}",
            "&theta;"    : "\u{03B8}",
            "&iota;"     : "\u{03B9}",
            "&kappa;"    : "\u{03BA}",
            "&lambda;"   : "\u{03BB}",
            "&mu;"       : "\u{03BC}",
            "&nu;"       : "\u{03BD}",
            "&xi;"       : "\u{03BE}",
            "&omicron;"  : "\u{03BF}",
            "&pi;"       : "\u{03C0}",
            "&rho;"      : "\u{03C1}",
            "&sigmaf;"   : "\u{03C2}",
            "&sigma;"    : "\u{03C3}",
            "&tau;"      : "\u{03C4}",
            "&upsilon;"  : "\u{03C5}",
            "&phi;"      : "\u{03C6}",
            "&chi;"      : "\u{03C7}",
            "&psi;"      : "\u{03C8}",
            "&omega;"    : "\u{03C9}",
            "&thetasym;" : "\u{03D1}",
            "&upsih;"    : "\u{03D2}",
            "&piv;"      : "\u{03D6}",
            "&ensp;"     : "\u{2002}",
            "&emsp;"     : "\u{2003}",
            "&thinsp;"   : "\u{2009}",
            "&zwnj;"     : "\u{200C}",
            "&zwj;"      : "\u{200D}",
            "&lrm;"      : "\u{200E}",
            "&rlm;"      : "\u{200F}",
            "&ndash;"    : "\u{2013}",
            "&mdash;"    : "\u{2014}",
            "&lsquo;"    : "\u{2018}",
            "&rsquo;"    : "\u{2019}",
            "&sbquo;"    : "\u{201A}",
            "&ldquo;"    : "\u{201C}",
            "&rdquo;"    : "\u{201D}",
            "&bdquo;"    : "\u{201E}",
            "&dagger;"   : "\u{2020}",
            "&Dagger;"   : "\u{2021}",
            "&bull;"     : "\u{2022}",
            "&hellip;"   : "\u{2026}",
            "&permil;"   : "\u{2030}",
            "&prime;"    : "\u{2032}",
            "&Prime;"    : "\u{2033}",
            "&lsaquo;"   : "\u{2039}",
            "&rsaquo;"   : "\u{203A}",
            "&oline;"    : "\u{203E}",
            "&frasl;"    : "\u{2044}",
            "&euro;"     : "\u{20AC}",
            "&image;"    : "\u{2111}",
            "&weierp;"   : "\u{2118}",
            "&real;"     : "\u{211C}",
            "&trade;"    : "\u{2122}",
            "&alefsym;"  : "\u{2135}",
            "&larr;"     : "\u{2190}",
            "&uarr;"     : "\u{2191}",
            "&rarr;"     : "\u{2192}",
            "&darr;"     : "\u{2193}",
            "&harr;"     : "\u{2194}",
            "&crarr;"    : "\u{21B5}",
            "&lArr;"     : "\u{21D0}",
            "&uArr;"     : "\u{21D1}",
            "&rArr;"     : "\u{21D2}",
            "&dArr;"     : "\u{21D3}",
            "&hArr;"     : "\u{21D4}",
            "&forall;"   : "\u{2200}",
            "&part;"     : "\u{2202}",
            "&exist;"    : "\u{2203}",
            "&empty;"    : "\u{2205}",
            "&nabla;"    : "\u{2207}",
            "&isin;"     : "\u{2208}",
            "&notin;"    : "\u{2209}",
            "&ni;"       : "\u{220B}",
            "&prod;"     : "\u{220F}",
            "&sum;"      : "\u{2211}",
            "&minus;"    : "\u{2212}",
            "&lowast;"   : "\u{2217}",
            "&radic;"    : "\u{221A}",
            "&prop;"     : "\u{221D}",
            "&infin;"    : "\u{221E}",
            "&ang;"      : "\u{2220}",
            "&and;"      : "\u{2227}",
            "&or;"       : "\u{2228}",
            "&cap;"      : "\u{2229}",
            "&cup;"      : "\u{222A}",
            "&int;"      : "\u{222B}",
            "&there4;"   : "\u{2234}",
            "&sim;"      : "\u{223C}",
            "&cong;"     : "\u{2245}",
            "&asymp;"    : "\u{2248}",
            "&ne;"       : "\u{2260}",
            "&equiv;"    : "\u{2261}",
            "&le;"       : "\u{2264}",
            "&ge;"       : "\u{2265}",
            "&sub;"      : "\u{2282}",
            "&sup;"      : "\u{2283}",
            "&nsub;"     : "\u{2284}",
            "&sube;"     : "\u{2286}",
            "&supe;"     : "\u{2287}",
            "&oplus;"    : "\u{2295}",
            "&otimes;"   : "\u{2297}",
            "&perp;"     : "\u{22A5}",
            "&sdot;"     : "\u{22C5}",
            "&lceil;"    : "\u{2308}",
            "&rceil;"    : "\u{2309}",
            "&lfloor;"   : "\u{230A}",
            "&rfloor;"   : "\u{230B}",
            "&lang;"     : "\u{2329}",
            "&rang;"     : "\u{232A}",
            "&loz;"      : "\u{25CA}",
            "&spades;"   : "\u{2660}",
            "&clubs;"    : "\u{2663}",
            "&hearts;"   : "\u{2665}",
            "&diams;"    : "\u{2666}",
        ]
    }
    
    // Convert the number in the string to the corresponding
    // Unicode character, e.g.
    //    decodeNumeric("64", 10)   --> "@"
    //    decodeNumeric("20ac", 16) --> "€"
    private func decodeNumeric(string : String, base : Int32) -> Character? {
        let code = UInt32(strtoul(string, nil, base))
        return Character(UnicodeScalar(code)!)
    }
    
    // Decode the HTML character entity to the corresponding
    // Unicode character, return `nil` for invalid input.
    //     decode("&#64;")    --> "@"
    //     decode("&#x20ac;") --> "€"
    //     decode("&lt;")     --> "<"
    //     decode("&foo;")    --> nil
    private func decode(entity : String) -> Character? {
        if entity.hasPrefix("&#x") || entity.hasPrefix("&#X"){
            return decodeNumeric(string: entity.substring(startIndex: 0, length: 3), base: 16)
        } else if entity.hasPrefix("&#") {
            return decodeNumeric(string: entity.substring(startIndex: 0, length: 2), base: 10)
        } else {
            return HTMLEntities.characterEntities[entity]
        }
    }
    
    
    /// Returns a new string made by replacing in the `String`
    /// all HTML character entity references with the corresponding
    /// character.
    func decodeHTML() -> String {
        var result = ""
        var position = startIndex
        
        // Find the next '&' and copy the characters preceding it to `result`:
        
        while let ampRange = range(of: "&", range: position ..< endIndex) {
            result.append(contentsOf: self[position ..< self[ampRange].startIndex])
            position = self[ampRange].startIndex
            
            // Find the next ';' and copy everything from '&' to ';' into `entity`
            if let semiRange = range(of: ";", range: position ..< endIndex) {
                let entity = self[position ..< self[semiRange].endIndex]
                position = self[semiRange].endIndex
                
                if let decoded = decode(entity: String(entity)) {
                    // Replace by decoded character:
                    result.append(decoded)
                } else {
                    // Invalid entity, copy verbatim:
                    result.append(contentsOf: entity)
                }
            } else {
                // No matching ';'.
                break
            }
        }
        // Copy remaining characters to `result`:
        result.append(contentsOf: self[position ..< endIndex])
        return result
    }
    //MARK:HTML
}

private enum ThreadLocalIdentifier {
    case DateFormatter(String)

    case DefaultNumberFormatter
    case LocaleNumberFormatter(Locale)

    var objcDictKey: String {
        switch self {
        case .DateFormatter(let format):
            return "SS\(self)\(format)"
        case .LocaleNumberFormatter(let l):
            return "SS\(self)\(l.identifier)"
        default:
            return "SS\(self)"
        }
    }
}

private func threadLocalInstance<T: AnyObject>(identifier: ThreadLocalIdentifier, initialValue: @autoclosure () -> T) -> T {
    let storage = Thread.current.threadDictionary
    let k = identifier.objcDictKey

    let instance: T = storage[k] as? T ?? initialValue()
    if storage[k] == nil {
        storage[k] = instance
    }

    return instance
}

private func dateFormatter(format: String) -> DateFormatter {
    return threadLocalInstance(identifier: .DateFormatter(format), initialValue: {
        let df = DateFormatter()
        df.dateFormat = format
        return df
    }())
}

private func defaultNumberFormatter() -> NumberFormatter {
    return threadLocalInstance(identifier: .DefaultNumberFormatter, initialValue: NumberFormatter())
}

private func localeNumberFormatter(locale: Locale) -> NumberFormatter {
    return threadLocalInstance(identifier: .LocaleNumberFormatter(locale), initialValue: {
        let nf = NumberFormatter()
        nf.locale = locale
        return nf
    }())
}
