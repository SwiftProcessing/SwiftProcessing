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
 * behavior we would expect for modulo.
 * */

// =======================================================================
// MARK: - % OPERATOR OVERLOAD
// =======================================================================

public func % (left: Double, right: Double) -> Double {
    return left.truncatingRemainder(dividingBy: right)
}
