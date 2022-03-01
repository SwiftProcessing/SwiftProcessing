/*
 * SwiftProcessing: Operator Overloads
 *
 * This is to restore a more simple Double modulo
 * for learning basic coding. Since SwiftProcessing
 * is designed around Doubles, it's important to be
 * able to support a basic modulo that replicates
 * the standard behavior of a modulo operator.
 *
 * We are choosing to go with Swift's static
 * truncating remainder method, which gives the
 * behavior we would expect for modulo in Processing.
 * */

// =======================================================================
// MARK: - % OPERATOR OVERLOAD
// =======================================================================

public func % <L: Numeric, R: Numeric>(left: L, right: R) -> Double {
    let d_left: Double = left.convert()
    let d_right: Double = right.convert()
    return d_left.truncatingRemainder(dividingBy: d_right)
}

// =======================================================================
// MARK: - ARITHMETIC OPERATOR OVERLOADS
// =======================================================================

public func - <L: Numeric, R: Numeric>(left: L, right: R) -> Double {
    let d_left: Double = left.convert()
    let d_right: Double = right.convert()
    return d_left - d_right
}

public func + <L: Numeric, R: Numeric>(left: L, right: R) -> Double {
    let d_left: Double = left.convert()
    let d_right: Double = right.convert()
    return d_left + d_right
}

public func * <L: Numeric, R: Numeric>(left: L, right: R) -> Double {
    let d_left: Double = left.convert()
    let d_right: Double = right.convert()
    return d_left * d_right
}

public func / <L: Numeric, R: Numeric>(left: L, right: R) -> Double {
    let d_left: Double = left.convert()
    let d_right: Double = right.convert()
    return d_left / d_right
}

// =======================================================================
// MARK: - ARITHMETIC OPERATOR OVERLOADS FOR CHARACTERS
// =======================================================================

public func - (left: Character, right: Character) -> Int {
    let asciiValue_left: UInt8 = left.asciiValue!
    let asciiValue_right: UInt8 = right.asciiValue!
    return Int(asciiValue_left - asciiValue_right)
}

public func + (left: Character, right: Character) -> Int {
    let asciiValue_left: UInt8 = left.asciiValue!
    let asciiValue_right: UInt8 = right.asciiValue!
    return Int(asciiValue_left + asciiValue_right)
}

// =======================================================================
// MARK: - COMPARISON OPERATOR OVERLOADS
// =======================================================================

public func < <L: Numeric, R: Numeric>(left: L, right: R) -> Bool {
    let d_left: Double = left.convert()
    let d_right: Double = right.convert()
    return d_left < d_right
}

public func <= <L: Numeric, R: Numeric>(left: L, right: R) -> Bool {
    let d_left: Double = left.convert()
    let d_right: Double = right.convert()
    return d_left <= d_right
}

public func > <L: Numeric, R: Numeric>(left: L, right: R) -> Bool {
    let d_left: Double = left.convert()
    let d_right: Double = right.convert()
    return d_left > d_right
}

public func >= <L: Numeric, R: Numeric>(left: L, right: R) -> Bool {
    let d_left: Double = left.convert()
    let d_right: Double = right.convert()
    return d_left >= d_right
}
