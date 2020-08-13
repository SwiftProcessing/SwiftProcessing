/*
 https://github.com/raywenderlich/swift-algorithm-club
 */

public struct SketchSettingsStack {
  fileprivate var array = [SketchSettings]()

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

    public mutating func push(settings: SketchSettings) {
    array.append(settings)
  }

  public mutating func pop() -> SketchSettings? {
    if array.count == 0 {
              assertionFailure("Error: invalid call to pop")
    }
    return array.popLast()
  }

  public var top: SketchSettings? {
    return array.last
  }
    
    public mutating func cleanup(){
        self.array = [SketchSettings]()
    }
}
