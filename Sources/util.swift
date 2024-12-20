// credit: https://github.com/codr7/aoc24/blob/main/swift/Sources/aoc/util.swift
import Foundation

struct XY: Hashable, CustomStringConvertible {
    let x: Int
    let y: Int
    var description: String {"\(x):\(y)"}

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

typealias Box = Set<XY>

extension Box {
    func intersects(_ other: Set<XY>) -> Bool { !isDisjoint(with: other) }
}

func box(_ lt: (Int, Int), _ rb: (Int, Int)) -> Box {
    var b: Box = []
    
    for x in lt.0..<rb.0+1 {
        for y in lt.1..<rb.1+1 {
            if x >= 0 && y >= 0 { b.insert(XY(x, y)) }
        }
    }
    
    return b
}

extension RawRepresentable {
    var description: String { "\(rawValue)" }
}

public protocol OptionalType: ExpressibleByNilLiteral {
    associatedtype WrappedType
    var asOptional: WrappedType? { get }
}

extension Optional: OptionalType {
    public var asOptional: Wrapped? {
        return self
    }
}

func readLines(_ path: String) throws -> [String.SubSequence] {
    try readInput(path, "\n")
}

func readInput(_ path: String, _ separator: String) throws -> [String.SubSequence] {
    try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
      .split(separator: separator)
      .map({$0.filter({$0 != "\r" && $0 != "\n"})})
}

extension Array where Element: Numeric {
    var sum: Element { self.reduce(0, {(x:Element, y:Element) in x+y}) }
    var product: Element { self.reduce(1, {(x:Element, y:Element) in x*y}) }
}

extension Array where Element: OptionalType {
    var forced: [Element.WrappedType] { map({$0.asOptional!}) }
    var non_nil: [Element] { filter({$0.asOptional != nil}) }
}

extension String {
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }

    func parseInt(_ i: String.Index, _ j: String.Index) -> Int {
        Int(self[i..<j])!
    }

    func parseInt(_ i: Int, _ j: Int) -> Int {
        parseInt(index(startIndex, offsetBy: i), index(startIndex, offsetBy: j))
    }

    func search(_ it: String) -> Range<String.Index>? {
        self.range(of: it)
    }

    func rsearch(_ it: String) -> Range<String.Index>? {
        self.range(of: it, options: [.backwards])
    }

    func splitOnce(_ separator: Element) -> (String, String) {
        let ps = split(separator: separator, maxSplits: 1)
        return (String(ps[0]), String(ps[1]))
    }

    var int: Int { Int(trimmed)! }
}

func cosim(_ a: [Float], _ b: [Float]) -> Float {
    let dp = zip(a, b).map({$0.0*$0.1}).sum
    if dp == 0 { return 0 }
    let na = pow(a.map({$0*$0}).sum, 0.5)
    if na == 0 { return 1 }
    let nb = pow(b.map({$0*$0}).sum, 0.5)
    if nb == 0 { return 1 }
    return dp / (na*nb)
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

extension Int {
    var boolValue: Bool {
        return self != 0 
    }
}

extension String.SubSequence{
    var stringValue: String{
        return String(self)
    }
}

func +<T : Numeric> (x: (T, T), y: (T, T)) -> (T, T) {
    return (x.0 + y.0, x.1 + y.1)
}


struct Directions{
    static let up = (-1,0)
    static let down = (1,0)
    static let right = (0,1)
    static let left = (0,-1)
    static let upLeft = (-1,-1)
    static let upRight = (1,-1)
    static let downLeft = (-1,1)
    static let downRight = (1,1)
}